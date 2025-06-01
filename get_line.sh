#!/usr/bin/env bash
if [ $1 -le 40 ] && [ $1 -ge 0 ]; then
  name=$(cat ~/gpio_test/gpio_names.txt | sed -n "$1 p")
  gpiofind $name
else
  echo "Error: Invalid Board Pin Number"
fi

