##--includes--                                                                                                           
source "funcs.sh"
source "rls_funcs.sh"

#------------------vars------------------
imok=1
#--------path--------
TempDirectory=/tmp/GenTargets
DirectoryTargets=$TempDirectory/Targets
logdir=./LOGS
#--------target_description_array--------
declare -a target_params
number_of_params=6

id_index=0
x_coord_index=1
y_coord_index=2
velocity_index=3
target_type_index=4
already_seen_index=5

target_counter=0
#--------log files--------
rm $logdir/rls0_log.txt 2>/dev/null
touch $logdir/rls0_log.txt

#rm $logdir/rls0_status.txt 2>/dev/null
touch $logdir/rls0_status.txt
#----------------------------------------

GetTargetsListAll

while :
do
	for target in $Targets
	do
		id=$(expr substr $target 11 6);
		getTargetCoords=$(tail $DirectoryTargets/$target 2>/dev/null); read_error=$?
		#если система уже проинедксировала цель в Targets а до следующей индексации скрипт гентаргет удалил
		#файл с этой целью будет ошибка открытия файла (значит цель сбита или умерал по времени) в этому случае
		#переходим к слудющему шагу цикла

		echo imok >$logdir/rls0_status.txt
 
		#дял корректного завершения процесса если запущен черех run_all
		GenTargets_pid=$(pgrep GenTargets.sh); gen_run=$?
		#echo $GenTargets_pid; 
		if (($gen_run != 0))
		then
			echo "процесс GenTarget убит. Завершаю rls0"
			exit 0
		fi
		sleep 0.1 #чтобы другие процессы могли зпуститься пока этот спит
		
		if (($read_error == 1))
		then
			continue
		fi
		isNewIDinList "$number_of_params" "$id"; target_index=$returnIdx
		
		target_coord=($getTargetCoords)
		
		if (($target_index == -1))
		then
			target_params[$id_index+$number_of_params*$target_counter]=$id
			target_params[$x_coord_index+$number_of_params*$target_counter]=${target_coord[0]}
			target_params[$y_coord_index+$number_of_params*$target_counter]=${target_coord[1]}
			target_params[$velocity_index+$number_of_params*$target_counter]=0
			target_params[$target_type_index+$number_of_params*$target_counter]=-1
			target_params[$already_seen_index+$number_of_params*$target_counter]=0
			#echo ${target_params[$id_index+$number_of_params*$target_counter]}
			#echo ${target_params[$x_coord_index+$number_of_params*$target_counter]}
			#echo ${target_params[$y_coord_index+$number_of_params*$target_counter]}
			#echo ${target_params[$velocity_index+$number_of_params*$target_counter]}

			target_index=$target_counter
			let target_counter+=1
		else
			if ((${target_params[$x_coord_index+$number_of_params*$target_index]} != ${target_coord[0]}))
			then
				if ((${target_params[$velocity_index+$number_of_params*$target_index]} == 0))
				then
					let target_params[$velocity_index+$number_of_params*$target_index]=${target_params[$x_coord_index+$number_of_params*$target_index]}-${target_coord[0]}
					
					TargetTypeBySpeed ${target_params[$velocity_index+$number_of_params*$target_index]}; target_params[$target_type_index+$number_of_params*$target_index]=$?
					#echo "скорость=${target_params[velocity_index+number_of_params*target_index]}  тип=${target_params[target_type_index+number_of_params*target_index]}"
				fi
				#echo ${target_params[$x_coord_index+$number_of_params*$target_counter]}
				#echo ${target_params[$y_coord_index+$number_of_params*$target_counter]}
				#если цель является ББ
				if ((${target_params[$target_type_index+$number_of_params*$target_index]} == 1))
                then
					RLS0Detection ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}
				fi
				target_params[$x_coord_index+$number_of_params*$target_index]=${target_coord[0]}
				target_params[$y_coord_index+$number_of_params*$target_index]=${target_coord[1]}
			fi
		fi
			
	done
	#в результате работы набегает много файлов в папке с целями, чтобы не индексирвать вообще все, т.к. в очень
    #старых файлах вообще нет смысла, экспериментально посмотрел что омжно брать
	#после первого прохода последние только 90 файлов
	GetTargetsListLastNinety

done
