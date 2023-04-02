#!/bin/bash
# Set this script up as systemd service
battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
charging_status=`acpi -b | grep -E -o 'Charging|Discharging'`
if [ $battery_level -le 20 && $charging_status == "Discharging" ]; then
    notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
    paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
elif [ $battery_level -ge 80 && $charging_status == "Charging" ]; then
    notify-send "Battery Full" "Level: ${battery_level}%"
    paplay /usr/share/sounds/freedesktop/stereo/service-logout.oga
fi
