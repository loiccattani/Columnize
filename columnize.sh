#!/bin/bash
# columnize.sh

# Author: Loïc Cattani "Arko" <loic cattani at gmail com>
# Started: 2010.06.11

# Take an array of values and output them in a nicely formatted column view

values=$1
longest_value=0

# Find the longest value
for value in ${values[@]}
do
  if [[ ${#value} -gt $longest_value ]]; then
    longest_value=${#value}
  fi
done

# Compute column span
term_width=$(tput cols)
columns=$(( $term_width / ($longest_value + 2) ))

# Print values with pretty column width
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

# Make sure there is a newline at the end
if [[ $curr_col != 0 ]]; then
  echo
fi
