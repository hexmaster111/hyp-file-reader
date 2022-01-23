#!/bin/bash
source ./config.hycfg #read in id and type

echo "Reading file $1"

#copy our file into a good place to work with
rm -f $TEMP_FILE
touch $TEMP_FILE

is_comment() {
    if [[ "$1" =~ ^// ]]; then
        return 0 # Bash, lol
    else
        return 1
    fi
}

process_line() {
    local line="$1"
    local LINE_IN=0

    if is_comment "$line"; then
        return
    fi

    if [[ "$line" == *"%ID%"* ]] || [[ "$line" == *"%TYPE%"* ]]; then
	    echo $line | sed "s|%ID%|$ID|g; s|%TYPE%|$TYPE|g" >> $TEMP_FILE

    #if [[ "$line" == *"%TYPE%"* ]]; then
	#    echo $line | sed "s|%TYPE%|$TYPE|g" >> $TEMP_FILE
    #fi
    else

	    echo "$line" >> $TEMP_FILE
	fi
    }

READING=false

echo "parcing file"

while read -r l; do
    if [[ $l == '[START-OF-FILE]' ]]; then
        READING=true
    elif [[ $l == '[END-OF-FILE]' ]]; then
        READING=false
    elif $READING; then
        process_line "$l"
    fi
done <<< $(cat $1)

./tts.sh $TEMP_FILE
