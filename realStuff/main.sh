#!/bin/bash
source ./config.hycfg #read in id and type

#where our temp file goes
TEMP_FILE="/tmp/hypno.tmp"

SOF="[START-OF-FILE]"
EOF="[END-OF-FILE]"



#just for testing
echo "$TYPE"
echo "$ID"

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

    if is_comment "$line"; then
        return
    fi

    if [[ "$line" == *"%ID%"* ]]; then
	    echo "I FOUND AN ID!!"
	    echo $line | sed "s|%ID%|$ID|g" >> $TEMP_FILE
   
    elif [[ "$line" == *"%TYPE%"* ]]; then
	    echo "FOUND A TYPE"
	    echo $line | sed "s|%TYPE%|$TYPE|g" >> $TEMP_FILE
    else
	    echo "$line" >> $TEMP_FILE
    fi
}

READING=false

while read -r l; do
    if [[ $l == '[START-OF-FILE]' ]]; then
        READING=true
    elif [[ $l == '[END-OF-FILE]' ]]; then
        READING=false
    elif $READING; then
        process_line "$l"
    fi
done <<< $(cat $1)

echo "RUN SOMETHING COOL"
#do tts or something ... figure this out