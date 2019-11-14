#!/bin/bash -x
BETS=1
STAKE=100
initialStake=$STAKE
maxWinLimit=0
minLooseLimit=0
stake_percent=50
percentAmountOfStake=0
function gamblingPlay()
{
	stackPercent
	while [ $initialStake -lt $maxWinLimit ] && [ $initialStake -gt $minLooseLimit ]
	do
		  
		if [ $(( RANDOM%2 )) -eq 0 ]
		then 
			initialStake=$(( initialStake + BETS ))	
		else
			initialStake=$(( initialStake - BETS ))
		fi
	done 
	}
function stackPercent
{
	percentAmountOfStake=$(( $(( STAKE * stake_percent ))/100 ))
	maxWinLimit=$(( STAKE + percentAmountOfStake ))
	minLooseLimit=$(( STAKE - percentAmountOfStake )) 
}
gamblingPlay
echo "final stake are $initialStake "
echo "maximum win limit $maxWinLimit "
echo "minimum loose limit $minLooseLimit "

