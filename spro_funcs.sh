
declare -a SPRO

#1
SPRO[0+3*0]=3250 #x
SPRO[1+3*0]=3400 #y
SPRO[2+3*0]=1000 #r old 1000

#---------------------SPRO--------------------
function SPRODetection
{
    how_many_spro=1
    #координаты цели
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=0
    while [[ "$i" < "$how_many_spro" ]]
    do
        checkinCircle $i $X $Y; spotted=$?
        
        if (($spotted == 1))
        then
            
            if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0)) #на экран пишем один раз
            then
                echo "SPRO $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
            fi
            target_params[$already_seen_index+$number_of_params*$target_index]=1
            #в лог пишем все обнаружения всегда
            echo "SPRO $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/spro_log.txt
        fi
        let i+=1
    done
}

function checkinCircle()
{
    i=$1
	local X=$2
	local Y=$3

    ((x1=-1*${SPRO[0+3*$i]}+$X))
    ((y1=-1*${SPRO[1+3*$i]}+$Y))
	
	local r1_=$(echo "sqrt ( (($x1*$x1+$y1*$y1)) )" | bc -l)
	r1=${r1_/\.*}

    if (( $r1 <= ${SPRO[2+3*$i]} ))
    then
        return 1
    fi

	return 0
}