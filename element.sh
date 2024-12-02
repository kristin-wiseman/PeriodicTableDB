#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

# if no argument provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]; then
    # if input is numerical, query atomic number column
    COL="atomic_number"
  elif [[ ${#1} -le 2 ]]; then
    # if length <= 2, it's a symbol
    COL="symbol"
  else
    # query name column by default
    COL="name"
  fi

  QUERY_RESULT=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) LEFT JOIN types USING(type_id) WHERE $COL = '$1';")

  # if no result
  if [[ -z $QUERY_RESULT ]]; then
    echo "I could not find that element in the database."
  else
    # break up $QUERY_RESULT, print output.
    echo "$QUERY_RESULT" | while read TID BAR ANUM BAR SYMBOL BAR NAME BAR AMASS BAR MP BAR BP BAR TYPE
    do
      echo "The element with atomic number $ANUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius."
    done
  fi
fi