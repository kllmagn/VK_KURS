#----------------includes----------------                                                                                                           
source "funcs.sh"
source "zrdn_funcs.sh"

#------------------vars------------------
k=0
allow_kill_counter=0
#------------------path------------------
TempDirectory=/tmp/GenTargets
DirectoryTargets=$TempDirectory/Targets
DestroyDirectory=$TempDirectory/Destroy
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
#---------------log files----------------
rm $logdir/zrdn2_log.txt 2>/dev/null
touch $logdir/zrdn2_log.txt

rm -r try_kill_zrdn2/ 2>/dev/null
mkdir try_kill_zrdn2

rm $logdir/zrdn2_status.txt 2>/dev/null
touch $logdir/zrdn2_status.txt
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

		echo imok >$logdir/zrdn2_status.txt

		#дял корректного завершения процесса если запущен черех run_all
		GenTargets_pid=$(pgrep GenTargets.sh); gen_run=$?
		#echo $GenTargets_pid; 
		if (($gen_run != 0))
		then
			echo "процесс GenTarget убит. Завершаю zrdn2"
			exit 0
		fi

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
			target_params[$target_type_index+$number_of_params*$target_counter]=0
			target_params[$already_seen_index+$number_of_params*$target_counter]=0
			#echo ${target_params[$id_index+$number_of_params*$target_counter]}
			#echo ${target_params[$x_coord_index+$number_of_params*$target_counter]}
			#echo ${target_params[$y_coord_index+$number_of_params*$target_counter]}
			#echo ${target_params[$velocity_index+$number_of_params*$target_counter]}

			target_index=$target_counter
			let target_counter+=1
		else

			Targets_kill_list=$(ls -tr try_kill_zrdn2/ 2>/dev/null)
			# на каждой итерации проверям цели из списка на убийство с предыдущей итерации если имя цели снова проиндексировано системой
			# удаляем цель из списка на уничтожение, тогда система снова попытается её уничтожить и снова добавит в список
			for killed_targets in $Targets_kill_list
			do
				if [ "${target_params[$id_index+$number_of_params*$target_index]}" == "$killed_targets" ]
				then
					echo -e "ZRDN 2: \e[31mне удалось уничтожить \e[0mЦель ID:${target_params[$id_index+$number_of_params*$target_index]}"
					rm try_kill_zrdn2/${target_params[$id_index+$number_of_params*$target_index]}
				fi
			done

			if ((${target_params[$x_coord_index+$number_of_params*$target_index]} != ${target_coord[0]})) # если координаты изменились
			then
				if ((${target_params[$velocity_index+$number_of_params*$target_index]} == 0)) #если мы ещё не считали скорость
				then
                    #считаем скорость
					let target_params[$velocity_index+$number_of_params*$target_index]=${target_params[$x_coord_index+$number_of_params*$target_index]}-${target_coord[0]}
					# проводим распределение целей по типам по скорости
					TargetTypeBySpeed ${target_params[$velocity_index+$number_of_params*$target_index]}; target_params[$target_type_index+$number_of_params*$target_index]=$?
					#echo "скорость=${target_params[velocity_index+number_of_params*target_index]}  тип=${target_params[target_type_index+number_of_params*target_index]}"
				fi
                #echo ${target_params[$x_coord_index+$number_of_params*$target_counter]}
                #echo ${target_params[$y_coord_index+$number_of_params*$target_counter]}
                
                #если цель не ББ
                if ((${target_params[$target_type_index+$number_of_params*$target_index]} != 1))
                then
                    #проверяем попадает ли цель с текущими координатами в зону действия СПРО
                    ZRDN2Detection ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}
                fi

                #Если цель попадала в зону действия ЗРДН
                if ((${target_params[$already_seen_index+$number_of_params*$target_index]} != 0))
                then
                    #Если цель является ракетой или самолетом
                    if ((${target_params[$target_type_index+$number_of_params*$target_index]} == 2)) || ((${target_params[$target_type_index+$number_of_params*$target_index]} == 3))
                    then
                        touch "$DestroyDirectory/${target_params[$id_index+$number_of_params*$target_index]}"
						# в папке с предполагаемыми на убийство целями создаем файл с именем=id цели
						touch "try_kill_zrdn2/${target_params[$id_index+$number_of_params*$target_index]}"
                        #на экран
                        echo -e "ZRDN 2: \e[93mпопытка уничтожить \e[0mЦель ID:${target_params[$id_index+$number_of_params*$target_index]}"
                        #в лог
                        echo -e "ZRDN 2: \e[93mпопытка уничтожить \e[0mЦель ID:${target_params[$id_index+$number_of_params*$target_index]}" >>$logdir/zrdn2_log.txt
						let allow_kill_counter=1
					fi
                fi
                #обновлем координаты цели в структуре описания цели
                target_params[$x_coord_index+$number_of_params*$target_index]=${target_coord[0]}
                target_params[$y_coord_index+$number_of_params*$target_index]=${target_coord[1]}
			fi
		fi
	done
	#получаем список целей из папки, с целями на уничтожение
	Targets_kill_list=$(ls -tr try_kill_zrdn2/ 2>/dev/null)
	
	#логическое условие чтобы выводить только со следующий после первых обнаружений итерации иначе до не с чем сравнить
	if (($k > 0))
	then
		for killed_targets in $Targets_kill_list
		do
			echo -e "ZRDN 2: \e[32mуничтожена \e[0mЦель ID:$killed_targets"
			#в лог
			echo -e "ZRDN 2: \e[32mуничтожена \e[0mЦель ID:$killed_targets" >>$logdir/zrdn2_log.txt
			rm try_kill_zrdn2/$killed_targets #убираем из папки истинно уничтоженные цели
		done
	fi
	if (($allow_kill_counter == 1)) #разрешаем отслеживание следующей от обнаружения итерации только после первых обнаружений
	then
		let k+=1
	fi

    #в результате работы набегает много файлов в папке с целями, чтобы не индексирвать вообще все, т.к. в очень
    #старых файлах вообще нет смысла, экспериментально посмотрел что омжно брать
	#после первого прохода последние только 90 файлов
	GetTargetsListLastNinety

	sleep 0.1 #чтобы другие процессы могли зпуститься пока этот спит
done
