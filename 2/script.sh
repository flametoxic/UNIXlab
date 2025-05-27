#!/bin/sh
set -e

SHARED_DIR="/shared"

LOCK_FILE="$SHARED_DIR/.lock"

CONTAINER_ID=$(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 8)

FILE_COUNT=0

while true; do
    (
        flock 200

        i=1
        while [ -f "$SHARED_DIR/$(printf "%03d" $i)" ]; do
            i=$((i + 1))
        done
        FILENAME="$SHARED_DIR/$(printf "%03d" $i)"

        echo "$CONTAINER_ID:$((++FILE_COUNT))" > "$FILENAME"

    ) 200>"$LOCK_FILE"

    sleep 1

    rm -f "$FILENAME"

    sleep 1
done