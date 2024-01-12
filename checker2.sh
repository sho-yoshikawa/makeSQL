SQL_FILE=$1
ORIGIN_FILE=$2

# single quote 「'」
cat $SQL_FILE | grep "\'" > a
cat a | tr -d '\,' > b
cat b | tr -d "\'" > c

# double quote 「"」
#cat $SQL_FILE | grep '\"' > a
#cat a | tr -d '\,' > b
#cat b | tr -d '\"' > c

diff c $ORIGIN_FILE
rm a b c
