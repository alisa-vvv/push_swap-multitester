if [ ! -f ps_path.txt ]
then
	touch ps_path.txt
	read -p "Enter push_swap path: ~/" ps_path
	echo "$ps_path" > ps_path.txt
else
	ps_path=`cat ps_path.txt`
fi
ps_path=${HOME}/${ps_path}
#Prompt for user to enter the values
read -p "enter the range (only pos. vals) (format. XX-XX): " range
read -p "enter amount of elements: " amount
read -p "enter tests count: " tests_count
read -p "enter fail threshhold: " max
#Rebuild the project
make -C "$ps_path" fclean
make -C "$ps_path" all
#Check if an output file exists and creates empty one, creates dirs
if [ -e multitest_out.txt ]
then
	rm multitest_out.txt
fi
touch multitest_out.txt

mkdir -p failed_tests
mkdir -p KO_tests
#setting up counters
i=0
over_threshold=0
ko=0
#This while loop will run he test tests_count times
while [ $i -lt $tests_count ]
do
	#checks if an input exists and creates empty one
	if [ -e input.txt ]
	then
		rm input.txt
	fi
	touch input.txt
	#Uses shuf tp generate [amount] random values in [range]
	#Replaces newlines with spaces for valid argv input
	#Runs the test, writes output to ops and counts lines
	shuf -i "$range" -n $amount >> input.txt
	sed -i ':a;N;$!ba;s/\n/ /g' input.txt
	${ps_path}/./push_swap `cat input.txt` | tee ops | wc -l >> multitest_out.txt
	#Checks if line count is bigger than max, saves the input
	#that produced the output in a folder named after line count
	#adds to the counter of failed tests
	if [ "$(tail -n 1 multitest_out.txt)" -gt $max ]
	then
		mkdir -p failed_tests/$(tail -n 1 multitest_out.txt)
		cp input.txt failed_tests/$(tail -n 1 multitest_out.txt)/${i}
		true $((over_threshold=over_threshold+1))
	fi
	#Checks if test was KO'd, saves the KO'd input
	#adds to the counter of KO'd inputs
	cat ops | ${ps_path}/checker_linux `cat input.txt` > OK_KO
	if [ "`cat OK_KO`" = "KO" ]
	then
		mkdir -p mkdir -p KO_tests/$(i)
		cp OK_KO KO_tests/$(i)
		true $((ko=ko+1))
	fi
	true $((i=i+1))
done
echo "Total tests run: $tests_count"
echo "Over the threshold: $over_threshold cases"
echo "KO'd: $ko cases"
#This awk script will count min, max and avg opcount across the tests
cat multitest_out.txt | awk -v sum=0 -v min='head -n 1 multitest_out.txt' -v max=$min '
	{
		sum += $1
		if (min > $1 && $1 != 0) min = $1
		if (max < $1 && $1 != 0) max = $1
	}
	END {
		printf "Average operations used: %d\n", sum / NR
		printf "Max operations used: %d\n", max
		printf "Min operations used: %d\n", min
	}'
