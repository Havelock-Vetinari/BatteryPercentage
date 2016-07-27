#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
set -e
export TERM=xterm-256color

. "${SCRIPT_DIR}/bat_functions.sh"

ioreg -c IOAppleBluetoothHIDDriver -ra -k "BatteryPercent" -d 1 > /tmp/ioreg_out.xml

index=0
while true; do
	get_device_data_at_index ${index} || break
	index=$(($index+1))
	bat_desc="🔋 "
	if [ "${bat_low}" = true ]; then
		bat_desc="\033[5m🔋\033[0m "
	fi
	echo -e "`get_device_icon_by_class ${class}` ${product} ${bat_desc} ${bat_perc}% left"
done
