errorslog="error.log"
outputfile="output.txt"

if [ $# -eq 0 ]; then
	echo "Need CommandLine Arguments" >> $errorslog
	exit 1	
fi

function search(){
	opt=$1
	dir=$2
	key=$3
	if [ $opt = '-d' ]; then
		for file in "$dir/*"; do
			if [ -d $file ]; then
				search $opt $file $key
			elif [ -f $file ]; then
				temp=$(grep -n $key $file)
				if [ temp -gt 0 ]; then
					echo $key is present in the file $file
				fi
			fi
		done
	else
		grep -w "$key" "$dir" > $outputfile 
		echo "$key found in directory"
	fi
}

function help(){
cat << EOF
-d <directory> -> DIrectory to be searched
-k <keyword> -> Keyword to search
-f <file> -> Search for a keyword in a file
--help -> Show this help message
EOF
}

function regex(){
	if [[ -n $file && -f $file ]]; then
		echo "Error: File $file not exists" 
		exit 1
	fi
	if [[ -n $dir && ! -d $dir ]]; then
        	echo "Error: Directory '$dir' does not exist."
        	exit 1
    	fi
}
while getopts "d:k:f:-:" opt; do
    case "$opt" in
        d) dir="$OPTARG" ;;
        k) keyword="$OPTARG" ;;
        f) file="$OPTARG" ;;
        -)
        	case "$OPTARG" in
                help) help; exit 0 ;;
                *) echo "Unknown option --$OPTARG" ; exit 1 ;;
            esac
            ;;
        ?) echo "Invalid option. Use --help for usage." ; exit 1 ;;
    esac
done

regex

search $dir $key
