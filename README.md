# fsfs3

Scripts to convert "Free Software, Free Society: Selected Essays of Richard M. Stallman, 3rd Edition" from Texinfo to EPUB and MOBI

* Version: 1.0.0
* Date: 2016-09-13
* Developer: [Alberto Pettarin](http://www.albertopettarin.it/)
* License: the GPL license, version 3 (GPLv3)
* Contact: [click here](http://www.albertopettarin.it/contact.html)

## Download Pre-Built eBooks

If you just want to download the pre-built EPUB or MOBI eBooks of
[Free Software, Free Society: Selected Essays of Richard M. Stallman, 3rd Edition](https://shop.fsf.org/books-docs/free-software-free-society-selected-essays-richard-m-stallman-3rd-edition),
the files are located in the
[Release tab](https://github.com/pettarin/fsfs3/releases).

## Build From Source

Clone this repository:

```bash
$ git clone https://github.com/pettarin/fsfs3.git
```

or download the ``master`` as a ZIP file and decompress it.

Enter the ``fsfs3`` directory:

```bash
$ cd fsfs3
```

To download the Texinfo source files
and covert them to EPUB and MOBI, run:

```bash
$ bash 000_convert_fsfs3.sh
```

Alternatively, you can run each step separately:

```bash
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
```

The compiled ebooks will be located inside the ``output/`` directory.

To clean the working directory:

```bash
$ bash 999_clean.sh
```

### Requirements

To build from source, you need:

1. Bash (with ``tar``, ``zip``, etc.)
2. Python 2.7.x or 3.x
3. ``tex4ebook``
4. ``kindlegen`` in your ``$PATH`` (for MOBI output) 

## License

The scripts in **fsfs3** are released under the terms of the GNU General Public License version 3 (GPLv3).

