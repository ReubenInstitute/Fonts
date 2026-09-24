#!/bin/sh
# Build fonts_<version>_all.deb
# Usage: packaging/deb/build.sh
set -eu

cd "$(dirname "$0")/../.."
REPO_ROOT="$(pwd)"
VERSION="0.$(git rev-list --count HEAD)"
sed -i "s/^Version: .*/Version: $VERSION/" packaging/deb/control

PKG_DIR="$REPO_ROOT/debian-pkg"
rm -rf "$PKG_DIR"
mkdir -p "$PKG_DIR/DEBIAN" "$PKG_DIR/usr/share/fonts/reubeninstitute"
cp packaging/deb/control "$PKG_DIR/DEBIAN/control"
cp *.ttf *.otf *.woff2 "$PKG_DIR/usr/share/fonts/reubeninstitute/"
cp -r licenses "$PKG_DIR/usr/share/fonts/reubeninstitute/"
dpkg-deb --build --root-owner-group "$PKG_DIR" "fonts_${VERSION}_all.deb"
rm -rf "$PKG_DIR"
echo "Built fonts_${VERSION}_all.deb"
