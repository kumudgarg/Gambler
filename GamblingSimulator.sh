#!/bin/bash -x
BETS=1
STAKE=100
initialStake=$STAKE
if [ $(( RANDOM%2 )) -eq 0 ]
then 
	(( initialStake++ ))	
else
	(( initialStake-- ))
fi
echo " $initialStake " 
