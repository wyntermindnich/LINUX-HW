#!/bin/bash 

make_direct() {
	if [ ! -d todo ]; then
		cd ~/linuxHW 
		mkdir todo
	fi
	
	if [ ! -d complete ]; then 
		cd ~/linuxHW	
		mkdir complete
	fi
}
make_direct

menu_func () { 
 	list_func
}

list_func() { 
	display_item
	echo -e "\nWhat would you like to do?"
	echo "More information"
	echo "A. item is complete"
	echo "B. add new item"
	echo "C. see complete"
	echo -e "Q. Quit\n"
	task_input
}

add_todo() {
COUNTER=$(count_file)
COUNTER=$((COUNTER+1))
echo $COUNTER
		touch todo/$COUNTER.txt
		chmod 700 todo/$COUNTER.txt
		echo "$1" >> todo/$COUNTER.txt
		echo "$2" >> todo/$COUNTER.txt
}

add_complete() {
cd todo
pwd
C=$1
i=0
	for f in *.txt; do
		i=$((i+1))
	if [[ $i == $C ]]; then
		mv "$C.txt" "../complete/$C.txt"
	fi
	done
cd ..
display_complete
}

display_item() {
cd todo
	echo "Current items in todo list "
	file=$(ls *.txt)
	for f in $file; do
		echo $f	
		echo $(head -n 1 $f)
	done	
cd ..
}

display_complete() {
cd complete
	echo "Currecnt items complete list "
	file=$(ls *.txt)
	for f in $file; do
		echo $f
		echo $(head -n 1 $f)
	done
cd ..
}

more_info() {
cd todo 
	echo "File contents in todo list"
	file=$(ls *.txt)
	for f in $file; do
		echo $f
		cat $f
	done
cd ..

cd complete

	echo "File contents in complete list"
	file=$(ls *.txt)
	for f in $file; do
		echo $f
		cat $f
	done
cd ..
}

task_input() {
read -p "List a task " TASK
	if [ $TASK == "A" ]; then
	 echo $(count_file) items exits	
	 read -p "Which item is complete? " C
			if [ $C -gt 0 ]; then
		add_complete $C	
	fi
	elif [ $TASK == "B" ]; then
		read -p "Task? " TITLE
		read -p "Description? " BIO
		add_todo "$TITLE" "$BIO" 
		
	elif [ $TASK == "C" ]; then
		display_complete
	elif [ $TASK == "Q" ]; then
		exit
	elif [ $TASK == "M" ]; then
		more_info
	else 
		echo "ERROR"  
		help
fi
}

#count_complete() {
	#counts complete tasks }

count_file() {	
	FILECOUNT=$(ls ./todo | wc -l)
echo $FILECOUNT
}

help(){
	echo HELP INTERFACE
	echo ENTER A, B, C, OR Q TO FOLLOW COMMANDS
	echo ENTER M TO SEE ALL FILES AND DESCRIPTIONS
	list_func
}

display_menu(){
	list_func
	task_input
}

menu_func
display_menu 
