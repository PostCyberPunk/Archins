#!/bin/bash
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

# mred "error"
# myellow "warn"

# for ((j = 1; j <= 256; j++)); do
# 	echo "$(tput setaf $j)$j#################################$(tput sgr0)"
# done
