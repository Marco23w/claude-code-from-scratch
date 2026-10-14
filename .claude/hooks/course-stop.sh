#!/bin/bash
# Stop fires after every assistant turn: a heartbeat so a killed terminal still yields a duration.
source "$(dirname "$0")/course-lib.sh"
date +%s > "$STATE/last_activity"
exit 0
