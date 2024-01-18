DATA_FILE=$1
DST_FILE=$2
while read cid
do
  echo "SELECT cid, ppcd_web_guid FROM users WHERE cid = 9999;" | sed -e "s/9999/'${cid}'/" >> $DST_FILE
done < $DATA_FILE
