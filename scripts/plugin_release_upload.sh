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

if gh release view "$tag" > /dev/null 2>&1; then
    echo "Release $tag exists: uploading $# file(s) over it" >&2
    gh release upload "$tag" "$@" --clobber
else
    echo "Release $tag does not exist: creating it with $# file(s)" >&2
    gh release create "$tag" "$@" --title "Genos plugins $tag" --generate-notes
fi
