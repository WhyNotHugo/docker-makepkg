#!/bin/bash

set -e

# Make a copy so we never alter the original
cp -r /pkg /tmp/pkg
cd /tmp/pkg

# Install (official repo + AUR) dependencies using yay. We avoid using makepkg
# -s since it is unable to install AUR dependencies.
depends=(); makedepends=()
# shellcheck disable=1091
. ./PKGBUILD
deps=( "${depends[@]}" "${makedepends[@]}" )
pacman --deptest "${deps[@]}" | xargs yay -Sy --noconfirm

# Do the actual building
makepkg -f

# Store the built package(s). Ensure permissions match the original PKGBUILD.
if [ -n "$EXPORT_PKG" ]; then
    sudo chown "$(stat -c '%u:%g' /pkg/PKGBUILD)" ./*pkg.tar*
    sudo mv ./*pkg.tar* /pkg
fi
