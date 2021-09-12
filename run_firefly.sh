#!/bin/bash

# IMPORTANT: Inputs must be without .in or .inp, not even space in name

# If you are using an outdated version of Firefly, please insert the new one at line 70 

# Usage:
# First, give permission for execution: chmod 777 run_firefly.sh
# Then you can run this script: ./run_firefly.sh

#--------------------------- Functions list -------------------------------#
# Checking if input directory exists #
InputDir () {
  	printf "\n\t"
    printf "·%.0s" {1..60}
    printf "\n\t"
    if [[ -d inputs ]]; then
	    printf "\n\t\t       Directory for inputs found."
    else
  	    printf "\n\t"
	    printf "·%.0s" {1..60}
	    printf "\n\t\tDirectory for inputs not found, creating..."
	    mkdir inputs
    fi
}

# Counting files inside input directory #

EmptyInputDir () {
    printf "\n\t"
	printf "\n\t\t   Please, insert files to calculate!"
  	date_day=$( date +%m-%d-%Y )
 	date_time=$( date +%T )

    printf "\n\t"
    printf "·%.0s" {1..60}
    printf "\n\n\t\tJob finished at : %10s  -  %8s\n\n\t" $date_day $date_time
    printf "·%.0s" {1..60}
    printf "\n"
	exit
}

# Checking if results directory exists #

ResultsDir () {
	if [[ ! -d ./results ]]; then
       printf "\n\n\t"
	   printf "·%.0s" {1..60}
       printf "\n\t"
	   printf "\n\t\tDirectory for results not found, creating...\n\n\t"
	   printf "·%.0s" {1..60}
       printf "\n\t"
       mkdir results
    else
  	   printf "\n\n\t"
       printf "·%.0s" {1..60}
	   printf "\n\n\t\t    Starting calculations...Good luck.\n\n\t"
       printf "·%.0s" {1..60}
  	   printf "\n\t"
	fi
}

# Calling firefly calculations #
RunFirefly () {
	path=$(pwd) 
	cd inputs
	for files in $(ls); do # Executing firefly # 
        printf "\n\t\tCalculating "$files"\n\t"
		mv $files input
		$path/firefly* > $files.out
		mv $files.out ../results
		mv input $files
        CheckOutputs
	done
}

# Checking files that may be erased #

CheckOutputs () {
    hessian=$( grep -c "HESSIAN" $files )
    uhf=$( grep -c "UHF" $files )
    rohf=$( grep -c "ROHF" $files )
    if [[ $hessian != 0 ]]; then
        if [[ $uhf != 0 ]]; then
            rm IRCDATA
            #continue
        elif [[ $rohf != 0 ]]; then
            rm MOINTS
            rm FOCKDER
        else
            rm FOCKDER
        fi
    fi
    rm AOINTS
    rm DICTNRY
    rm PUNCH
}

# Mv files already calculated #

FinishedFiles () {
    cd ..
    if [[ ! -d finished ]]; then
        mkdir finished
    fi
    find ./inputs -type f -exec mv {} ./finished \;
}

# Tail infos #

TailInfo () {
    date_day=$( date +%m-%d-%Y )
    date_time=$( date +%T )

    printf "\n\t"
    printf "·%.0s" {1..60}
    printf "\n\n\t\t Job finished at : %10s  -  %8s\n\n\t" $date_day $date_time
    printf "\n\n\t\t          Check directory results.\n\n\t"
    printf "·%.0s" {1..60}
    printf "\n"
}
#--------------------------------------------------------------------------#

#----------------------------- Job sequence -------------------------------#
InputDir
number_files=$(find ./inputs -type f | wc -l)
if [[ $number_files -eq 0 ]]; then
    EmptyInputDir
else
    ResultsDir
    RunFirefly
fi
FinishedFiles
TailInfo
#---------------------------- Job finished --------------------------------#


