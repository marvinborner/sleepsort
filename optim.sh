#!/bin/bash

TRIALS=100
SUCCESSES=10

echo "if this takes too long, either choose a random timeout from the trials, adapt the script accordingly, or just use smaller numbers hehe"

set -e

make c
REFERENCE=$(./csort)

function test() {
	make asm
	for i in $(seq $TRIALS); do
		output=$(stdbuf -i0 -o0 -e0 ./sort)
		if [ "$output" != "$REFERENCE" ]; then
			return 1
		fi
	done
	return 0
}

function substitute() {
	sed -ie "/^%define TIMEOUT/s/ [0-9]\+/ $1/" config.asm
}

# TODO: Multithreading
minimum=4294967295
successes=0
timeout=1
while true; do
	substitute $timeout
	if test; then
		successes=$((successes + 1))
		echo "$successes/$SUCCESSES with $timeout"

		if [ $timeout -le $minimum ]; then
			minimum=$timeout
		fi

		if [ $successes -eq $SUCCESSES ]; then
			break
		fi

		timeout=$((timeout - timeout / 3))
	else
		timeout=$((timeout * 2))
	fi
done

substitute $minimum
echo "Done. Timeout $minimum will probably work most of the time."
