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

DIRPREVIOUSPASS="pass5"
EPUBDIR="$DIRPREVIOUSPASS/fsfs3"
OUTPUTDIR="output"
EPUB="$OUTPUTDIR/fsfs3.epub"
MOBI="$OUTPUTDIR/fsfs3.mobi"

PASS="6"
loginfo() {
    M="$1"
    echo "[INFO] Pass $PASS: $M"
    return 0
}

# start pass
loginfo "output ebooks"

# removing output
rm -f "$EPUB" "$MOBI"

# create EPUB
loginfo "  compressing EPUB $EPUB ..."
cd $EPUBDIR
zip -DX0 "../../$EPUB" "mimetype" > /dev/null
zip -DrX9 "../../$EPUB" "META-INF" "OEBPS" > /dev/null
cd ../..
loginfo "  compressing EPUB $EPUB ... done"

# create MOBI
loginfo "  compressing MOBI $MOBI ..."
kindlegen $EPUB > /dev/null
loginfo "  compressing MOBI $MOBI ... done"

exit 0

