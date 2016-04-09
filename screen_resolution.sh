#!/bin/bash

VAR_HELP="\nПравильное использование screen_resolution.sh <big|normal>\n"

: ${1?"Порядок использования: $0 ARGUMENT"}

if [[ ${1} = 'big' ]]
then

	xrandr --output LVDS1 --mode 1024x600 --panning 1280x1024 --scale 1.0x1.0
	echo -e "\nУстановленное разрешение 1280x1024\n"
	exit 0;
fi

if [[ ${1} = 'normal' ]]
then
	xrandr --output LVDS1 --mode 1024x600 --panning 1024x600 --scale 1.0x1.0
	echo -e "\nУстановленное разрешение 1024x600\n"
	exit 0;
fi

echo -e $VAR_HELP
exit 1;

