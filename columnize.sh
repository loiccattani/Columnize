#!/bin/bash


values=$1
longest_value=0

# Computing longest value
for value in ${values[@]}
do
  if [[ ${#value} -gt $longest_value ]]; then
    longest_value=${#value}
  fi
done

# Computing column span
term_width=$(tput cols)
columns=$(( $term_width / ($longest_value + 2) ))
echo "$columns columns"

# printing values with pretty column width
curr_col=0
for value in ${values[@]}
do
  value_len=${#value}
  echo -n $value
  spaces_missing=$(( $longest_value - $value_len + 2 ))
  for (( i = 0; i < $spaces_missing; i++ )); do
    echo -n " "
  done
  (( curr_col++ ))
  if [[ $curr_col == $columns ]]; then
    echo
    curr_col=0
  fi
done
