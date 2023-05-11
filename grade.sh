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

file=`find student-submission/ListExamples.java`

if [[ (! -f $file) ]]
then 
echo "Not correct file submitted"
exit 1 
fi


cp -r $file grading-area
cp -r lib grading-area
cp -r *.java grading-area

cd grading-area

javac -cp $CPATH *.java 2> CompileError.txt

if [[ ($? -ne 0) ]]
then
cat CompileError.txt
exit 1
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > results.txt

grep -i "OK" results.txt > success.txt
grep -i "Failure" results.txt > failure.txt


echo `cat failure.txt`


echo `cat success.txt`
