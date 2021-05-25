#-------path--------
source "funcs.sh"
logdir=./LOGS

rm $logdir/full_log.txt 2>/dev/null
touch $logdir/full_log.txt

rls0=$logdir/rls0_log.txt
rls0_status=$logdir/rls0_status.txt
rls1=$logdir/rls1_log.txt
rls1_status=$logdir/rls1_status.txt
rls2=$logdir/rls2_log.txt
rls2_status=$logdir/rls2_status.txt


zrdn0=$logdir/zrdn0_log.txt
zrdn0_status=$logdir/zrdn0_status.txt
zrdn1=$logdir/zrdn1_log.txt
zrdn1_status=$logdir/zrdn1_status.txt
zrdn2=$logdir/zrdn2_log.txt
zrdn2_status=$logdir/zrdn2_status.txt

spro=$logdir/spro_log.txt
spro_status=$logdir/spro_status.txt
#-------vars--------
#delayer=20
i=0
#--------station_status_description_array--------
#declare -a station_params
#number_of_params=6


rls0_prev_status=0
rls1_prev_status=0
rls2_prev_status=0


zrdn0_prev_status=0
zrdn1_prev_status=0
zrdn2_prev_status=0

spro_prev_status=0
#-----------------------------
#каждая станция пишет в файл _status imok по разнице времени доступа к файлу определяем работает ли скрипт
while :
do
    cat $rls0  >>$logdir/full_log.txt; >$rls0
    cat $rls1  >>$logdir/full_log.txt; >$rls1
    cat $rls2  >>$logdir/full_log.txt; >$rls2

    cat $zrdn0  >>$logdir/full_log.txt; >$zrdn0
    cat $zrdn1  >>$logdir/full_log.txt; >$zrdn1
    cat $zrdn2  >>$logdir/full_log.txt; >$zrdn2

    cat $spro  >>$logdir/full_log.txt; >$spro

    if ((i< 20))
    then
        rls0_curr_status=$(stat -c %Y $rls0_status)
        rls1_curr_status=$(stat -c %Y $rls1_status)
        rls2_curr_status=$(stat -c %Y $rls2_status)

        zrdn0_curr_status=$(stat -c %Y $zrdn0_status)
        zrdn1_curr_status=$(stat -c %Y $zrdn1_status)
        zrdn2_curr_status=$(stat -c %Y $zrdn2_status)

        spro_curr_status=$(stat -c %Y $spro_status)

       # spro_curr_status=$(stat -c %Y spro_status.txt)
        if (($rls0_curr_status-$rls0_prev_status == 0))
        then
            echo KP: rls0 not OK
        fi
        if (($rls1_curr_status-$rls1_prev_status == 0))
        then
            echo KP: rls1 not OK
        fi
        if (($rls2_curr_status-$rls2_prev_status == 0))
        then
            echo KP: rls2 not OK
        fi
        if (($zrdn0_curr_status-$zrdn0_prev_status == 0))
        then
            echo KP: zrdn0 not OK
        fi
        if (($zrdn1_curr_status-$zrdn1_prev_status == 0))
        then
            echo KP: zrdn1 not OK
        fi
        if (($zrdn2_curr_status-$zrdn2_prev_status == 0))
        then
            echo KP: zrdn2 not OK
        fi
        if (($spro_curr_status-$spro_prev_status == 0))
        then
            echo KP: spro not OK
        fi

        let rls0_prev_status=$rls0_curr_status
        let rls1_prev_status=$rls1_curr_status
        let rls2_prev_status=$rls2_curr_status
        let zrdn0_prev_status=$zrdn0_curr_status
        let zrdn1_prev_status=$zrdn1_curr_status
        let zrdn2_prev_status=$zrdn2_curr_status
        let spro_prev_status=$spro_curr_status
        let i=0
    fi
    GenTargets_pid=$(pgrep GenTargets.sh); gen_run=$?
    #echo $GenTargets_pid;
    if (($gen_run != 0))
    then
        echo "процесс GenTarget убит. Завершаю kp"
        exit 0
    fi
    let i+=1
    sleep 1 #чтобы другие процессы могли зпуститься пока этот спит

done
