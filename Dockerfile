FROM base/archlinux

COPY . /pkg
WORKDIR /pkg

# makepkg cannot (and should not) be run as root:
RUN useradd -m notroot

# Allow notroot to run stuff as root (to install dependencies):
RUN mkdir /etc/sudoers.d
RUN echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot
RUN chmod 400 /etc/sudoers.d/notroot

# Also, make sure we can do the actual building
RUN chown -R notroot /pkg

# Generally, refreshing without sync'ing is discouraged, but we've a clean
# environment here.
RUN pacman -Sy --noconfirm base-devel

# Auto-fetch GPG keys (for checking signatures)
RUN sudo -u notroot mkdir /home/notroot/.gnupg
RUN sudo -u notroot touch /home/notroot/.gnupg/gpg.conf
RUN sudo -u notroot echo "keyserver-options auto-key-retrieve" > /home/notroot/.gnupg/gpg.conf

# Build the package
CMD sudo -u notroot makepkg -fs --noconfirm
