#!/bin/bash 

make_direct() {
	if [ ! -d todo ]; then 
		mkdir ~/todo
		touch ~/todo/TODO.txt
		chmod ~/todo/TODO.txt
	fi
	
	if [ ! -d complete ]; then 
		mkdir ~/complete
		touch ~/complete/COMPLETE.txt
		chmod ~/complete/COMPLETE.txt
	fi
}
make_direct

menu_func () { 
 	list_func
	add_todo
	add_complete
}

list_func() { 
	echo -e "\nWhat would you like to do?"
	echo "More information"
	echo "A. item is complete"
	echo "B. add new item"
	echo "C. see complete"
	echo -e "Q. Quit\n"
	task_input
}

add_todo() {
echo $((count_file))
COUNTER=$((count_file))
	while [ $COUNTER -gt 0 ]; do
		touch $COUNTER
		chmod 700 $COUNTER
		echo "$1" >> ~/todo/$COUNTER.txt
		echo "$2" >> ~/todo/$COUNTER.txt
	break
done
}

add_complete() {
	mv "$1.txt" >> ~/complete/"*.txt"
}

#more_info(){ 
	#reads off every thing in the file }

display_item() {
COUNT=$((COUNT+1))

COUNTER=$((COUNTER+1))
	echo "Current items in list "
	while [ $COUNT -gt 0 ]; do
		echo $COUNT
		cat ./todo/$COUNTER.txt  
	break
	done 
}

display_complete() {
	echo "Currecnt items complete "
	while IFS= read -r line; do
		echo $line
	done < ~/complete/COMPLETE.txt
}

task_input() {
read -p "List a task " TASK
	if [ $TASK == "A" ]; then
		if [ $((COUNT)) > 0 ]; then
		display_item 
		echo $COUNTER	
	read -p "Which item is complete? " C
			if [ $C == "$COUNTER" ]; then
		add_complete $C
		fi	
	fi
	elif [ $TASK == "B" ]; then
		read -p "Task? " TITLE
		read -p "Description? " BIO
		add_todo "$TITLE" "$BIO" 
		
	elif [ $TASK == "C" ]; then
		display_complete
	elif [ $TASK == "Q" ]; then
		exit
	else 
		echo "ERROR"  
fi
}

#count_complete() {
	#counts complete tasks }

count_file() {	
	FILECOUNT=$(ls todo | wc -l)
echo $FILECOUNT
 }

display_menu(){
	list_func
	task_input
	more_info
}

menu_func
display_menu
