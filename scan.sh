#!/bin/bash

set -euo pipefail
echo "Updating ClamAV Scanner versions"
apk update
apk upgrade
echo "$( date -I'seconds' ) ClamAV process starting"
echo "Updating ClamAV scan DB"
set +e
freshclam
FRESHCLAM_EXIT=$?
set -e
echo ""

if [[ "$FRESHCLAM_EXIT" -eq "0" ]]; then
    echo "Freshclam updated the DB"
elif [[ "$FRESHCLAM_EXIT" -eq "1" ]]; then
    echo "ClamAV DB already up to date..."
else
    echo "An error occurred (freshclam returned with exit code '$FRESHCLAM_EXIT')"
    exit $FRESHCLAM_EXIT
fi
clamscan -V
echo "Scanning $SCANDIR"
clamscan -r --max-filesize=4000M --max-scansize=4000M --bytecode-timeout=190000 $SCANDIR $@
echo "$( date -I'seconds' ) ClamAV scanning finished"
