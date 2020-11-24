#!/bin/bash
#================================================================================#
# Author:- Rahul Dcosta(1337) & Kaushal Kishore (1357)                		 #
# Description:-Shell Script to Compare two files and report if they are different#
# Date Created:-25/01/2014                                            		 #
# Date Modified:-01/02/2014                            		      		 #
#================================================================================#

#==========Silent Function=============#
silent () {	
  		if [ `cmp $1 $2 2>err | wc -l` -eq 1 -o `cat err | wc -l` -eq 1 ]
			then
				echo -e "$1 & $2 are Different\n"
				
				else
				echo -e "$1 & $2 are Same\n"
			fi
		rm err
}
#==========differ Function=============#
differ () {
	if [ -f $1 -a -f $2 ] 
	then	
 max1=`cat $1 | wc -l`
 max2=`cat $2 | wc -l`
 limit=$max1
 flag=1
if [ $max2 -gt $max1 ]
then
	limit=$max2
fi

       for (( i=1;i<=limit;i++ ))

	do
	   	line1=$(awk 'BEGIN{FS="\n"}{if(NR=='$i')print $0}' $1)
		
		
		line2=$(awk 'BEGIN{FS="\n"}{if(NR=='$i')print $0}' $2)
		
			if [ "$line1" != "$line2" ]

			then	
				if [ $flag -eq 1 ]
				then
				echo -e "=========Difference Mode==========\n"
				echo "These line are different"
				 flag=0				
				fi	
				printf "Line No: $i\n $line1 \n $line2 \n"				 
				
			fi
	done
                 printf "\n\n"
else

 echo "$0:$1 No such File ,$2 No Such File"
fi
}


#========Start of Shell Script=========#
if [ $# -gt 0 -a $# -lt 4 ]
then

if [ `echo $1 | grep -E ^-[hdsa]*$ |wc -l` -eq 1 ] 
then
va="$1"
len=$(echo ${#va} )
counth=0
countd=0
counts=0
counta=0
if [ "`echo ${va:0:1}`" = "-" -a $len -gt 1 ]
   then
for (( zb=1;zb<len;zb++ ))
do
   var=$(echo ${va:$zb:1})
	
if [ "$var" = "h" ]
   then
	let counth++
fi
if [ "$var" = "s" ]
   then
	let counts++
fi
if [ "$var" = "d" ]
   then
	let countd++
fi
if [ "$var" = "a" ]
   then
	let counta++
fi

done
if [ $counta -gt 1 -o $counth -gt 1 -o $countd -gt 1  -o $counts -gt 1 ]
   then
	echo "$0:$1 invalid option usage"
	exit
fi
	
for (( zb=1;zb<len;zb++ ))
do
   var=$(echo ${va:$zb:1})


case $var in

	h) 
	if [ $# -eq 1 -a $len -eq 2 ]
	then	
	cat help.txt 
	else
	echo "$0:$1 invalid option usage"
	exit
	fi
	;;
	d) 
	if [ $# -eq 3 -a `echo $va | grep h | wc -l` -eq 0 ]
	then	
	differ $2 $3 
	else
	echo "$0:$1 invalid option usage"
	exit
	fi
		
;;
	s) 
	if [ $# -eq 3 -a `echo $va | grep h | wc -l` -eq 0 ]
	then	
	silent $2 $3
	else
	echo "$0:$1 invalid option usage"
	exit
	fi
			


;;
	a) 
		if [ $len -gt 2 -a $# -eq 3 -a `echo $va | grep h | wc -l` -eq 0 ]
		then
			if [ ! -f $2 ]
			then
				echo "$0:$2 No Such File"
				exit
			fi
		echo -e "=========All Mode==========\n"
		 for z in `find . -name $2 -prune -o -type f -exec ls {} \;`
		do
		if [ -f $z ]
		then
		
			silent $2 $z
		fi
		done
		elif [ $len -eq 2 -a $# -eq 2 ] 
		then
			if [ ! -f $2 ]
			then
				echo "$0:$2 No Such File"
				exit
			fi 
			for z in `find . -name $2 -prune -o -type f -exec ls {} \;`
		do
		if [ -f $z ]
		then
		
			silent $2 $z
		fi
		done

		else
			echo "$0: $1 invalid option usage"
			exit
		fi
		;;
	
        *)  silent $2 $3 ;;

esac
done

else
 echo "$0:Invalid Option ,Please use $0 -h for help"
	exit          
fi
elif [ -f $1 -a -f $2 ]
then
	if [ $# -eq 2 ]
	then
	silent $1 $2
	else
	echo "$0:Invalid No. of Arguments"
	fi
 else
 echo "==>$0:Invalid Option ,Please use $0 -h for help"
	exit

fi
else
	 echo "$0:Invalid No. of Arguments"

fi
#========END of Shell Script=========#
