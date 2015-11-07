#! /bin/sh
#

DIR=~/.lights
ADDRESSFILE=$DIR/ip_address
REDFILE=$DIR/red
GREENFILE=$DIR/green
BLUEFILE=$DIR/blue
exec 10<&0

exec < $ADDRESSFILE
read IP_ADDRESS
exec < $REDFILE
read RED
exec < $GREENFILE
read GREEN
exec < $BLUEFILE
read BLUE

exec 0<&10 10<&-


if [ $1 = "set" ] ; then
  let RED=$2
  let GREEN=$3
  let BLUE=$4
  echo $RED > $REDFILE
  echo $GREEN > $GREENFILE
  echo $BLUE > $BLUEFILE
else
  if [ $1 = "on" ] ; then
    echo "LIGHTS ON!!\n"
  else
    if [ $1 = "off" ] ; then
      echo "LIGHTS OFF!!"
      let RED=0
      let GREEN=0
      let BLUE=0

      if [ $1 = "RED+" ] ; then
        # this part is for increasing/decreasing from current setpoint
        # need to make sure setpoint is never over 255 or under 0
        echo $1
      else
        echo "Usage: lights {gotta pass some stuff here}"
        #exit 1

      fi
    fi
  fi
fi

curl -d "{\"red\":$RED, \"green\":$GREEN, \"blue\":$BLUE}" $IP_ADDRESS:8783

exit 0

