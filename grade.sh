CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

if [[ -f student-submission/ListExamples.java ]]
then 
    echo "file exists"
else
    echo "ListExamples.java does not exist"
    exit
fi

cp list-examples-grader/TestListExamples.java student-submission/ListExamples.java grading-area
cp -r list-examples-grader/lib grading-area

cd grading-area

javac -cp "$CPATH" *.java &> compile_list.txt
compile_list_exit=$?

# javac -cp ~/list-examples-grader/TestListExamples.java &> compile_test.txt
# compile_test_exit_test=$?

if [[ $compile_list_exit -eq 0 ]]; then
  echo "ListExamples.java compiled successfully."
else
  echo "ListExamples.java compilation failed. See compile_list.txt for details."
fi

# if [[ $compile_test_exit_test -eq 0 ]]; then
#   echo "TestListExamples.java compiled successfully."
# else
#   echo "TestListExamples.java compilation failed. See compile_output.txt for details."
# fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junit-output.txt
echo "DONE"
