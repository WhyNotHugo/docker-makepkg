docker-makepkg
==============

[![build status](https://github.com/WhyNotHugo/docker-makepkg/actions/workflows/build.yaml/badge.svg)](https://github.com/WhyNotHugo/docker-makepkg/actions/workflows/build.yaml)

This docker image is intended to tests `PKGBUILDs`, by installing dependencies
and running `makepkg -f` in a clean Arch installation. It is intended to be
used by packagers, both via CI, and on non-ArchLinux environments.

The package can be saved to the current director by adding `-e EXPORT_PKG=1`,
and the updated .SRCINFO file for the built package with `-e EXPORT_SRC=1`.

Usage with travis
-----------------

Generally, this should be enough:

```
sudo: required

services:
 - docker

script:
  - docker run -v $TRAVIS_BUILD_DIR:/pkg whynothugo/makepkg
```

Usage locally
-------------

```
docker run -v $PWD:/pkg -e SYNC_DATABASE=1 whynothugo/makepkg
```

Or export the built package file to the working directory

```
docker run -e EXPORT_PKG=1 -v $PWD:/pkg whynothugo/makepkg
```

Or export the updated `.SRCINFO` for the package

```
docker run -e EXPORT_SRC=1 -v $PWD:/pkg whynothugo/makepkg
```

If you are running Arch, you can share the mirror list from your host by adding
`-v /etc/pacman.d/mirrorlist:/etc/pacman.d/mirrorlist:ro`.

Usage with GitLab CI
--------------------

Since GitLab CI uses Docker, it should be trivial to use these images there
too.

Extra details
-------------

* `base-devel` is pre-installed.
* All `depends` will be installed (including AUR packages using
  [paru](https://github.com/Morganamilo/paru)).
* You may pass `SYNC_DATABASE=1` to force a `pacman -Sy` to refresh the
  database, since it updates quite frequently.
* GPG keys used to verify signatures are auto-fetched.

Licence
-------

This repository is licensed under the ISC licence. See LICENCE for details.
