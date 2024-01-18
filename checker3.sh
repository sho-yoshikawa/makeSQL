SQL_FILE=$1
ORIGIN_FILE=$2

# 数字改行以外を取り除く
cat $SQL_FILE | tr -cd '0123456789\n' > a

diff a $ORIGIN_FILE
rm a
