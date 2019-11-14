#!/bin/bash -x
BETS=1
DAY=20
perDayPlayAmount=100
cashAmount=$perDayPlayAmount
finalStake=0
maxWinLimit=0
minLooseLimit=0
stakePercent=50
percentAmountOfStake=0
totalAmountWinLoose=0
function gamblingPlay()
{
	stackPercent
	for(( day=1; day <= $DAY; day++ )) 
	do
		cashAmount=$perDayPlayAmount
		while [ $cashAmount -lt $maxWinLimit ] && [ $cashAmount -gt $minLooseLimit ]
		do
			  
			if [ $(( RANDOM%2 )) -eq 0 ]
			then 
				cashAmount=$(( $cashAmount + $BETS ))
			else
				cashAmount=$(( $cashAmount - $BETS ))
			fi
		done
		totalAmountWinLoose=$(( $totalAmountWinLoose + ( $cashAmount - $perDayPlayAmount ) ))
	done 
}
function stackPercent
{
	percentAmountOfStake=$(( $(( perDayPlayAmount * stakePercent ))/100 ))
	maxWinLimit=$(( perDayPlayAmount + percentAmountOfStake ))
	minLooseLimit=$(( perDayPlayAmount - percentAmountOfStake )) 
}
gamblingPlay
echo "final stake are $initialStake "
echo "maximum win limit $maxWinLimit "
echo "minimum loose limit $minLooseLimit "
echo "total amount win / loose $totalAmountWinLoose"

