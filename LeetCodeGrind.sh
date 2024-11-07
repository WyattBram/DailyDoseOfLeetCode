#!bin/bash

new=$(cat ./toDo.txt)
current=$(cat ./completed.txt)
old=$(cat ./understand.txt)

newList=()
currentList=()
oldList=()

IFS=$'\n'

for problem in $new; do
	newList+=($problem)
done

for problem in $current; do
	currentList+=($problem)
done

for problem in $old; do
	oldList+=($problem)
done

newlen=${#newList[@]}
currentlen=${#currentList[@]}
oldlen=${#oldList[@]}

if [ $newlen -lt 1 ]; then
	echo "You must populate toDo list"

elif [ $currentlen -lt 1 ]; then
	echo "You must populate completed list"

elif [ $oldlen -lt 1 ]; then
	echo "You must populate understand list"

else
	rn1=$((0 + $RANDOM % newlen))
	rn2=$((0 + $RANDOM % currentlen))
	rn3=$((0 + $RANDOM % oldlen))

	printf "\nNew Question:     ${newList[rn1]}"
	printf "\nCurrent Question: ${currentList[rn2]}"
	printf "\nRetired Question: ${oldList[rn3]}\n\n"
	
	while true; do
		read -p "Did you complete the questions (y/n): " anw
		
		if [ $anw == "y" ]; then
			

			echo "${newList[rn1]}" >>  ./completed.txt
			ex -s +"g/"${currentList[rn2]}"/d" -cwq ./toDo.txt

			printf "\n"

			read -p "Would you like to move \""${currentList[rn2]}"\" to the understood list y/n: " choice 
			
			if [ $choice == "y" ]; then
				printf "${currentList[rn2]}" >>  ./understand.txt
				ex -s +"g/"${currentList[rn2]}"/d" -cwq ./completed.txt

			fi
			break

		elif [ $anw == "n" ]; then

			printf "\nGood Luck tomorrow\n"
			break

		else 
			printf "\nBad input\n"
		fi
	done
fi






