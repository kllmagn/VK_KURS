
declare -a ZRDN
#1
ZRDN[0+3*0]=3237 #x
ZRDN[1+3*0]=2697 #y
ZRDN[2+3*0]=600 #r

#2
ZRDN[0+3*1]=2698 #x
ZRDN[1+3*1]=2843 #y
ZRDN[2+3*1]=400 #r

#3
ZRDN[0+3*2]=4294 #x
ZRDN[1+3*2]=3360 #y
ZRDN[2+3*2]=550 #r

#---------------------ZRDN--------------------
function ZRDN0Detection
{
    #координаты цели
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=0
 
    checkinCircle $i $X $Y; spotted=$?
    
    if (($spotted == 1))
    then

        if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0))
        then
            #на экран пишем первое обнаружение
            echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
            " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
            #при первом обнаружении записываем что ЗРДН обнаружил цель
            target_params[$already_seen_index+$number_of_params*$target_index]=1
        fi    
        #в лог пишем все обнаружения             
        echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
        " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/zrdn0_log.txt
    fi
}
function ZRDN1Detection
{
    #координаты цели
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=1
 
    checkinCircle $i $X $Y; spotted=$?
    
    if (($spotted == 1))
    then

        if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0))
        then
            #на экран пишем первое обнаружение
            echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
            " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
            #при первом обнаружении записываем что ЗРДН обнаружил цель
            target_params[$already_seen_index+$number_of_params*$target_index]=1
        fi    
        #в лог пишем все обнаружения             
        echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
        " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/zrdn1_log.txt
    fi
}
function ZRDN2Detection
{
    #координаты цели
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=2
 
    checkinCircle $i $X $Y; spotted=$?
    
    if (($spotted == 1))
    then

        if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0))
        then
            #на экран пишем первое обнаружение
            echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
            " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
            #при первом обнаружении записываем что ЗРДН обнаружил цель
            target_params[$already_seen_index+$number_of_params*$target_index]=1
        fi    
        #в лог пишем все обнаружения             
        echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
        " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/zrdn2_log.txt
    fi
}

function ZRDNDetection
{
    how_many_zrdn=3
    #координаты цели
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=0
    while [[ "$i" < "$how_many_zrdn" ]]
    do
        checkinCircle $i $X $Y; spotted=$?
        
        if (($spotted == 1))
        then
            case $i in
                0 )
                    if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0))
                    then
                        #на экран пишем первое обнаружение
                        echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                        " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
                        #при первом обнаружении записываем какой ЗРДН обнаружид цель
                        target_params[$already_seen_index+$number_of_params*$target_index]=1
                    fi    
                    #в лог пишем все обнаружения             
                    echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/zrdn_log.txt
                ;;
                1 )
                    if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0))
                    then
                        #на экран пишем первое обнаружение
                        echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                        " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
                        #при первом обнаружении записываем какой ЗРДН обнаружид цель
                        target_params[$already_seen_index+$number_of_params*$target_index]=2
                    fi     
                    #в лог пишем все обнаружения            
                    echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/zrdn_log.txt
                ;;
                2 )
                    if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0))
                    then
                        #на экран пишем первое обнаружение
                        echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                        " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
                        #при первом обнаружении записываем какой ЗРДН обнаружид цель
                        target_params[$already_seen_index+$number_of_params*$target_index]=3
                    fi             
                    #в лог пишем все обнаружения    
                    echo "ZRDN $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/zrdn_log.txt
                ;;
            esac
        fi
        let i+=1
    done
}

function checkinCircle()
{
    i=$1
	local X=$2
	local Y=$3

    ((x1=-1*${ZRDN[0+3*$i]}+$X))
    ((y1=-1*${ZRDN[1+3*$i]}+$Y))
	
	
	local r1_=$(echo "sqrt ( (($x1*$x1+$y1*$y1)) )" | bc -l)
	r1=${r1_/\.*}


    if [ "$r1" -le "${ZRDN[2+3*$i]}" ]
    then
        return 1
    fi

	return 0
}
