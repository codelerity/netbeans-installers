#!/bin/bash

#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
if [ -z "$1" ] || [ -z "$2" ] ; then
    echo "usage: $0 appSigningIdentity entitlements appDir"
    echo "appSigningIdentity is Apple Developer ID Application certificate used for signing"
    echo "entitlements is code signing entitlements file"
    exit 1;
fi

function abs_filename() {
  echo "$(cd "$(dirname "$1")" && pwd)/$(basename "$1")"
}

appSigningIdentity="$1"
entitlements=$(abs_filename "$2")

function signBinaryFromJar() {
  mkdir "tmpdir"
  cd "tmpdir"
  jar tf "../$1" | grep '\.dylib\|\.jnilib'  > filelist.txt
  while read f
  do
    echo "$f"
    jar xf "../$1" "$f"
    codesign --force --timestamp --options=runtime --entitlements "$entitlements" -s "$appSigningIdentity" -v "$f"
    jar uf "../$1" "$f"
    #rm -r "$f"
  done < filelist.txt
  rm filelist.txt
  cd ..
  rm -r "tmpdir"
}

if [ -f jarBinaries ]; then
  while read f
  do
    echo "$f"
    signBinaryFromJar "$f"
  done < jarBinaries
fi

if [ -f nativeBinaries ]; then
  while read f
  do
    echo "$f"
    codesign --force --timestamp --options=runtime --entitlements "$entitlements" -s "$appSigningIdentity" -v "$f"
  done < nativeBinaries
fi

if [ -f jdkBinaries ]; then
  while read f
  do
    echo "$f"
    codesign --force --timestamp --options=runtime --entitlements "$entitlements" -s "$appSigningIdentity" -v "$f"
  done < jdkBinaries
fi
