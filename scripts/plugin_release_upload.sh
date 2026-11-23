#!/usr/bin/env bash
# Attaches the plugin zips to the release of a tag (MIP-2093): upload over the release when it already
# exists (e.g. created by hand first), create it otherwise. Needs `gh` and GH_TOKEN.
#
#   plugin_release_upload.sh <tag> <zip> [<zip> ...]
set -euo pipefail

tag=${1:?tag}
shift
[ "$#" -gt 0 ] || { echo "ERROR: no zip files given" >&2; exit 1; }
for f in "$@"; do [ -f "$f" ] || { echo "ERROR: $f is missing" >&2; exit 1; }; done

# gh failures must be visible: print gh's own message and exit non-zero (a swallowed error once left the
# release job red with no log line, MIP-2173).
run_gh() {
    local err rc=0
    err=$("$@" 2>&1) || rc=$?
    [ -n "$err" ] && echo "$err" >&2
    if [ "$rc" -ne 0 ]; then
        echo "ERROR: '$*' failed with exit code $rc (does the job have permissions: contents: write?)" >&2
        exit "$rc"
    fi
}

# only "release not found" counts as missing; any other view error is a failure
view_err=$(gh release view "$tag" 2>&1 > /dev/null) && exists=1 || exists=0
if [ "$exists" = 0 ] && ! grep -qi "not found" <<< "$view_err"; then
    echo "ERROR: gh release view $tag failed: $view_err" >&2
    exit 1
fi

if [ "$exists" = 1 ]; then
    echo "Release $tag exists: uploading $# file(s) over it" >&2
    run_gh gh release upload "$tag" "$@" --clobber
else
    echo "Release $tag does not exist: creating it with $# file(s)" >&2
    run_gh gh release create "$tag" "$@" --title "Genos plugins $tag" --generate-notes
fi
