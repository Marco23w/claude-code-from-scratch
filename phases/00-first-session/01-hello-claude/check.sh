#!/bin/bash
source "$COURSE_ROOT/bin/checklib.sh"
F="$COURSE_WS/work/hello.md"
need_file "$F" "work/hello.md exists in your workspace"
need_grep "$COURSE_HANDLE" "$F" "it contains your handle ($COURSE_HANDLE)"
need_grep '[0-9]{4}-[0-9]{2}-[0-9]{2}' "$F" "it contains today's date in ISO form (YYYY-MM-DD)"
need_grep "$COURSE_CHANNEL" "$F" "it names your channel ($COURSE_CHANNEL)"
finish
