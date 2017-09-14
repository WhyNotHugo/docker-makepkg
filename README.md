docker-makepkg
==============

This docker image is intended to tests `PKGBUILDs`, by running `makepkg -sf` in
a clean Arch installation.
It is intended to be used by packagers, both via CI, and on non-ArchLinux
environments.

Retrieval of GPG keys is also handled transparently.

Usage with travis
-----------------

Generally, this should be enough:

```
sudo: required

services:
 - docker

script:
  - docker run -v $TRAVIS_BUILD_DIR:/pkg hobarrera/makepkg
```

Usage locally
-------------

```
docker run -v $(pwd):/pkg hobarrera/makepkg
```

Usage with GitLab CI
--------------------

Since GitLab CI uses Docker, it should be trivial to use these images there
too.

Licence
-------

This repository is licensed under the ISC licence. See LICENCE for details.


