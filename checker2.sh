SQL_FILE=$1
ORIGIN_FILE=$2

cat $SQL_FILE | grep "\'" > a
cat a | tr -d '\,' > b
cat b | tr -d "\'" > c

diff c $ORIGIN_FILE