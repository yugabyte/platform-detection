#!/usr/bin/env bash

# Copyright (c) Yugabyte, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except
# in compliance with the License. You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software distributed under the License
# is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
# or implied. See the License for the specific language governing permissions and limitations
# under the License.

export TWINE_USERNAME=yugabyte

set -euo pipefail -x
cd "${BASH_SOURCE[0]%/*}"/..

rm -f dist/*
. venv/bin/activate
pip3 install setuptools
python3 setup.py sdist

# Set up your .pypirc file as follows;
#
# [distutils]
# index-servers =
#   pypi
#   llvm-installer
#
# [pypi]
# repository = https://upload.pypi.org/legacy/
#
# [sys-detection]
# repository = https://upload.pypi.org/legacy/
# username = __token__
# password = pypi-... (the actual token value)

venv/bin/python3 -m twine upload --repository sys-detection dist/*
