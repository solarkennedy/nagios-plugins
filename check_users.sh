#!/bin/bash
# 
# Plugin to check nuber of users currently logged in
# using check_by_ssh
# by Markus Walther (voltshock@gmx.de)
# The script needs a working check_by_ssh connection and needs to run on the client to check it
# 
# Command-Line for check_by_ssh
# command_line $USER1$/check_by_ssh -H $HOSTNAME$ -p $ARG1$ -C "$ARG2$ $ARG3$ $ARG4$ $ARG5$ $ARG6$"
# 
# Command-Line for service (example)
# check_by_ssh!82!/nagios/check_users.sh!1!2
#
##########################################################

progname=$0
warn=$1
crit=$2


if [ "$1" != "" -a "$2" != "" ]; then
        logged=`who | wc -l`
        if [ $logged -lt $warn ]; then
                echo "OK: $logged user(s) currently logged in"
                exit 0
        elif [ $logged -eq $warn -o $logged -gt $warn -a $logged -lt $crit ]; then
                echo "Warning: $logged user(s) currently logged in"
                exit 1
        elif [ $logged -eq $crit -o $logged -gt $crit ]; then
                echo "Critical: $logged user(s) currently logged in"
                exit 2
        else
                echo "Unknown error"
                exit 3
                fi
else
        echo "Usage: $progname [warn] [crit]"
        echo "  [warn] and [crit] is integer"
        echo "  Example: $progname 1 2"
        echo "No options given"
        exit 3
fi

