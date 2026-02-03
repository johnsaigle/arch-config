#!/usr/bin/env bash

sudo paccache -rk2

rm -rf ~/.cache/paru/clone/*

yarn cache clean

docker image prune -a
