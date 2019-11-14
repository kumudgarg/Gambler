#!/bin/bash -x
bets=1
stake=100
win=0
loose=0
if [ $(( RANDOM%2 )) -ge 0 ]
then 
	(( win++ ))
else
	(( loose++ ))
fi
echo " $win $loose " 
