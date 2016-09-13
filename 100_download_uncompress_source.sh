#!/bin/bash

# fsfs3
# Scripts to convert "Free Software, Free Society" (3rd edition)
# by R. M. Stallman from Texinfo to EPUB and MOBI
#
# Copyright (C) 2016 Alberto Pettarin (alberto@albertopettarin.it)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

SRCURL="http://www.gnu.org/doc/fsfs3-hardcover.tar.gz"
FILE="fsfs3-hardcover.tar.gz"

PASS="1"
loginfo() {
    M="$1"
    echo "[INFO] Pass $PASS: $M"
    return 0
}

# start pass
loginfo "download and uncompress Texinfo source"

loginfo "  downloading source tarball..."
wget "$SRCURL"

loginfo "  uncompressing tarball..."
tar xf "$FILE"

exit 0

