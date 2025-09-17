#!/bin/bash
#version-1-0-0
display_battery_info() {
  echo "      IZOT BATTERY TOOL - powered by TLP      "
  echo "--------------------------------------------------------------------"
  sudo echo "$(tlp-stat -b)"
  echo "--------------------------------------------------------------------"
  echo "Press Ctrl+C to exit!"
  echo "After that use 1 and then press Enter to launch PCAuditor"
}

while true; do
  clear
  display_battery_info
  sleep 1
done
