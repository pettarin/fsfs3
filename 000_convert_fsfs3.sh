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

# clean working directory
bash "999_clean.sh"

# download and uncompress Texinfo source
bash "100_download_uncompress_source.sh"

# convert Texinfo to LaTeX
bash "200_texi_to_tex.sh"

# patch LaTeX sources
bash "300_patch_tex.sh"

# run tex4ebook
bash "400_run_tex4ebook.sh"

# patch EPUB sources
bash "500_patch_epub.sh"

# compress output EPUB and MOBI
bash "600_output_ebooks.sh"

exit 0

