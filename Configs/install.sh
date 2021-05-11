#!/bin/sh

mkdir -m 755 -p /etc/hufo
install -o root -g root -m 644 aj-snapshot /etc/hufo
