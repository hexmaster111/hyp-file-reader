#!/bin/bash

TEMP_SOUND="/tmp/hypno.wav"

LOADING_MSG="Loading communication modual"
LOADING_DONE_MSG="loading compleate. Starting file"

echo $LOADING_MSG |  espeak-ng -xm 

#using coqui-at TTS
#THIS SOUNDS AMAZING AND WORKS WELL OUT OF THE BOX
tts --text "$(< $1)" --out_path $TEMP_SOUND
echo $LOADING_DONE_MSG | espeak-ng -xm
aplay $TEMP_SOUND


#using espeek
#cat $1 |  espeak-ng -xm

#using pico2wave
#cat $1 | pico2wave -w="$TEMP_SOUND"
#aplay $TEMP_SOUND
#rm $TEMP_SOUND
echo "playback done"

