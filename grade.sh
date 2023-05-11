CPATH='.;lib/hamcrest-core-1.3.jar;lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'


# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests

file = `find -name "ListExamples.java"`

if [[! -f $file]]
then 
echo "Not correct file submitted"
exit 1 
fi

cp -r ListExamples.java grading-area
cp -r lib grading-area

javac $file 2> CompileError.txt

if [[$? -ne 0]]
then
echo CompileError.txt
exit 1
fi

javac $CPATH TestListExamples.java
java $CPATH org.junit.runner.JUnitCore TestListExamples > results.txt

grep -n "OK" results.txt > success.txt
grep -n "Failure!!!" result.txt > failure.txt

if [[wc -l failure.txt -ne 0 ]]
then 
echo failure.txt

else
echo success.txt
fi
