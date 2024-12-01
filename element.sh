#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

# if no argument provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
# Check if it's an atomic number
elif [[ $1 =~ ^[0-9]+$ ]]; then
  QUERY_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $1;")
  echo "$QUERY_RESULT";
else
  # test for symbol or name
  echo ""
fi
