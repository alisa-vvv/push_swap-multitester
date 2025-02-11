# push_swap-multitester
A shell script that allows you to automatically generate and run a massive amount of tests for the 42 push_swap project, and check the amount of operations used.\
You can run any amount of tests in specified value range. The script will count the operaions used for each generated input. It will display the average, minimum, and maximum amount of operations used. It will also run the linux_checker program to see of any of the inputs result in a "KO".\
Tests that result in a KO or use more operation than the specified threshold are saved so you can debug them.\
\
How to use:
1. Clone the repository or download the multitest.sh to any desired path. Make sure you put it in it's own separate directory since it will generate a lot of files and folders when used.
2. Run the script:

```
    multitest.sh
or
    ./multitest.sh
```

You can specify the parameters and flags immideately. Later steps will explain in more detail what each parameter does.\
If you don't enter any parameters, you will be prompted by the script to enter them one-by-one.

```
	./multitest.sh -[flags] [min_range-max_range] [amount_of_elemnts] [test_count] [threshold]
eg:
	./multitest.sh -c 1-100 100 250 700
```

(currently, the only flag you can use is -c, which will clean previous test results)\
\
3. When you use the script for the first time, it will prompt you to enter the path to the directory of your push_swap. You only have to enter the path once.
```
    Enter push_swap path: ~/
```
The directory has to contain your Makefile and the checker_linux file. If you want to use your own checker, just change the name in the script itself (line 60).\
The path you enter has to be relative to your home, for example, if your push_swap directory is:

```
    /home/projects/push_swap
```

   you should enter:

```
    projects/push_swap
```

   The script will create a file called ps_path.txt in in it's directory. You can edit the file directly if you want to change the path, or just create the file yourself.

4. You will be prompted to enter the range of values: 
```
    Enter the range (only pos. vals) (format. XX-XX):
```
   The range has to be positive. Example range: 1-100. Note that the script will never generate duplicate values.

5. You will be prompted to enter the amount of elements:

```
    Enter amount of elements:
```

6. You will be prompted to enter the amount of tests you want to run. Run as many as you want :)

```
    Enter tests count:
```

7. Lastly, you will be prompted to enter the fail threshold. You can find those in the project pdf and the evaluation sheet.

```
    Enter fail threshold:
```

The script will then rebuild your project using make and run the tests. Depending on the amount of tests and how fast your program is, this may take a while. You may see some messages about entering/exiting directories in the first few seconds. Besides that, unless you get "Error" messages from your project or the checker, the script will not show anything until it's finished.\
Once it's finished, you will see the results:

```
	Total tests run: 100
	Over the threshold: 28 cases
	KO'd: 0 cases
	Average operations used: 5384
	Max operations used: 5784
	Min operations used: 4913
```

If any tests KO'd or were over the operation threshold you set, the input used for those tests will be saved in KO_tests/ or falied_tests/ respectively, so you can use them for your input.\
\
The folders in failed_tests/ are named after the amount of operations your push_swap used to sort the list. Inside each folder, there are text files containing the corresponding input. Different inputs can result in the same amount of operations, so the files are named after the number of the test case that failed it.\
\
The folders in KO_tests/ are named after the number of test case that failed it. Each folder will contain the corresponding input.txt file.\
\
NOTE: This tester only checks operation count and the output of checker_linux program. It only generates tests that comply with project requirements. It will not check if your push_swap is properly protected against leaks, incorrect inputs, works properly with negative values, etc. In other words, this is not a Moulinette/Francinette equivalent.
