bash ./kp.sh &
echo "run kp"
sleep 0.1

#-----------run-all-RLS----------
bash ./rls0.sh &
echo "run rls0"
sleep 0.1
bash ./rls1.sh &
echo "run rls1"
sleep 0.1
bash ./rls2.sh &
echo "run rls2"
sleep 0.1
#-------------run-SPRO------------
bash ./spro.sh &
echo "run spro"
sleep 0.1
#-----------run-all-ZRDN----------
bash ./zrdn0.sh &
echo "run zrdn0"
sleep 0.1
bash ./zrdn1.sh &
echo "run zrdn1"
sleep 0.1
bash ./zrdn2.sh &
echo "run zrdn2"
sleep 0.1