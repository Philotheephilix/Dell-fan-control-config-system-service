#!/bin/bash
# Function to read config values
read_config() {
    source config.bash
}

# Function to write config values
write_config() {
    sed -i "s/avg=.*/avg=$1/" config.bash
    sed -i "s/max=.*/max=$2/" config.bash
}

read_config
read -p "Enter new average temperature (default: $avg): " new_avg
read -p "Enter new maximum temperature (default: $max): " new_max

new_avg=${new_avg:-$minimum}
new_max=${new_max:-$maximum}

i8kctl fan 1 1

# Write new configuration values
write_config "$new_avg" "$new_max"