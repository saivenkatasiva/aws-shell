#!/bin/bash
ID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[31m"
N="\e[0m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE="/temp/$0-$TIMESTAMP.log

echo "script started excecuting at $0-$TIMESTAMP" &>> $LOGFILE

VALIDATE () {
    if ($1 -ne 0)
    then
        echo -e "$2...$R FAILED $N"
    else
        echo -e "$2...$G installation success $N"
    fi
}

if ($ID -ne 0)
then
    echo -e "$R ERROR, PLEASE LOGIN WITH ROOT USER $N"
else
    echo -e "$G you are a root user $N"
fi

  #echo "all arguments passed: $@"
#git mysql postfix net-tools

for package in $@
do
    yum list installed $package &>> $LOGFILE
    if [ $? -ne 0]
    then
        yum install $package -y &>> $LOGFILE
        VALIDATE $? "installation of $package"
    else
        echo -e "$package is already installed$Y skipping $N"
    fi
done