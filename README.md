docker-makepkg
==============

This docker image is intended to tests `PKGBUILDs`, by installing dependencies
and running `makepkg -f` in a clean Arch installation. It is intended to be
used by packagers, both via CI, and on non-ArchLinux environments.

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
docker run -v $PWD:/pkg whynothugo/makepkg

# Or export the built package file to the workding directory
docker run -e EXPORT_PKG=1 -v $PWD:/pkg whynothugo/makepkg
```

Usage with GitLab CI
--------------------

Since GitLab CI uses Docker, it should be trivial to use these images there
too.

Extra details
-------------

* `base-devel` is preinstalled.
* All `depends` will be installed (including AUR packages using [yay](https://github.com/Jguer/yay)).
* GPG keys used to verify signatures are auto-fetched.

Licence
-------

This repository is licensed under the ISC licence. See LICENCE for details.
