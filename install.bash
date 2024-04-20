#!/bin/bash
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi
apt install i8kutils -y
apt install lm-sensors -y
# Prompt the user for input
read -p "Enter the minimum threshold temperature : " minimum
read -p "Enter the minimum threshold temperature : " maximum
if [[ "$minimum" =~ ^[0-9]+$ ]]; then
    sed -i "s/^minimum=.*/minimum=$minimum/" fancontrol.bash

    echo "Minimum value updated successfully."
else
    echo "Invalid input. Please enter an integer."
fi
if [[ "$maximum" =~ ^[0-9]+$ ]]; then
    sed -i "s/^maximum=.*/maximum=$maximum/" fancontrol.bash

    echo "Maximum value updated successfully."
else
    echo "Invalid input. Please enter an integer."
fi
cp rc-local.service /etc/rc-local.service
cp fancontrol.bash /etc/rc.local
chmod +x /etc/rc.local
systemctl enable rc-local.service
systemctl start rc-local.service
systemctl status rc-local.service