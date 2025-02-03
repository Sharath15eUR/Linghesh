file="$1"
touch output.txt
while read line; do
	if [[ "$line" == *"\"frame.time\""* ]]; then
		echo "$line" >> output.txt
	fi
	if [[ "$line" == *"\"wlan.fc.type\""* ]]; then
		echo "$line" >> output.txt
	fi
	if [[ "$line" == *"\"wlan.fc.subtype\""* ]]; then
		echo "$line" >> output.txt
	fi
done < "$file"
echo "Executed Succesfully"
