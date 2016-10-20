#!/usr/bin/env bash

GO=/usr/local/go/bin/go
export CC="/usr/local/musl/bin/musl-gcc"

if [ "$1" == "build" ]; then
  shift
  $GO build -a -v --ldflags '-linkmode external -extldflags "-static"' $@
else
  $GO $@
fi
