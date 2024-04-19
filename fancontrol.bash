#!/bin/bash

source config.bash

# Restart Bluetooth service
sudo service bluetooth restart

# Compile and execute dell-bios-fan-control.c
gcc dell-bios-fan-control.c -o dell-bios
sudo ./dell-bios 0
sudo rm dell-bios

# declare current temparature value variable
declare -i cur_temp


while true; do
    cur_temp=$(sensors | grep "CPU:" | awk '{gsub(/[^0-9.-]/,"",$2); printf "%.0f\n", $2}')
    # if condition to stop fan if under threshold
    if [ "$cur_temp" -lt "$minimum" ]; then
        i8kctl fan 0 0
    # else is to start operation if above first threshold value and less than second ( mininum @ config.bash)
    elif [ "$cur_temp" -lt "$maximum" ]; then
        i8kctl fan 1 1
    # run at full rpm if current temperature is above maximum threshold ( maximum @ config.bash )
    else
        i8kctl fan 2 2
    fi

    sleep 2
done
