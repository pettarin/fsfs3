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

TEMPLATESSDIR="templates"
DIRPREVIOUSPASS="pass2"
DIR="pass3"
DIRIMAGES="$DIR/images"
MAINTEX="$DIR/fsfs3.tex"
TMPTEX="$DIR/zzz.fsfs3.tex"

PASS="3"
loginfo() {
    M="$1"
    echo "[INFO] Pass $PASS: $M"
    return 0
}

# start pass
loginfo "patching LaTeX sources"

# create directory
loginfo "  creating $DIR ..."
rm -rf $DIR
cp -r $DIRPREVIOUSPASS $DIR

# convert PDF images to PS
cd $DIRIMAGES
for f in `ls *.pdf`
do
    loginfo "  converting $f ..."
    pdf2ps "$f"
done
cd ../..

# comment \DeclareGraphicsExtensions out
loginfo "  patching $MAINTEX ..."
mv "$MAINTEX" "$TMPTEX"
cat "$TMPTEX" | sed -e "s/\\\DeclareGraphicsExtensions/%\\\DeclareGraphicsExtensions/" > "$MAINTEX"
rm "$TMPTEX"

exit 0

