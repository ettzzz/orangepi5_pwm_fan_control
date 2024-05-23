#!/bin/bash

if [[ "$1" == -h ]]; then
  python3 ./fan_control.py -h
  exit
fi

path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$path"

sudo chmod o+rw /sys/class/pwm/pwmchip2/export
if [ ! -d "/sys/class/pwm/pwmchip2/pwm${1}" ]; then
  echo $1 > /sys/class/pwm/pwmchip2/export
fi

sudo chmod o+rw /sys/class/pwm/pwmchip2/pwm*/period
sudo chmod o+rw /sys/class/pwm/pwmchip2/pwm*/duty_cycle
sudo chmod o+rw /sys/class/pwm/pwmchip2/pwm*/enable
sudo chmod o+r /sys/class/thermal/thermal_zone*/temp

sudo chmod +x ./fan_control.py
sudo python3 ./fan_control.py "$@"
