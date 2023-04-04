#!/bin/bash
# Set this script up as systemd service
battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
charging_status=`acpi -b | grep -E -o 'Charging|Discharging|Not charging'`
if [ $battery_level -le 20 ] && [ $charging_status == "Discharging" ]; then
    notify-send --urgency=CRITICAL -a "Battery Warning" -i /usr/share/icons/Adwaita/scalable/status/battery-level-0-symbolic.svg "Battery Low" "Level: ${battery_level}%"
    paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
elif [[ $battery_level -ge 80  && ($charging_status == "Charging"  || $charging_status == "Not charging") ]]; then
    notify-send --urgency=CRITICAL -a "Battery Warning" -i /usr/share/icons/Adwaita/scalable/status/battery-level-100-symbolic.svg "Battery Full" "Level: ${battery_level}%"
    paplay /usr/share/sounds/freedesktop/stereo/service-logout.oga
fi
