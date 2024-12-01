#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

# if no argument provided
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
# Check if it's an atomic number
elif [[ $1 =~ ^[0-9]+$ ]]; then
  QUERY_RESULT=$($PSQL "SELECT * FROM elements WHERE atomic_number = $1;")
  
  if [[ -z $QUERY_RESULT ]]; then
    echo -e "\nI could not find that element in the database."
  else
    # query properties table
    echo ""
  fi
else
  # test for symbol
  QUERY_RESULT=$($PSQL "SELECT * FROM elements WHERE symbol = '$1';")
  
  # if no results with symbol, check for name
  if [[ -z $QUERY_RESULT ]]; then
    QUERY_RESULT=$($PSQL "SELECT * FROM elements WHERE name = '$1';")
    
    # if still empty, it doesn't exist
    if [[ -z $QUERY_RESULT ]]; then
      echo -e "\nI could not find that element in the database."
    else
      # query properties table w/ results from name.
      echo ""
    fi
  else
    # query properties table with results from symbol.
    echo ""
  fi
fi
