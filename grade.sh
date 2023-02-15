CPATH='.:../lib/hamcrest-core-1.3.jar:../lib/junit-4.13.2.jar'

rm -rf student-submission
git clone $1 student-submission
cd student-submission

if [[ -f ListExamples.java ]]
then 
    echo 'Found ListExamples.java'
else 
    echo 'need File ListExamples.java'
    exit 1
fi

cp ../TestListExamples.java ./

javac -cp $CPATH *.java 2>error-output.txt

if [ $? -ne 0 ] 
then
    echo 'could not compile'
fi 

if grep -qi "error: ';' expected" error-output.txt
then
    echo 'missing semicolon'
    echo 'fail'
    exit 1
fi

if grep -qi "static List<String> filter(List<String> list, StringChecker sc)" ListExamples.java
then 
    echo 'ok'
else 
    echo 'method header wrong'
    echo 'fail'
    exit 1
fi


java -cp $CPATH org.junit.runner.JUnitCore TestListExamples >output.txt 2>&1

echo 'output.txt'
cat output.txt

if grep -qi "Failure" output.txt 
then   
    echo 'fail'
else    
    echo 'pass'
fi




echo 'Finished cloning'