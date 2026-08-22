#!/bin/bash

LOG_FILE="$HOME/projects/server-health-check/health.log"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] health check started" >> "$LOG_FILE"

echo "===== Server Health Report ====="
echo "Hostname : $(hostname)"
echo "Date     : $(date)"
echo ""

echo "----- Disk Usage -----"
df -h /

echo ""
echo "----- Memory -----"
free -h

echo ""
echo "----- Uptime and Load -----"
uptime


echo ""
echo "----- Top 5 Processes by Memory -----"
ps aux --sort=-%mem | head -6
echo "----- Health Check -----"

DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | tr -d '%')
THRESHOLD=80

echo "Disk usage is ${DISK_USAGE}%"

if [ "$DISK_USAGE" -gt "$THRESHOLD" ]; then
    echo "WARNING: disk usage above ${THRESHOLD}%"
else
    echo "OK: disk usage is within limits"
fi


echo "[$(date '+%Y-%m-%d %H:%M:%S')] disk=${DISK_USAGE}% status=done" >> "$LOG_FILE"
