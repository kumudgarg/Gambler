#!/bin/bash -x
BETS=1
DAY=30
perDayPlayAmount=100
cashAmount=$perDayPlayAmount
finalStake=0
maxWinLimit=0
minLooseLimit=0
stakePercent=50
percentAmountOfStake=0
totalAmountWinLoose=0
wonDays=0
looseDays=0
declare -A dayInfo
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
		dayInfo["day $day"]=$(( $cashAmount - $perDayPlayAmount ))
		totalAmountWinLoose=$(( $totalAmountWinLoose + ${dayInfo["day $day"]} ))
	done 
}
function stackPercent
{
	percentAmountOfStake=$(( $(( perDayPlayAmount * stakePercent ))/100 ))
	maxWinLimit=$(( perDayPlayAmount + percentAmountOfStake ))
	minLooseLimit=$(( perDayPlayAmount - percentAmountOfStake )) 
}
function dayWiseWonLoose()
{
	for (( day=0; day<=$DAY; day++ ))
	do
		if [ ${dayInfo["day $day"]} -gt 0 ]
		then 
			(( wonDays++ ))
		else
			(( looseDays++ ))
		fi
	done
	amountWin=$(( wonDays * percentAmountOfStake ))
	amountLoose=$((looseDays * percentAmountOfStake ))
}

gamblingPlay
dayWiseWonLoose
echo "final stake are $initialStake "
echo "maximum win limit $maxWinLimit "
echo "minimum loose limit $minLooseLimit "
echo "total amount win / loose $totalAmountWinLoose"
echo " ${dayInfo[@]}"

echo "win days are $wonDays and total amount of $wonDays are $amountWin "
echo "win days are $looseDays and total amount of $looseDays are $amountLoose " 
 

