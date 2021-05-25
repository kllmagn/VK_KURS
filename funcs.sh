function GetTargetsListAll
{
	Targets=`ls -tr $DirectoryTargets 2>/dev/null | grep id.`
	result=$?;
	if (( $result != 0 ))
	then
	  echo "Система не запущена!"
	  exit 0
	fi
}

function GetTargetsListLastNinety
{
	Targets=`ls -tr $DirectoryTargets 2>/dev/null | grep id. | tail -n90`
	result=$?;
	if (( $result != 0 ))
	then
	  echo "Система не запущена!"
	  exit 0
	fi
}

returnIdx=0;
function isNewIDinList
{
  # if new returns -1
  # else returns index of element

  sizeofElem="$1"
  idcurr="$2";
  #shift
  #shift
  #declare -a list=("${@}")
  ((countofElem=${#target_params[@]}/sizeofElem)); #echo "ELEMENTS = $countofElem"

  returnIdx=-1
  i=0

  while (( "$i" < "$countofElem" ))
  do
    if [[ "${target_params[id_index+$sizeofElem*$i]}" == "$idcurr" ]]
    then
      returnIdx=$i
      break;#return "$i"
    fi
    let i+=1
  done
}

function TargetTypeBySpeed
{
  #0-br 1-plan 2-rocket
  speed=$1
  # берем модуль скорости
  if (( $speed < 0 ))
  then
    let speed=-1*$speed;
  fi

  if (( $speed < 250 ))
  then
    return 3
  fi

  if (( $speed < 1000 ))
  then
    return 2
  fi

  if (( $speed < 10000 ))
  then
    return 1
  fi

  return 100
}
