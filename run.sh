#!/bin/sh

# Make a copy so we never alter the original
cp -r /pkg /tmp/pkg

# Make sure we can RW the copy
chown -R notroot /tmp/pkg
chmod -R u+rw /tmp/pkg
find /tmp/pkg -type d -exec chmod u+x {} \;

# Do the actual building
cd /tmp/pkg
sudo -u notroot makepkg -fs --noconfirm
