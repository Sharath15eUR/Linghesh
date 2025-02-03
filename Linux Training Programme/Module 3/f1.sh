#!/usr/bin/bash

if [ "$#" -ne 3 ]; then
	echo "Need 3 Commandline arguments"
	exit 1
fi
s=$1
d=$2
t=$3

echo "Source Directory: $s"
echo "Backup Directory: $d"
echo "File Type: $t"

Files=($s/*)

export BCOUNT=0
Total_size=0

for f in ${Files[@]}; do
	size=$(stat -c %s $f)
	echo "$f $size"
done
if [ ! -d $d ];then
	mkdir $d
	echo "Creating Backup Directory"
fi

if [ ${#Files} -eq 0 ]; then
	echo "The source directory is empty"
	exit 1
fi


echo "Backing Up Files..."
for f in ${Files[@]}; do
	cp $f $d
	BCOUNT=$((BCOUNT+1))
	size=$(stat -c %s $f)
	Total_size=$((Total_size+size))
	#echo $BCOUNT $size $Total_size
done

echo "Backup Ready and backup report generated"
touch $d/backup_report.log


echo "Backup Files Count: $BCOUNT" > $d/backup_report.log
echo "Total Size of Backup Files: $Total_size" >> $d/backup_report.log
echo "Backup Directory: $d" >> $d/backup_report.log

cat $d/backup_report.log
