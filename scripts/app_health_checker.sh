#!/bin/sh

check_app() {
    url=$1
    http_code=$(wget -q --server-response --spider "$url" 2>&1 | awk '/HTTP\//{print $2}' | tail -1)
    
    if [ -z "$http_code" ]; then
        echo "DOWN - $url (no response)"
        return 1
    fi

    if [ "$http_code" -ge 200 ] && [ "$http_code" -lt 400 ]; then
        echo "UP - $url (HTTP $http_code)"
        return 0
    else
        echo "DOWN - $url (HTTP $http_code)"
        return 1
    fi
}

if [ -z "$1" ]; then
    echo "Usage: sh app_health_checker.sh <URL>"
    exit 1
fi

echo "---- Application Health Check ----"
check_app "$1"
echo "---- Check Complete ----"