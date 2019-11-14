#!/bin/bash -x
BETS=1
STAKE=100
initialStake=$STAKE
max_win_limit=0
min_loose_limit=0
stake_percent=50
function gamblingPlay()
{
	stackPercent
	while [ $initialStake -lt $max_win_limit ] && [ $initialStake -gt $min_loose_limit ]
	do
		  
		if [ $(( RANDOM%2 )) -eq 0 ]
		then 
			(( initialStake++ ))	
		else
			(( initialStake-- ))
		fi
	done 
	}
function stackPercent
{
	max_win_limit=$(( $(( STAKE * $(( STAKE + stake_percent ))  ))/100 )) 
	min_loose_limit=$(( $(( STAKE * $(( STAKE - stake_percent )) ))/100 ))
}
gamblingPlay
echo "final stake are $initialStake "
echo "maximum win limit $max_win_limit "
echo "minimum loose limit $min_loose_limit "

