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

	echo "New Question:     ${newList[rn1]}"
	echo "Current Question: ${currentList[rn2]}"
	echo "Retired Question: ${oldList[rn3]}"
	
	while true; do
		read -p "Did you complete the questions (y/n): " anw

		if [ $anw == "y" ]; then
			echo "Good Job!"
			
			echo "${newList[rn1]}" >>  ./completed.txt

			read -p "Would you like to move "${currentList[rn2]}" to the understood list y/n: " choice 

			if [ $choice == "y" ]; then
				echo "${currentList[rn2]}" >>  ./understand.txt

			break

		elif [ $anw == "n" ]; then

			echo "Good Luck tomorrow"
			break

		else 
			echo "Bad input"
		fi
	done
fi






