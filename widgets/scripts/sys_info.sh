#!/bin/bash

## Files and Data
PREV_TOTAL=0
PREV_IDLE=0
cpuFile="/tmp/.cpu_usage"

## Get CPU usage
get_cpu() {
    if [[ -f "${cpuFile}" ]]; then
        fileCont=$(cat "${cpuFile}")
        PREV_TOTAL=$(echo "${fileCont}" | head -n 1)
        PREV_IDLE=$(echo "${fileCont}" | tail -n 1)
    fi

    CPU=(`cat /proc/stat | grep '^cpu '`) # Get the total CPU statistics.
    unset CPU[0]                          # Discard the "cpu" prefix.
    IDLE=${CPU[4]}                        # Get the idle CPU time.

    # Calculate the total CPU time.
    TOTAL=0

    for VALUE in "${CPU[@]:0:4}"; do
        let "TOTAL=$TOTAL+$VALUE"
    done

    if [[ "${PREV_TOTAL}" != "" ]] && [[ "${PREV_IDLE}" != "" ]]; then
        # Calculate the CPU usage since we last checked.
        let "DIFF_IDLE=$IDLE-$PREV_IDLE"
        let "DIFF_TOTAL=$TOTAL-$PREV_TOTAL"
        let "DIFF_USAGE=(1000*($DIFF_TOTAL-$DIFF_IDLE)/$DIFF_TOTAL+5)/10"
        echo "${DIFF_USAGE}"
    else
        echo "?"
    fi

    # Remember the total and idle CPU times for the next check.
    echo "${TOTAL}" > "${cpuFile}"
    echo "${IDLE}" >> "${cpuFile}"
}

## Get Used memory
get_mem() {
    printf "%.0f\n" $(free -m | grep Mem | awk '{print ($3/$2)*100}')
}

## Get CPU temperature using sensors
get_cpu_temp() {
    if command -v sensors &> /dev/null; then
        # Use sensors to get CPU temperature
        temp=$(sensors | grep 'Package id 0' | awk '{print $4}' | cut -c 2-)
        echo "${temp}"
    else
        echo "N/A"
    fi
}


## Execute accordingly
if [[ "$1" == "--cpu" ]]; then
    get_cpu
elif [[ "$1" == "--mem" ]]; then
    get_mem
elif [[ "$1" == "--temp-cpu" ]]; then
    get_cpu_temp
fi
