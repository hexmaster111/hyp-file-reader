#!/bin/bash

#TODO

#Read in hypno file, 
# adjust the %ID% and %TYPE% values and start reading at [START-OF-FILE]
#into [END-OF-FILE] then save that into a temp file
# Save this to temp file then pico2vame and play it


pico2wave -w=/tmp/test.wav "$1"
aplay /tmp/test.wav
rm /tmp/test.wav
