#!/bin/bash

src=/
dst=conf

mkdir -p $dst/etc/
mkdir -p $dst/var/named/

cp -r $src/etc/named.* $dst/etc/;
cp -r $src/var/named/* $dst/var/named/;
