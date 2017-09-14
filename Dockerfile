FROM base/archlinux

COPY run.sh /run.sh

# makepkg cannot (and should not) be run as root:
RUN useradd -m notroot

# Generally, refreshing without sync'ing is discouraged, but we've a clean
# environment here.
RUN pacman -Sy --noconfirm base-devel

# Allow notroot to run stuff as root (to install dependencies):
RUN echo "notroot ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/notroot

# Auto-fetch GPG keys (for checking signatures)
RUN sudo -u notroot mkdir /home/notroot/.gnupg
RUN sudo -u notroot touch /home/notroot/.gnupg/gpg.conf
RUN sudo -u notroot echo "keyserver-options auto-key-retrieve" > /home/notroot/.gnupg/gpg.conf

# Build the package
WORKDIR /pkg
CMD /bin/sh /run.sh
