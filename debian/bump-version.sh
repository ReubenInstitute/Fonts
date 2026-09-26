#!/bin/sh
# Run this before committing. Bumps the version to match the commit
# count your commit is about to produce (current count + 1), so once
# committed, the version in debian/changelog is exactly correct.
# Usage: debian/bump-version.sh
set -eu

cd "$(dirname "$0")/.."

COUNT="$(($(git rev-list --count HEAD) + 1))"
MAJOR="$(sed -n '1s/^fonts (\([0-9]*\)\..*/\1/p' debian/changelog)"
VERSION="$MAJOR.$COUNT"

sed -i "1s/^fonts (.*)/fonts ($VERSION)/" debian/changelog

echo "Bumped to $VERSION"
