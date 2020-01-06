#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2020-01-06 14:09:39 +0000 (Mon, 06 Jan 2020)
#
#  https://github.com/harisekhon/bash-tools
#
#  License: see accompanying Hari Sekhon LICENSE file
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help improve or steer this or other code I publish
#
#  http://www.linkedin.com/in/harisekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# shellcheck disable=SC1090
. "$srcdir/lib/utils.sh"

section "Checking no Git / Diff merge remnants"

if [ -n "${1:-}" ]; then
    if ! [ -d "$1" ]; then
        echo "No such file or directory $1"
        exit 1
    fi
    pushd "$1"
fi

start_time="$(start_timer)"

echo "searching for '[<]<<<<<<|>>>>>>[>]' under $PWD"
if grep -aER '[<]<<<<<<|>>>>>>[>]' .; then
    echo
    echo "FOUND Git / Diff merge remnants!"
    exit 1
fi

time_taken "$start_time"
section2 "No git / diff merge remnants found"
echo
