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
DIRPREVIOUSPASS="pass4"
EPUBDIRPREVIOUSPASS="$DIRPREVIOUSPASS/fsfs3-epub3/"
DIR="pass5"
EPUBDIR="$DIR/fsfs3"
OEBPSDIR="$EPUBDIR/OEBPS"
OLDEPUB="$DIR/fsfs3/fsfs3.epub"
TMPA="zzz.a"
TMPB="zzz.b"
TMPC="zzz.c"
TMPD="zzz.d"
TMPE="zzz.e"

PASS="5"
loginfo() {
    M="$1"
    echo "[INFO] Pass $PASS: $M"
    return 0
}

patchfile() {
    W="$1"
    R="$2"
    MATCHES=`grep "$W" *.xhtml -l`
    TMP="zzz"
    loginfo "  replacing: $W"
    loginfo "  with:      $R"
    for MATCH in $MATCHES
    do
        loginfo "    patching $MATCH ..."
        cat $MATCH | sed -e "s^$W^$R^g" > "$TMP"
        mv "$TMP" "$MATCH"
        loginfo "    patching $MATCH ... done"
    done
    sync
    return 0
}

# start pass
loginfo "patch EPUB sources"

# create directory
loginfo "  creating $DIR ..."
rm -rf $DIR
mkdir $DIR
cp -r $EPUBDIRPREVIOUSPASS $EPUBDIR
rm -f $OLDEPUB

# copy files
loginfo "  copying files from $TEMPLATESSDIR ..."
cp "$TEMPLATESSDIR/fsfs3.xhtml" "$OEBPSDIR/"
cp "$TEMPLATESSDIR/toc.xhtml" "$OEBPSDIR/"
cp "$TEMPLATESSDIR/content.opf" "$OEBPSDIR/"
cp "$TEMPLATESSDIR/cover.xhtml" "$OEBPSDIR/"
cp "$TEMPLATESSDIR/cover.png" "$OEBPSDIR/"
cp "$TEMPLATESSDIR/fsfs30x.png" "$OEBPSDIR/"
cp "$TEMPLATESSDIR/fsfs31x.png" "$OEBPSDIR/"
cp "$TEMPLATESSDIR/fsfs346x.png" "$OEBPSDIR/"

cd $OEBPSDIR

# patch specific files to fix EPUB validation errors
W='id="fn0x0" class="footnote" epub:type="footnote" ><p>    <sup class="textsuperscript"></sup>Jacob Appelbaum'
R='id="fn0x0bis" class="footnote" epub:type="footnote" ><p>    <sup class="textsuperscript"></sup>Jacob Appelbaum'
patchfile "$W" "$R"

W='id="fn0x0" class="footnote" epub:type="footnote" ><p>    <sup class="textsuperscript"></sup>Lawrence Lessig'
R='id="fn0x0bis" class="footnote" epub:type="footnote" ><p>    <sup class="textsuperscript"></sup>Lawrence Lessig'
patchfile "$W" "$R"

W='id="fn0x39" class="footnote" epub:type="footnote" ><p>     <sup class="textsuperscript"></sup>Thank you to Matt Lee'
R='id="fn0x39bis" class="footnote" epub:type="footnote" ><p>     <sup class="textsuperscript"></sup>Thank you to Matt Lee'
patchfile "$W" "$R"

W='surveillance.html\\#SpywareInSkype'
R='surveillance.html#SpywareInSkype'
patchfile "$W" "$R"

W='list.html\\#GNUAllPermissive'
R='list.html#GNUAllPermissive'
patchfile "$W" "$R"

W='list.html\\#OtherLicenses'
R='list.html#OtherLicenses'
patchfile "$W" "$R"

W='list.html\\#ccbysa'
R='list.html#ccbysa'
patchfile "$W" "$R"

W='lein1.htm\\#VeQiuxcpDow'
R='lein1.htm#VeQiuxcpDow'
patchfile "$W" "$R"

W=' width="[0-9\.]*pt" height="[0-9\.]*pt"'
R=''
patchfile "$W" "$R"

W='href="licensing@gnu.org"'
R='href="mailto:licensing@gnu.org"'
patchfile "$W" "$R"

W='href="Wired"'
R='href="http://wired.com"'
patchfile "$W" "$R"

W='href="#x10-520001"'
R='href="fsfs3ch13.xhtml#x20-11200013"'
patchfile "$W" "$R"

W='href="h-node.org"'
R='href="http://h-node.org"'
patchfile "$W" "$R"

W='href="DefectiveByDesign.org"'
R='href="http://DefectiveByDesign.org"'
patchfile "$W" "$R"

W='href="u.fsf.org/ithings"'
R='href="http://u.fsf.org/ithings"'
patchfile "$W" "$R"

W='href="u.fsf.org/swindle"'
R='href="http://u.fsf.org/swindle"'
patchfile "$W" "$R"

W='href="u.fsf.org/ebookslist"'
R='href="http://u.fsf.org/ebookslist"'
patchfile "$W" "$R"

W='href="upgradefromwindows.org"'
R='href="http://upgradefromwindows.org"'
patchfile "$W" "$R"

W='href="mecenat-global.org"'
R='href="http://mecenat-global.org"'
patchfile "$W" "$R"

W='href="arXiv.org"'
R='href="http://arXiv.org"'
patchfile "$W" "$R"

W='href="licensing@fsf.org"'
R='href="mailto:licensing@fsf.org"'
patchfile "$W" "$R"

W='src="fsfs30x.png" alt="PIC" class="graphics"'
R='src="fsfs30x.png" alt="The categories of software" style="max-width:80%; margin-left:10%"'
patchfile "$W" "$R"

W='src="fsfs31x.png" alt="PIC" class="graphics"'
R='src="fsfs31x.png" alt="The process of code compilation" style="max-width:80%; margin-left:10%"'
patchfile "$W" "$R"

W='src="fsfs346x.png" alt="PIC" class="graphics"'
R='src="fsfs346x.png" alt="The free software song" style="max-width:80%; margin-left:10%"'
patchfile "$W" "$R"



# patch all XHTML files to clean the code up

loginfo "  patching all XHTML files to clean the code up"
for f in `ls *.xhtml`
do
    loginfo "  patching $f ..."
    # preprocess: <a \nSTUFF => <a STUFF
    cat $f | awk '/<a $/ { printf("%s", $0); next } 1' > "$TMPA"
    
    # remove empty <sup></sup>
    cat "$TMPA" | sed -e 's/ [ ]*<sup class="textsuperscript"><\/sup>//g' > "$TMPB"
    
    # patch footnote links/backlinks
    cat "$TMPB" | sed -e 's/<a href="\([^"]*\)" id="\([^"]*\)"><sup>\([^<]*\)<\/sup><\/a>/ <a href="\1" id="\2">\[\3\]<\/a> /g' > "$TMPC"
    cat "$TMPC" | sed -e 's/<sup><a href="\([^"]*\)" id="\([^"]*\)">\([^<]*\)<\/a><\/sup>/ <a href="\1" id="\2">\[\3\]<\/a> /g' > "$TMPD"
    
    # patch pageref
    cat "$TMPD" | sed -e 's/<a href="\([^"]*\)">\([^<]*\)<!--tex4ht:ref: .* --><\/a>/<a href="\1">\[link\]<\/a>/g' > "$TMPE"
    
    cp "$TMPE" $f
    rm "$TMPA" "$TMPB" "$TMPC" "$TMPD" "$TMPE"
    loginfo "  patching $f ... done"
done

cd ../../..

exit 0

