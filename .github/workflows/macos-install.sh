#!/bin/bash

set -e

brew install libjpeg libpng cmake nasm ninja meson

if [ "$GHA_PYTHON_VERSION" == "2.7" ]; then
    python2 -m pip install -U tox tox-gh-actions
else
    python3 -m pip install -U tox tox-gh-actions
fi

# TODO Remove when 3.8 / 3.9 includes setuptools 49.3.2+:
if [ "$GHA_PYTHON_VERSION" == "3.8" ]; then python3 -m pip install -U "setuptools>=49.3.2" ; fi
if [ "$GHA_PYTHON_VERSION" == "3.9" ]; then python3 -m pip install -U "setuptools>=49.3.2" ; fi

# libavif
pushd depends && ./install_libavif.sh && popd
