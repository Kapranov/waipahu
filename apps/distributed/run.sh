#!/usr/bin/env bash
set -e

case $(uname | tr '[:upper:]' '[:lower:]') in
  bsd*)
    export OSTYPE=bsd
    ;;
  linux*)
    export OSTYPE=linux
    ;;
  darwin*)
    export OSTYPE=osx
    ;;
  msys*)
    export OSTYPE=windows
    ;;
  solaris*)
    export OSTYPE=solaris
    ;;
  *)
    export OSTYPE=notset
    ;;
esac

case $"$OSTYPE" in
  darwin*) IP=$(dscacheutil -q host -a name localhost.example | grep ip_address | head -n 1 | awk '{print $2}') ;;
  solaris|linux|msys|bsd*) IP=$(getent hosts localhost.example | head -n 1 | awk '{print $1}') ;;
  *) echo "Cannot retrieve IP for hostname localhost.example" && exit 1 ;;
esac

if [ "$IP" != "127.0.0.1" ]; then
  echo "The hostname localhost.example seems to point to $IP instead of 127.0.0.1"
  read -p "Are you sure you want to continue? (y/N) " REPLY
  if [[ ! "$REPLY" =~ ^[Yy]$ ]]; then
    exit 1
  fi
fi

rm -f *.beam
erl -compile ./src/foo
erl -compile ./src/bar
erl -noshell -name "foo@localhost.example" -s foo -s init stop & \
erl -noshell -name "bar@localhost.example" -s bar -s init stop
