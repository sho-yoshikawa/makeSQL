# $1.. data file
# $2.. template sql file
# $3.. new file name
# $4.. separate number
DATA_FILE=$1
SQL_FILE=$2
DST_FILE=$3
ALL_CNT=`cat $DATA_FILE | wc -l`
SEPARATE_CNT=$4
LAST_CNT=$((ALL_CNT % SEPARATE_CNT))
TIMES=$(( ALL_CNT / SEPARATE_CNT + 1))

for ((i = 0; i < $TIMES; i++))
do
  if [ "$i" != "$(expr $(($TIMES - 1)))" ]; then
    # count up
    CNT=$(expr $((CNT+$SEPARATE_CNT)))
    # make data
    DATA=$(cat $DATA_FILE | head -n $CNT  | tail -n $SEPARATE_CNT | awk '{printf "\047" $1 "\047" ","}')
  else # last loop
    CNT=$(expr $((CNT+$LAST_CNT)))
    DATA=$(cat $DATA_FILE | head -n $CNT  | tail -n $LAST_CNT | awk '{printf "\047" $1 "\047" ","}')
  fi

  # trim prefix ","
  DATA=$(echo $DATA | sed -e 's/,$//')

  # add IN() statement
  DATA="IN(\n$DATA\n)"

  # insert data
  while read line
  do
    if [ "$line" != "IN()" ]; then
      echo $line >> $DST_FILE
    else
      echo $DATA | sed -e 's/,/,\n/g' >> $DST_FILE
    fi
  done < $SQL_FILE

  # add newline
  if [ "$i" != "$(expr $(($TIMES - 1)))" ]; then
    echo "\n" >> $DST_FILE
  fi

done # endfor