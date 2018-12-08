#!/bin/bash
BAT0=$(acpi -b |grep 'Battery 0')
BAT=$(echo "$BAT0" | grep -E -o '[0-9][0-9]?%')
BATSTAT=$(echo "$BAT0" | grep -c 'Charging')

COLOR="#00F00"
CHARGE="#00FF00"
DISCHARGE="#FF8000"
DISCHARGELOW="#FF0000"

# Full and short texts
if [ "$BATSTAT" -eq 1 ]
then
   COLOR="$CHARGE"
else
    if [ "${BAT%?}" -le 30 ]
    then
        COLOR="$DISCHARGELOW"
    else
        COLOR="$DISCHARGE"
    fi
fi

OUT='<span foreground="'
OUT+="$COLOR"
OUT+='">'
OUT+=" $BAT"
OUT+="</span>"
echo $OUT

# Set urgent flag below 5%
#[ ${BAT%?} -le 5 ] && exit 33

exit 0
