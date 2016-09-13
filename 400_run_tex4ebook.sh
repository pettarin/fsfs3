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
DIRPREVIOUSPASS="pass3"
DIR="pass4"
CONFIG="../templates/fsfs3_tex4ebook.cfg"
MAINTEX="fsfs3.tex"
TMPLOG="/tmp/fsfs3.tex4ebook.log"

PASS="4"
loginfo() {
    M="$1"
    echo "[INFO] Pass $PASS: $M"
    return 0
}

# start pass
loginfo "run tex4ebook"

# create directory
loginfo "  creating $DIR ..."
rm -rf $DIR
cp -r $DIRPREVIOUSPASS $DIR

# create XHTML files running tex4ebook
loginfo "  creating XHTML files (takes a while) ..."
loginfo "    (the tex4ebook log is at $TMPLOG)"
cd $DIR
tex4ebook -c "$CONFIG" -f "epub3" -r "300" -t "$MAINTEX" "xhtml,2,charset=utf-8" " -cunihtf -utf8" 2> "$TMPLOG" > "$TMPLOG"
cd ..
loginfo "  creating XHTML files (takes a while) ... done"

exit 0

