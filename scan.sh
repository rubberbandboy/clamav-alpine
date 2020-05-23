#!/bin/bash

set -euo pipefail
echo "Updating ClamAV Scanner versions"
apk update
apk upgrade -y
echo ""
echo "$( date -I'seconds' ) ClamAV process starting"
echo ""
echo "Updating ClamAV scan DB"
set +e
freshclam
FRESHCLAM_EXIT=$?
set -e
echo ""

if [[ "$FRESHCLAM_EXIT" -eq "0" ]]; then
    echo ""
    echo "Freshclam updated the DB"
    echo ""
elif [[ "$FRESHCLAM_EXIT" -eq "1" ]]; then
    echo ""
    echo "ClamAV DB already up to date..."
    echo ""
else
    echo ""
    echo "An error occurred (freshclam returned with exit code '$FRESHCLAM_EXIT')"
    echo ""
    exit $FRESHCLAM_EXIT
fi
echo ""
clamscan -V
echo ""
echo "Scanning $SCANDIR"
echo ""
clamscan -r $SCANDIR $@
echo ""
echo "$( date -I'seconds' ) ClamAV scanning finished"
