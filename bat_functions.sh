#!/bin/bash

TMP_FILE_PATH="/tmp/ioreg_out.xml"

function get_device_icon_by_class(){
	case "$1" in
	*Trackpad*)
		echo "🕹 "
		;;
	*Keyboard*)
		echo "⌨️ "
		;;
	*Mouse*)
		echo "🖱 "
		;;
	*)
		echo "🖲 "
		;;
	esac
	
}

function get_device_data_at_index(){
	local device_index=${1}
	product=`/usr/libexec/PlistBuddy -c "print ${device_index}:Product" "${TMP_FILE_PATH}" 2>/dev/null` || return 1
	bat_low=`/usr/libexec/PlistBuddy -c "print ${device_index}:BatteryLow" "${TMP_FILE_PATH}" 2>/dev/null`
	bat_panic=`/usr/libexec/PlistBuddy -c "print ${device_index}:BatteryPanic" "${TMP_FILE_PATH}" 2>/dev/null`
	bat_perc=`/usr/libexec/PlistBuddy -c "print ${device_index}:BatteryPercent" "${TMP_FILE_PATH}" 2>/dev/null`
	class=`/usr/libexec/PlistBuddy -c "print ${device_index}:IOClass" "${TMP_FILE_PATH}" 2>/dev/null`
	return 0
}