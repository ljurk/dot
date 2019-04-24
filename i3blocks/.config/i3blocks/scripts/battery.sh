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
else
    BATTEXT="$BAT%"
fi

if [ "${BAT%?}" -eq 00 ]
then
    BAT="100%"
fi
# Full and short texts
if [ "$BATSTAT" -eq 1 ]
then
    COLOR="$CHARGE"
else
    COLOR="$DISCHARGE"
fi

if [ "${BAT%?}" -lt 30 ]
then
    BATTEXT=""
    COLOR="$DISCHARGELOW"
fi
if [ "${BAT%?}" -gt 50 ]
then
    BATTEXT=""
fi
if [ "${BAT%?}" -gt 75 ]
then
    BATTEXT=""
fi


OUT='<span foreground="'
OUT+="$COLOR"
OUT+='">'
OUT+=" $BATTEXT$BAT"
OUT+="</span>"
echo $OUT

# Set urgent flag below 5%
#[ ${BAT%?} -le 5 ] && exit 33

rightclick="notify-send $BATTEXT"

case $BLOCK_BUTTON in
    3) $rightclick;;
    *) ;;
esac

