#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Get system metrics
DISK_USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | awk -F. '{print $1}')
MEMORY_USAGE=$(free | grep Mem | awk '{print int($3/$2 * 100)}')
THRESHOLD=60

# Print header
echo -e "${BLUE}\n=== Ubuntu Instance Health Check ===\n${NC}"

# Disk Space Check
echo -e "${YELLOW}Disk Usage:${NC}"
echo "Status: ${DISK_USAGE}%"
if [ "${DISK_USAGE}" -gt "${THRESHOLD}" ]; then
    echo -e "Health: ${RED}UNHEALTHY${NC}"
else
    echo -e "Health: ${GREEN}HEALTHY${NC}"
fi

# CPU Check
echo -e "\n${YELLOW}CPU Usage:${NC}"
echo "Status: ${CPU_USAGE}%"
if [ "${CPU_USAGE}" -gt "${THRESHOLD}" ]; then
    echo -e "Health: ${RED}UNHEALTHY${NC}"
else
    echo -e "Health: ${GREEN}HEALTHY${NC}"
fi

# Memory Check
echo -e "\n${YELLOW}Memory Usage:${NC}"
echo "Status: ${MEMORY_USAGE}%"
if [ "${MEMORY_USAGE}" -gt "${THRESHOLD}" ]; then
    echo -e "Health: ${RED}UNHEALTHY${NC}"
else
    echo -e "Health: ${GREEN}HEALTHY${NC}"
fi

# Detailed Explanation
echo -e "${YELLOW}\n=== Detailed Explanation ===${NC}"
echo "Disk Space: ${DISK_USAGE}%"
echo "CPU Usage: ${CPU_USAGE}%"
echo "Memory Usage: ${MEMORY_USAGE}%"
echo -e "\nThreshold for all metrics: ${THRESHOLD}%"

# Overall Health Status
echo -e "${BLUE}\n=== Overall System Health ===${NC}"
if [ "${DISK_USAGE}" -gt "${THRESHOLD}" ] || [ "${CPU_USAGE}" -gt "${THRESHOLD}" ] || [ "${MEMORY_USAGE}" -gt "${THRESHOLD}" ]; then
    echo -e "Status: ${RED}UNHEALTHY${NC}"
else
    echo -e "Status: ${GREEN}HEALTHY${NC}"
fi
