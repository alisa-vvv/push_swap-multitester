# push_swap-multitester
A shell script that allows you to automatically generate and run a massive amount of tests for the 42 push_swap project, and check the amount of operations used.\
You can run any amount of tests in specified value range. The script will count the operaions used for each generated input. It will display the average, minimum, and maximum amount of operations used. It will also run the linux_checker program to see of any of the inputs result in a "KO".\
\
How to use:
1. Clone the repository or download the multitester.sh to any desired path. Make sure you put it in it's own separate directory since it will generate a lot of files and folders when used.
2. Run the script:

```
    ./multitest.sh
```

4. When you use the script for the first time, it will prompt you to enter the directory of your push_swap:

```
    Enter push_swap path: ~/
```

   The directory has to contain your Makefile and the checker_linux file.\
   The path you enter has to be relative to your home, for example, if your push_swap directory is:
    ```
    /home/projects/push_swap
    ```
   you should enter:
```
    projects/push_swap
```

   The script will create a file called ps_path.txt in in it's directory. You can edit the file directly if you want to change the path, or just create the file yourself.
6. You will be prompted to enter the range of values: 
```
    Enter the range (only pos. vals) (format. XX-XX):
```
   The range has to be positive. Example range: 1-100. Note that the script will never generate duplicate values.
7. You will be prompted to enter the amount of elements:

```
    Enter amount of elements:
```

9. You will be prompted to enter the amount of tests you want to run. Run as many as you want :)

```
    Enter tests count:
```

11. Lastly, you will be prompted to enter the fail threshold. You can find those in the project pdf and the evaluation sheet.

```
    Enter fail threshold:
```

The script will then run your tests. Depending on the amount of tests and how your project is designed, this may take a while. The script will not show anything until it's finished.\
Once it's finished, you will see the results:

```
	Total tests run: 100
	Over the threshold: 28 cases
	KO'd: 0 cases
	Average operations used: 5384
	Max operations used: 5784
	Min operations used: 4913
```

If any tests KO'd or were over the operation threshold you set, the input used for those tests will be saved in /KO_tests or /falied_tests respectively, so you can use them for your input.\
\
The folders in failed_tests are named after the amount of operations your push_swap used to sort the list. Inside each folder, there are text files containing the corresponding input. Different inputs can result in the same amount of operations, so the files are named after the number of the test case that failed it.\
\
The folders in KO_tests are named after the number of test case that failed it. Each folder will contain the corresponding input.txt file.
