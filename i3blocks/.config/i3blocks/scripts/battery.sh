#!/bin/bash
BAT0=$(acpi -b |grep 'Battery 0')
BAT=$(echo "$BAT0" | grep -E -o '[0-9][0-9]?%')
BATSTAT=$(echo "$BAT0" | grep -c -E 'Charging|Full')
# No Battery, so its wallpower
NOBAT=$(echo "$BAT0" | grep -c  'rate information unavailable')

COLOR="#00F00" #green
CHARGE="#00FF00" #green
DISCHARGE="#FF8000" #orange
DISCHARGELOW="#FF0000" #red

if [ "$NOBAT" -eq 1 ]
then
    BAT="∞"
    BATTEXT="wall power.."
fi

if [ "${BAT%?}" -eq 00 ]
then
    BAT="100%"
    BATTEXT=""
fi

#green ~ charging; orange ~ discharging
if [ "$BATSTAT" -eq 1 ]
then
    COLOR="$CHARGE"
else
    COLOR="$DISCHARGE"
fi

# show diffrent icon dependent on the battery charge
if [ "${BAT%?}" -le 25 ]
then
    BATTEXT=""
    COLOR="$DISCHARGELOW"
elif [ "${BAT%?}" -le 25 ]
then
    BATTEXT=""
elif [ "${BAT%?}" -le 50 ]
then
    BATTEXT=""
elif [ "${BAT%?}" -le 75 ]
then
    BATTEXT=""
elif [ "${BAT%?}" -le 90 ]
then
    BATTEXT=""
fi

#print it
OUT='<span foreground="'
OUT+="$COLOR"
OUT+='">'
OUT+=" $BATTEXT$BAT"
OUT+="</span>"
echo $OUT

#sends a notification if i click on the block
rightclick="notify-send $BATTEXT$BAT"

case $BLOCK_BUTTON in
    3) $rightclick;;
    *) ;;
esac

