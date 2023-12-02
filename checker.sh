# check 20data/sec
# ================== TLE ==================
DATA_FILE=$1
TEST_FILE=$2
CNT=0

while read data_line
do
  echo $CNT
  TARGET="'$data_line'"
  STATUS=$(grep $TARGET $TEST_FILE)
  if [ "$STATUS" = "1" ]; then
    echo "FAIL"
    exit 1
  fi
  CNT=$((CNT + 1))
done < $DATA_FILE

echo "OK"
echo "$CNT data successfully inserted."