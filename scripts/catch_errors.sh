#!/bin/bash

# Setup colour codes
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=linux;;
    Darwin*)    machine=mac;;
    CYGWIN*)    machine=cygwin;;
    MINGW*)     machine=minGw;;
    MSYS_NT*)   machine=git;;
    *)          machine="UNKNOWN:${unameOut}"
esac
# echo ${machine}

escape_char="\e";

if [ "$machine" == "mac" ]; then
  escape_char="\x1B"
fi

# Catches non-zero errors display a message and exits program
# Can be passed a bash command or an exit code
# Usage:
# eg 1:
#   catch echo "hello";
# OUTPUT:
#   [OK]

# eg 2:
#   bash return_1.sh;
#   catch $?;
# OUTPUT:
#   [FAILED]

# eg 3:
#   bash return_0.sh;
#   catch $?;
# OUTPUT:
#   [OK]
catch() {
  if [[ "$@" =~ ^-?[0-9]+$ ]]; then
    local STATUS="$@";
  else
    "$@"
    local STATUS=$?;
  fi
  if [ $STATUS -ne 0 ]; then
    echo -e "[$escape_char[31mFAILED$escape_char[39m]";
    exit $STATUS;
  else
    echo -e "[$escape_char[32mOK$escape_char[39m]";
  fi
  return $STATUS;
}

#catches non-zero errors, displays a message but lets the program continue.
pass() {
  "$@"
  local STATUS=$?
  if [ $STATUS -ne 0 ]; then
    echo -e "[$escape_char[33mWARNING$escape_char[39m]";
  else
    echo -e "[$escape_char[32mOK$escape_char[39m]";
  fi
}


#This function was written by: http://fitnr.com/showing-a-bash-spinner.html
#https://github.com/marascio/bash-tips-and-tricks/tree/master/showing-progress-with-a-bash-spinner
spinner()
{
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    echo "$pid" > "/tmp/.spinner.pid"
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

#Preppends the date to the line fed to this.
# exit status is preserved.
timestampit() {
  local status_in=$?
    while IFS= read -r line; do
        echo -e "$(date) $line"
    done
  return $status_in
}

