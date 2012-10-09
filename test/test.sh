#!/bin/sh
# Test basic functionality

set -e

proram=$0
TMPDIR=${TMPDIR:-/tmp}
BASE=tmp.$$
TMPBASE=${TMPDIR%/}/$BASE
CURDIR=.

case "$0" in
  */*)
        CURDIR=$(cd "${0%/*}" && pwd)
        ;;
esac

AtExit ()
{
    rm -f "$TMPBASE"*
}

Run ()
{
    echo "$*"
    shift
    eval "$@"
}

trap AtExit 0 1 2 3 15

# #######################################################################

file="$TMPBASE.ps"
cp "$CURDIR/example.ps" "$file"
echo "%% TEST ps: pstotext $file"
pstotext "$file" | head

file="$TMPBASE.pdf"
uudecode -o "$file" "$CURDIR/example.pdf.uu"
echo "%% TEST ps: pstotext $file"
pstotext "$file"  | head

# End of file
