#!/bin/bash

needConfirm() {
	read -n1 -p "$1(y/N)" doit
	echo
	if [[ $doit == [yY] ]]; then
		return 0
	else
		return 1
	fi
}
