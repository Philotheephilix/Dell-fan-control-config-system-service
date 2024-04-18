#!/bin/bash
service bluetooth restart
gcc dell-bios-fan-control.c -o dell-bios
sudo ./dell-bios 0
i8kctl fan - 1
sudo rm dell-bios
while true; do
    # Commands to execute while the condition is true
    sleep 30
done

