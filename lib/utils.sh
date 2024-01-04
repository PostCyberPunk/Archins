#!/bin/bash
##########Colors
mred() {
	echo "$(tput setaf 1)$1$(tput sgr0)"
}
mgreen() {
	echo "$(tput setaf 2)$1$(tput sgr0)"
}
myellow() {
	echo "$(tput setaf 3)$1$(tput sgr0)"
}
mblue() {
	echo "$(tput setaf 4)$1$(tput sgr0)"
}
mpurple() {
	echo "$(tput setaf 5)$1$(tput sgr0)"
}
mteal() {
	echo "$(tput setaf 6)$1$(tput sgr0)"
}

need_confirm() {
	mteal "$1(y/N)"
	read -n1 doit
	echo
	if [[ $doit == [yY] ]]; then
		return 0
	else
		return 1
	fi
}
check_last_cmd() {
	if [[ $? -ne 0 ]]; then
		mred "Failed:$1...Aborted"
		exit 1
	else
		mgreen "Finished:$1"
	fi
}
print_time() {
	now_time=$(date)
	mgreen "Completed time: $now_time"
}

# for ((j = 1; j <= 256; j++)); do
# 	echo "$(tput setaf $j)$j#################################$(tput sgr0)"
# done
