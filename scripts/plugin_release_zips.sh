#!/usr/bin/env bash
# Builds one zip per plugin for a release of genos-tech/genos-claude-plugin (MIP-2093).
# Used by the public repo's release workflow (genos-docs/plugin-release/release.yml is its source)
# and tested by scripts/test_plugin_release_zips.sh.
#
#   plugin_release_zips.sh <repo-root> <tag> <out-dir>
#
# <repo-root>/plugins/<name>/ holds each plugin (every folder; genos plus the role packs).
# Rules (any failure exits non-zero, nothing is uploaded by this script):
#   - the tag is v<semver> and equals the version in plugins/genos/.claude-plugin/plugin.json
#     (the tag follows the genos plugin; the role packs carry their own version inside and are
#     not forced to the tag);
#   - every plugin has a .claude-plugin/plugin.json that is valid JSON, whose name equals its
#     folder and whose version is semver; a plugin's .mcp.json, when present, is valid JSON;
#   - the manifest is at the zip root (zip is built from inside the plugin folder).
# Prints one "<zip file>" line per zip on stdout (progress goes to stderr).
set -euo pipefail

root=${1:?repo root}
tag=${2:?tag}
out=${3:?output dir}

# One zip per folder under plugins/ (no list to keep in sync): genos keeps its old name
# genos-claude-plugin.zip so existing links stay valid, every other folder is <name>-plugin.zip.
zipname() { if [ "$1" = genos ]; then echo genos-claude-plugin.zip; else echo "$1-plugin.zip"; fi; }

semver='^[0-9]+\.[0-9]+\.[0-9]+([-+][0-9A-Za-z.-]+)?$'
fail() { echo "ERROR: $*" >&2; exit 1; }
jget() { python3 -c 'import json,sys; print(json.load(open(sys.argv[1])).get(sys.argv[2], ""))' "$1" "$2"; }

[[ $tag =~ ^v[0-9] ]] || fail "tag '$tag' is not v<version>"
[ -d "$root/plugins/genos" ] || fail "plugins/genos is missing"
ORDER=()
for d in "$root"/plugins/*/; do
    [ -d "$d" ] && ORDER+=("$(basename "$d")")
done
mkdir -p "$out"
out=$(cd "$out" && pwd)

for name in "${ORDER[@]}"; do
    dir="$root/plugins/$name"
    manifest="$dir/.claude-plugin/plugin.json"
    [ -f "$manifest" ] || fail "$name: $manifest is missing"
    python3 -m json.tool "$manifest" > /dev/null || fail "$name: plugin.json is not valid JSON"
    [ "$(jget "$manifest" name)" = "$name" ] || fail "$name: plugin.json name is '$(jget "$manifest" name)'"
    version=$(jget "$manifest" version)
    [[ $version =~ $semver ]] || fail "$name: version '$version' is not semver"
    if [ -f "$dir/.mcp.json" ]; then
        python3 -m json.tool "$dir/.mcp.json" > /dev/null || fail "$name: .mcp.json is not valid JSON"
    fi
    if [ "$name" = genos ]; then
        [ -f "$dir/.mcp.json" ] || fail "genos: .mcp.json is missing"
        [ "v$version" = "$tag" ] || fail "tag $tag does not match the genos plugin version $version"
    fi
done

for name in "${ORDER[@]}"; do
    zipfile="$out/$(zipname "$name")"
    rm -f "$zipfile"
    (cd "$root/plugins/$name" && zip -qr "$zipfile" . -x '*.DS_Store')
    # the manifest must sit at the zip root, and still parse from inside the zip
    unzip -p "$zipfile" .claude-plugin/plugin.json | python3 -m json.tool > /dev/null \
        || fail "$name: manifest is not at the zip root"
    if unzip -l "$zipfile" | awk '{print $4}' | grep -q "^$name/"; then
        fail "$name: zip has a wrapping folder"
    fi
    echo "built $zipfile ($(unzip -l "$zipfile" | tail -1 | awk '{print $2}') files)" >&2
    echo "$(zipname "$name")"
done
