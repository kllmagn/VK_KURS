
declare -a RLS # x y a r fov

#1
RLS[0+5*0]=3423
RLS[1+5*0]=2707
RLS[2+5*0]=315
RLS[3+5*0]=6000
RLS[4+5*0]=230
#2
RLS[0+5*1]=9000
RLS[1+5*1]=6000
RLS[2+5*1]=225
RLS[3+5*1]=4000
RLS[4+5*1]=120
#3
RLS[0+5*2]=6224
RLS[1+5*2]=3718
RLS[2+5*2]=270
RLS[3+5*2]=6000
RLS[4+5*2]=90
function RLS0Detection
{
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=0

    checkinSector $i $X $Y; spotted=$?
    
    if (($spotted == 1))
    then

            if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0)) #на экран пишем первое обнаружение
            then
                echo "RLS 0: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
            fi                 
                echo "RLS 0: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/rls0_log.txt
            
        target_params[$already_seen_index+$number_of_params*$target_index]=1
    fi

}
function RLS1Detection
{
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=1

    checkinSector $i $X $Y; spotted=$?
    
    if (($spotted == 1))
    then

            if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0)) #на экран пишем первое обнаружение
            then
                echo "RLS 1: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
            fi                 
                echo "RLS 1: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/rls1_log.txt
            
        target_params[$already_seen_index+$number_of_params*$target_index]=1
    fi

}
function RLS2Detection
{
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=2

    checkinSector $i $X $Y; spotted=$?
    
    if (($spotted == 1))
    then

            if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0)) #на экран пишем первое обнаружение
            then
                echo "RLS 2: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
            fi                 
                echo "RLS 2: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/rls2_log.txt
            
        target_params[$already_seen_index+$number_of_params*$target_index]=1
    fi

}
#---------------------RLS--------------------
function RLSDetection
{
    how_many_rls=3
    #координаты цели
	local Xm=$1
	local Ym=$2

    #в файле координаты в метрах приводим к км и отбрасываем дробную часть
    ((X=$Xm/1000)); X=${X/\.*}
    ((Y=$Ym/1000)); Y=${Y/\.*}
    #echo $X
    #echo $Y
    i=0
    while [[ "$i" < "$how_many_rls" ]]
    do
        checkinSector $i $X $Y; spotted=$?
        
        if (($spotted == 1))
        then
            case $i in
                0 )
                if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0)) #на экран пишем первое обнаружение
                then
                    echo "RLS $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
                fi                 
                    echo "RLS $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/rls_log.txt
                ;;
                1 )
                if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0)) #на экран пишем первое обнаружение
                then
                    echo "RLS $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
                fi                 
                    echo "RLS $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/rls_log.txt
                ;;
                2 )
                if ((${target_params[$already_seen_index+$number_of_params*$target_index]} == 0)) #на экран пишем первое обнаружение
                then
                    echo "RLS $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}"
                fi                 
                    echo "RLS $i: обнаружена Цель ID:${target_params[$id_index+$number_of_params*$target_index]} тип: ${target_params[$target_type_index+$number_of_params*$target_index]}"\
                    " ${target_params[$x_coord_index+$number_of_params*$target_index]} ${target_params[$y_coord_index+$number_of_params*$target_index]}" >>$logdir/rls_log.txt
                ;;
            esac
            target_params[$already_seen_index+$number_of_params*$target_index]=1
        fi
        let i+=1
    done
}

function checkinSector()
{
	local i=$1
	local X=$2
	local Y=$3

	((x1=-1*${RLS[0+5*$i]}+$X))
	((y1=-1*${RLS[1+5*$i]}+$Y))
	#echo "$x1 $y1"

	local r1_=$(echo "sqrt ( (($x1*$x1+$y1*$y1)) )" | bc -l)
	r1=${r1_/\.*}


	if (( $r1 <= ${RLS[3+5*$i]} ))
	then
	  local fi=$(echo | awk " { x=atan2($y1,$x1)*180/3.14; print x}"); fi=(${fi/\.*});
	  if [ "$fi" -lt "0" ]
	  then
	    ((fi=360+$fi))	   
	  fi

 	  ((fimax=${RLS[2+5*$i]}+${RLS[4+5*$i]}/2)); #echo $fimax
	  ((fimin=${RLS[2+5*$i]}-${RLS[4+5*$i]}/2)); #echo $fimin
 	  if (( $fi <= $fimax )) && (( $fi >= $fimin ))
	  then
	    return 1
	  fi
	fi

	return 0
}
