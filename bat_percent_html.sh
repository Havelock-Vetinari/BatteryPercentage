#!/bin/bash
set -e
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

. "${SCRIPT_DIR}/bat_functions.sh"

ioreg -ra -k "BatteryPercent" -d 1 > "${TMP_FILE_PATH}"

echo "<html><head>"
echo "<meta charset=\"UTF-8\">"
echo "<style>"
cat "${SCRIPT_DIR}/assets/css/blinker.css"
cat "${SCRIPT_DIR}/assets/css/like-a-term.css" | sed "s#%assets#file://${SCRIPT_DIR}/assets/#"
echo "</style>"
echo "</head>"
index=0
while true; do
	get_device_data_at_index ${index} || break
	index=$(($index+1))
	echo -n "<div>"
	bat_desc_class="";
	if [ "${bat_panic}" = true ]; then
		bat_desc_class=fast_blink_text
	elif [ "${bat_low}" = true ]; then
		bat_desc_class=blink_text
	fi
	bat_desc="<span class=\"${bat_desc_class}\">🔋 </span>"
	echo -n "`get_device_icon_by_class ${class}` ${product} ${bat_desc} ${bat_perc}% left"
	echo "</div>"
done
echo "</html>"