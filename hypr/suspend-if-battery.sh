!/bin/bash

# Check if an AC adapter is online
# 0 = Battery (Unplugged), 1 = AC Power (Plugged in)
IS_PLUGGED_IN=$(cat /sys/class/power_supply/AC0/online 2>/dev/null || cat /sys/class/power_supply/AC/online 2>/dev/null || cat /sys/class/power_supply/ADP1/online 2>/dev/null)

if [ "$IS_PLUGGED_IN" = "0" ]; then
    # System is on battery, proceed to suspend
    systemctl suspend
else
    # System is plugged in, do nothing and exit
    exit 0
fi
