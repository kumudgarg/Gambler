#!/bin/bash -x
#<----------CONSTANTS--------------->
BETS=1
DAY=20
PERDAYAMOUNT=100
STAKEPERCENT=50
#<--------VARIABLES----------------->
percentAmountOfStake=$(( $(( PERDAYAMOUNT * STAKEPERCENT ))/100 ))
maxWinLimit=$(( PERDAYAMOUNT + percentAmountOfStake ))
minLooseLimit=$(( PERDAYAMOUNT - percentAmountOfStake )) 
totalAmountPerDay=0
wonDays=0
looseDays=0
luckyDay=0
unluckyDay=0
totalAmount=0
stake=0
declare -A dayWiseAmountInfo
declare -A luckyUnlucky
function gamblingPlay()
{ 
	stake=$PERDAYAMOUNT
	while [ $stake -lt $maxWinLimit ] && [ $stake -gt $minLooseLimit ]
	do
		if [ $(( RANDOM%2 )) -eq 0 ]
		then
			stake=$(( $stake + $BETS ))
		else
			stake=$(( $stake - $BETS ))
		fi
	done
}

function monthlyBet()
{
	for (( day=1; day <= $DAY; day++ )) 
	do
		gamblingPlay
		totalAmountPerDay=0
	   dayWiseAmountInfo[$day]=$(( $stake - $PERDAYAMOUNT ))
	   totalAmountPerDay=$(( $toalAmountPerDay + ${dayWiseAmountInfo[$day]} ))
	   echo "Total amount per day $totalAmountPerDay"
		totalAmount=$(( totalAmount+totalAmountPerDay ))
	   luckyUnlucky[$day]=$totalAmount
	done
}

function dayWiseWonLoose()
{
	for (( day=1; day<=$DAY; day++ ))
	do
		if [ ${dayWiseAmountInfo[$day]} -gt 0 ]
		then 
			(( wonDays++ ))
		else
			(( looseDays++ ))
		fi
	done
	amountWin=$(( wonDays * percentAmountOfStake ))
	amountLoose=$((looseDays * percentAmountOfStake ))
}
function luckyUnluckyDay()
{
	luckyDay=$( printf "%s\n" ${luckyUnlucky[@]} | sort -nr | head -1 )
	unluckyDay=$( printf "%s\n" ${luckyUnlucky[@]} | sort -nr | tail -1 )
   for data in "${!luckyUnlucky[@]}"
    do
	    if [[ ${luckyUnlucky[$data]} -eq luckyDay ]]
	    then
	    	echo "Lucky Day $data by $luckyDay"
		 elif [[ ${luckyUnlucky[$data]} -eq unluckyDay ]]
		 then
				 echo "Lucky Day $data by $UnluckyDay"

	    fi
    done

}
while [ true ]
do
	if [ $totalAmountPerDay -lt 0 ]
	then
		break
	fi
	monthlyBet
	dayWiseWonLoose
	luckyUnluckyDay
done
         echo "total amount win / loose $totalAmount"
         echo "win days are $wonDays and total amount of $wonDays are $amountWin "
         echo "loose days are $looseDays and total amount of $looseDays are $amountLoose " 
      

