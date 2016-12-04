#!/bin/bash
while true; do
    until /usr/games/vcmiserver; do
        echo "Server crashed with exit code $?.  Respawning.." >&2
        sleep 1
    done
done
