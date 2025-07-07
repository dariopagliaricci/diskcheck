#!/bin/bash

#--------------------------------------
# Disk Readability Checker with Resume
# (c) 2025 Dario Pagliaricci
# License: MIT
#--------------------------------------
#
# Usage:
#   sudo ./diskcheck.sh /path/to/disk
#
# Features:
#   - tests readability of every file
#   - logs unreadable files
#   - supports resume
#   - shows progress and ETA
#
#--------------------------------------

if [ -z "$1" ]; then
  echo "Usage: $0 /path/to/target_disk_or_folder"
  exit 1
fi

disk="$1"

progress_log=~/diskcheck_progress.log
unreadable_log=~/diskcheck_unreadable_files.txt
error_log=~/diskcheck_read_errors.log

# ensure progress log exists
touch "$progress_log"

# count total files, ignoring metadata
total=$(find "$disk" -type f ! -name ".DS_Store" ! -path "*/.Spotlight-V100/*" ! -path "*/.Trashes/*" | wc -l)

# start timer
start_time=$(date +%s)

i=0

find "$disk" -type f ! -name ".DS_Store" ! -path "*/.Spotlight-V100/*" ! -path "*/.Trashes/*" | while read -r file; do

    # check if already tested
    if grep -Fxq "$file" "$progress_log"; then
        continue
    fi

    i=$((i+1))

    # progress
    processed=$(wc -l < "$progress_log")
    percent=$(( 100 * processed / total ))

    now=$(date +%s)
    elapsed=$(( now - start_time ))

    if [ "$processed" -gt 0 ]; then
        estimated_total=$(( elapsed * total / processed ))
        remaining=$(( estimated_total - elapsed ))
    else
        remaining=unknown
    fi

    elapsed_h=$(printf "%02d:%02d:%02d" $((elapsed/3600)) $(( (elapsed/60)%60 )) $((elapsed%60)) )
    if [ "$remaining" != "unknown" ]; then
        remaining_h=$(printf "%02d:%02d:%02d" $((remaining/3600)) $(( (remaining/60)%60 )) $((remaining%60)) )
    else
        remaining_h="??:??:??"
    fi

    echo "[$processed/$total] ($percent%) Elapsed: $elapsed_h, Remaining: $remaining_h"
    echo "Testing: $file"

    if ! cat "$file" > /dev/null 2>> "$error_log"; then
        echo "$file" >> "$unreadable_log"
    fi

    echo "$file" >> "$progress_log"

done
