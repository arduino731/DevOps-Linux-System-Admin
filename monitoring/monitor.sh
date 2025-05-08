#!/bin/bash

# File: monitor.sh
# Purpose: Log basic server health metrics daily

LOG_FILE="/var/log/monitor.log"

echo "[$(date)] Monitoring snapshot" >> $LOG_FILE
echo "🕒 Uptime:" >> $LOG_FILE
uptime >> $LOG_FILE

echo "💾 Disk Usage:" >> $LOG_FILE
df -h >> $LOG_FILE

echo "-------------------------------" >> $LOG_FILE
