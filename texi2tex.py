#!/usr/bin/env python
# coding=utf-8

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

from __future__ import absolute_import
from __future__ import print_function
import io
import re
import os
import sys

__author__ = "Alberto Pettarin"
__copyright__ = "Copyright 2016, Alberto Pettarin (www.albertopettarin.it)"
__license__ = "GPL"
__version__ = "0.0.1"
__email__ = "alberto@albertopettarin.it"
__status__ = "Development"


REPLACEMENTS = [
    # simple replacements
    ("?@entrybreak{}It", "? It"),
    ("@entrybreak{}in the Age of Computer Networks", "in the Age of Computer Networks"),
    ("r=US&IR", "r=US&amp;IR"),
    ("pagewanted=all&_r", "pagewanted=all&amp;_r"),

    ("html#GNUAllPermissive", "html\\#GNUAllPermissive"),
    ("html#OtherLicenses", "html\\#OtherLicenses"),
    ("html#ccbysa", "html\\#ccbysa"),
    ("htm#.VeQiuxcpDow", "htm\\#VeQiuxcpDow"),
    ("html#SpywareInSkype", "html\\#SpywareInSkype"),

    ("1@setfilename words.info", ""),
    ("Mis@'erables", "Mis\\'erables"),
    ("Jos@'{e}", "Jos\\'e"),
    ("SaaSS@.", "SaaSS."),
    ("SaaSS@!", "SaaSS!"),
    ("SaaSS@?", "SaaSS?"),
    ("& Cohen", "\& Cohen"),
    ("RMS%MIT-OZ@@mit-eddie", "RMS\\%MIT-OZ@mit-eddie"),
    ("R&D@", "R\&D"),
    ("AT&T", "AT\&T"),
    ("The News Media & the Law", "The News Media \& the Law"),
    ("{@parfillskip=0pt@par}@page@noindent", ""),
    ("@advance@vsize by 6pt", ""),
    ("@normalbottom", ""),
    ("@interlinepenalty = -200", ""),
    ("@hglue@defaultparindent", ""),
    ("@kern -0.5pt", ""),
    ("@kern -1pt", ""),
    ("@*\n@smallskip", "\n\n\\smallskip"),

    ("@ ", " "),
    ("@{", "\\{"),
    ("@}", "\\}"),
    ("#@*", "\\#"),
    ("@*", ""),
    (".@/", "."),
    ("/@/", "/"),
    ("@/", "/"),
    ("@.", "."),
    ("@:", " "),
    ("@c ", "% "),
    ("@r{", "\\textit{"),
    ("@comma{}", ","),

    ("@\"", "\\\""),
    ("@'", "\\'"),
    ("@=", "\\="),
    ("@~", "\\~"),
    ("@dh{}", "\\dh{}"),
    ("@dotless{i}", "\\i{}"),
    ("@ogonek{i}", "\\k{i}"),
    ("@dotaccent", "\\dotaccent"),
    ("@udotaccent", "\\udotaccent"),
    ("@ubaraccent", "\\ubaraccent"),

    ("@multitable @columnfractions .03 .17 .45 .35\n@global@hbadness=10000 @global@hfuzz=3.4pt", "\\begin{itemize}"),
    ("@end multitable", "\\end{itemize}"),
    (" @tab ", ", "),

    ("@bullet", ""),
    ("@entrybreak{}", "\\\\ "),
    ("@anchor{", "\\label{"),
    ("@dots{}", "\\dots{}"),
    ("@cite{", "\\cit{"),
    ("@code{", "\\code{"),
    ("@dfn{", "\\dfn{"),
    ("@emph{", "\\emph{"),
    ("@file{", "\\file{"),
    ("@footnote{@c", "\\footnote{"),
    ("@footnote{", "\\footnote{"),
    ("@footnoterule", ""),
    ("@enumerate", "\\begin{enumerate} %%% TODO"),
    ("@end enumerate", "\\end{enumerate}"),
    # ("@smallexample", "\\begin{smallexample}"),
    # ("@end smallexample", "\\end{smallexample}"),
    ("@smallexample", "\\begin{quot}"),
    ("@end smallexample", "\\end{quot}"),
    ("@smallquotation", "\\begin{smallquotation}"),
    ("@end smallquotation", "\\end{smallquotation}"),
    ("@display", "\\begin{flushleft}"),
    ("@end display", "\\end{flushleft}"),
    ("@group", "%%%"),
    ("@begingroup", "%%%"),
    ("@endgroup", "%%%"),
    ("@end group", "%%%"),
    ("@itemize", "\\begin{itemize} %%% TODO"),
    ("@end itemize", "\\end{itemize}"),
    ("@item", "\\item"),
    ("@flushright", ""),
    ("@end flushright", ""),
    ("@raggedright", ""),
    ("@end raggedright", ""),
    ("@fsfstwocite", "\\fsfstwocite"),
    ("@fsfsthreecite", "\\fsfsthreecite"),                   # added in v3
    ("@acronym{GNU}", "GNU"),
    ("@pageref{", "\\pageref{"),
    # ("@firstcopyingnotice{", "\\fcn{"),
    # ("@secondcopyingnotice{", "\\scn{"),
    # ("@thirdcopyingnotice{", "\\tcn{"),                      # added in v3
    ("@strong{", "\\textbf{"),
    ("@indent", "\\indent"),
    ("@noindent", "\\noindent"),
    ("@tex", "%%% @tex"),
    ("\\global\\let\\thisfootno\\", "%%% \\global\\let\\thisfootno\\"),
    ("\\global\\def\\unnumberedfootnote{\\footnotezzz}%", "%%% \\global\\def\\unnumberedfootnote{\\footnotezzz}%"),
    ("@end tex", "%%% @end tex"),
    ("@TeX{}", "\\TeX{}"),
    ("@tie{}", "~"),
    ("@dmn{", "\\dmn{"),
    ("@w{}", " "),
    ("@w{ }", " "),
    ("@w{Already}", "Already"),
    ("@copyright{}", "\\copyright{}"),
    ("@b{", "\\textbf{"),
    ("@t{", "\\texttt{"),
    ("@sc{", "\\textsc{"),
    ("@smallskip", "\\smallskip"),
    ("@medskip", "\\medskip"),
    ("@bigskip", "\\bigskip"),
    ("@vskip -1pc\n", ""),
    ("@vskip", "% @vskip"),
    ("@vglue", "% @vglue"),
    ("@uref{", "\\url{"),
    ("@pageno", "%%% pageno"),
    ("@page", "\\newpage"),
    ("@url{", "\\url{"),
    ("@email{", "\\url{"),
    ("@sp", "\\vskip 1em %%%"),
    ("@lessigbio", "\\lessigbio"),
    ("@appelbaumbio", "\\appelbaumbio"),
    ("@jstrap", "\\jstrap"),
    ("$", "\$"),
    ("\\footnote{\n", "\\footnote{"),
    ("\n\n}", "\n}"),
    ("@@", "@"),

    # ignores
    ("@cindex", "%%% TODOFSFS @cindex"),
    ("@rgindex", "%%% TODOFSFS @rgindex"),
]

REGEXES = [
    (r"^@oddheading .*$", r""),
    (r"^@part (.*)$", r"\\part{\1}"),
    (r"^@unnumbered (.*)$", r"\\chapter*{\1}\n\\phantomsection\n\\addcontentsline{toc}{chapter}{\1}"),
    (r"^@chapter (.*)$", r"\\chapter{\1}"),
    (r"^@heading (.*)$", r"\\section*{\1}"),
    (r"^@subheading (.*)$", r"%%% TODOFSFS @subheading\n\\section*{\1}\n\\phantomsection\n"),
    (r"^@subsubheading (.*)$", r"%%% TODOFSFS @subsubheading\n\\section*{\1}\n\\phantomsection\n"),
    (r"^@center (.*)$", r"\\begin{center}\n\1\n\\end{center}"),
    (r"@lowerbox{([^,]*), @image{fs-translations/([^,]*),,([^}]*)}}", r"\\lowerimage{\1}{\3}{\2}"),
    (r"@image{([^,]*),,([^}]*)}", r"\\includegraphics[width=\2]{\1}"),
    (r"@samp{([^}]*)}", r"`\1'"),
    (r"@var{([^}]*)}", r"\1"),
]


def usage():
    print("\nUsage: $ python %s FILE.TEXI\n" % sys.argv[0])
    sys.exit(2)


def fix_node(s):
    """ Fix @node labels """
    def fix_line(l):
        if l.startswith("@node"):
            labels = l[len("@node "):].split(",")
            labels = [lab.strip() for lab in labels]
            labels = [lab for lab in labels if not (lab.startswith("Top") or lab.startswith("Section") or lab.startswith("Part"))]
            # NOTE taking only the first one seems to work better
            labels = [labels[0]]
            s = ""
            for lab in labels:
                s += "\\label{%s}" % lab
            return s
        return l
    return "\n".join([fix_line(l) for l in s.splitlines()])


def fix_quot(s):
    """ Fix quot in initial-annoucement.texi """
    lines = s.splitlines()
    acc = []
    skip_next = False
    for line in lines:
        if line.startswith("@raggedright @smallfonts"):
            acc.append("\\begin{quot}")
            skip_next = True
        else:
            if skip_next:
                skip_next = False
            else:
                acc.append(line)
    acc2 = []
    first = True
    for line in acc:
        if first:
            if line.startswith("@end raggedright"):
                first = False
            else:
                acc2.append(line)
        else:
            if line.startswith("@end raggedright"):
                acc2.append("\\end{quot}")
            else:
                acc2.append(line)
    return "\n".join(acc2)


def fix_copying_notices(s):
    """ Fix copying notices """
    def find_end_line(lines, i, raw):
        line = lines[i].replace(raw, "")
        count = 0
        while True:
            # print("EVAL line: '%s'" % line)
            for j, c in enumerate(line):
                if c == "{":
                    count += 1
                elif c == "}":
                    count -= 1
                if count == 0:
                    break
            if count == 0:
                break
            i += 1
            line = lines[i]
        return (i + 1, j)

    s = s.replace("@vskip -6pt", "")
    for r in ["@firstcopyingnotice", "@secondcopyingnotice", "@thirdcopyingnotice"]:
        s = s.replace(r, "\n" + r)

    start = None
    end = None
    lines = s.splitlines()
    found_rep = None
    for (raw, rep) in [
        ("@firstcopyingnotice", "fcn"),
        ("@secondcopyingnotice", "scn"),
        ("@thirdcopyingnotice", "tcn")
    ]:
        for i, line in enumerate(lines):
            if line.startswith(raw):
                start = i
                end, end_char = find_end_line(lines, i, raw)
                found_rep = rep
                break
    if (start is not None) and (end is not None) and (found_rep is not None):
        # print("Lines found:")
        # for j in range(start, end):
        #     print(lines[j])
        first = ""
        second = ""
        in_first = True
        for j in range(start, end):
            if in_first:
                if "Copyright" in lines[j]:
                    idx = lines[j].find("Copyright")
                    first = lines[j][idx:]
                    in_first = False
            else:
                if j == end - 1:
                    second += lines[j][:end_char] + "\n"
                else:
                    second += lines[j] + "\n"
        second = second[:-2]
        first = first.replace("\n", " ")
        second = second.replace("\n", " ")
        # print("First:  " + first)
        # print("Second: " + second)
        lines[start:end] = ["\\%s{%s}{%s}" % (found_rep, first, second)]
        # lines[start:end] = ["\\%s{%s}{%s}" % (found_rep, "TODO", "TODO")]
    return "\n".join(lines)


def fix_label(s):
    """ Invert \label \chapter => \chaper \label """
    lines = s.splitlines()
    label_line = None
    chapter_line = None
    for i, line in enumerate(lines):
        # print("EVAL: " + line)
        if (label_line is None) and (line.startswith("\\label")):
            # print("FOUND LABEL %d" % i)
            label_line = i
        if (chapter_line is None) and (line.startswith("\\chapter")):
            # print("FOUND CHAPTER %d" % i)
            chapter_line = i
        if (label_line is not None) and (chapter_line is not None):
            break
    if (label_line is not None) and (chapter_line is not None):
        # print("SWAPPING")
        tmp = lines[label_line]
        lines[label_line] = lines[chapter_line]
        lines[chapter_line] = tmp
        tmp = label_line
        label_line = chapter_line
        chapter_line = tmp

    xcn_line = None
    for i, line in enumerate(lines):
        if ("\\fcn" in line) or ("\\scn" in line) or ("\\tcn" in line):
            xcn_line = i
            break
    if (chapter_line is not None) and (xcn_line is not None):
        lines = lines[:(chapter_line + 2)] + [lines[xcn_line]] + lines[(chapter_line + 2):xcn_line] + lines[(xcn_line + 1):]

    # for i in range(5):
    #     print(lines[i])
    return "\n".join(lines)


def main():
    if len(sys.argv) < 2:
        print("[ERRO] You need to specify an input file.")
        usage()

    input_file_path = sys.argv[1]

    if not input_file_path.endswith(".texi"):
        print("[ERRO] File '%s' is not a TEXI file!" % (input_file_path))
        usage()

    if not os.path.exists(input_file_path):
        print("[ERRO] File '%s' does not exist." % (input_file_path))
        usage()

    output_file_path = input_file_path[:-5] + ".tex"

    with io.open(input_file_path, "r", encoding="utf-8") as input_file:
        contents = input_file.read()

        if input_file_path == "initial-announcement.texi":
            contents = fix_quot(contents)

        contents = fix_node(contents)

        contents = fix_copying_notices(contents)

        for rep_what, rep_with in REPLACEMENTS:
            contents = contents.replace(rep_what, rep_with)
        for rep_what, rep_with in REGEXES:
            contents = re.sub(rep_what, rep_with, contents, flags=re.MULTILINE)

        contents = fix_label(contents)

    with io.open(output_file_path, "w", encoding="utf-8") as output_file:
        output_file.write(contents)

    sys.exit(0)


if __name__ == "__main__":
    main()
