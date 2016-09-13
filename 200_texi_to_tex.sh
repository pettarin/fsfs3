#/bin/bash

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

FSFS3SOURCEDIR="fsfs3-hardcover"
FSFS3SOURCETRANSLATIONS="$FSFS3SOURCEDIR/fs-translations"
TEMPLATESSDIR="templates"
PASSDIR="pass2"
DIRIMAGES="$PASSDIR/images"
SCRAP="$PASSDIR/scrap1.texi"
SCRAPPDF="$DIRIMAGES/scrap1.pdf"
SCRIPT="texi2tex.py"

PASS="2"
loginfo() {
    M="$1"
    echo "[INFO] Pass $PASS: $M"
    return 0
}

# start pass
loginfo "convert Texinfo to LaTeX"

# create directory
loginfo "  creating $PASSDIR ..."
rm -rf $PASSDIR
mkdir $PASSDIR $DIRIMAGES

# copy texi files into directory
loginfo "  copying TEXI files ..."
cp $FSFS3SOURCEDIR/*.texi $PASSDIR

# we do not need scrap1.texi or scrap1.pdf, remove it
loginfo "  removing $SCRAP ..."
rm $SCRAP

# copy image files into the images/ directory
for f in `ls $FSFS3SOURCEDIR/*.pdf`
do
    loginfo "  copying $f ..."
    cp $f $DIRIMAGES
done
loginfo "  removing $SCRAPPDF ..."
rm $SCRAPPDF

# copy image files for the gratis/libre translations into the images/ directory
for f in `ls $FSFS3SOURCETRANSLATIONS/*.pdf`
do
    loginfo "  copying $f ..."
    cp $f $DIRIMAGES
done

# convert Texinfo to LaTeX using the given Python script
cp $SCRIPT $PASSDIR
cd $PASSDIR
for f in `ls *.texi`
do
    loginfo "  converting $f ..."
    python $SCRIPT $f
done
loginfo "  removing $SCRIPT ..."
rm -f $SCRIPT
cd ..

# copy over the .tex files in the templates/ directory
for f in `ls $TEMPLATESSDIR/*.tex`
do
    loginfo "  copying $f ..."
    cp $f $PASSDIR
done

exit 0

