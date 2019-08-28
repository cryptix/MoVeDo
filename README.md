# MoVeDo - Modular, Versioned Documentation

A build tool for your Markdown based, git hosted documentation.
Think of it like `gradle`, `leiningen`, `maven`, `grunt`, or any other build tool that mainly relies on convention (over configuration) -- but for your documentation.

By default it:

* supports pre-processing with PP
* produces one HTML file per Markdown file
* produces a single, fused Markdown file
* produces a single PDF file
* uses YAML Front-Matter document meta-data
* promotes/suggests/uses *Pandoc's Markdown* (a Markdown flavor)

## Use-Case

### Expected Input

A directory structure sketch of a sample project using MoVeDo:

```
/about.md                           # part of the beginning of the docu
/index.md                           # part of multi-file outputs like HTML, but not PDF
/LICENSE.md                         # treated as repo file -> excluded from the docu
/README.md                          # treated as repo file -> excluded from the docu
/cptrs/01_intro/01_section1.md      # (Pandoc's) Markdown file, part of the docu
/cptrs/01_intro/02_section2.pp.md   # PP pre-processor annotated Markdown file
/cptrs/02_action/01_begining.pp.md
/cptrs/02_action/02_end.md
/index-md.txt                       # optional; It denotes which *.md files appear in which order
                                    # in single-file outputs like PDF
/movedo/                            # git sub-module linked to this repo
```

### Sample Output

by default, all output is generated in the `build` directory, and for the above project would look like:

```
/build/gen-src/index-md.txt                    # either copied from the source, or auto-generated
                                               # from the FS structure of the *.md files.
                                               # It denotes which *.md files appear in which order
                                               # in single-file outputs like PDF
/build/gen-src/index.md
/build/gen-src/about.md
/build/gen-src/cptrs/01_intro/01_section1.md
/build/gen-src/cptrs/01_intro/02_section2.md   # PP pre-processing is done here
/build/gen-src/cptrs/01_intro/03_section3.md
/build/gen-src/cptrs/02_action/01_begining.md
/build/gen-src/cptrs/02_action/02_end.md
/build/gen-src/doc.md                          # all the above Markdown files fused into one
/build/html/index.html
/build/html/cptrs/01_intro/01_section1.html
/build/html/cptrs/01_intro/02_section2.html
/build/html/cptrs/01_intro/03_section3.html
/build/html/cptrs/02_action/01_begining.html
/build/html/cptrs/02_action/02_end.html
/build/pdf/doc.pdf                             # doc.md converted into a PDF
```

## How to use

In your git repo containing the Markdown sources, add this repo as a sub-module:

```bash
git submodule add https://github.com/movedo/MoVeDo.git movedo
```
(and then commit this)

other devs will then have to check the sub-module out as well:

```bash
git submodule update --init
```

or do it right when cloning your repo:

```bash
git clone --recurse-submodules https://github.com/GH_USER/GH_REPO.git
```

from then on, you can use MoVeDo for building your docu like this:

```bash
movedo/scripts/build
```

This would generate output like shown in [Sample Output].

## Directory Structure

The main directories of this repo are:

```
/scripts/        # BASH scripts that may be used by a "client"-project to generate artifacts
/filters/        # Python Panflute Pandoc filters, that act as little helpers
                 # when dealing with multiple Markdown files that are meant to be fused together
                 # into a single document
/test/filters/   # Unit-tests for the filters mentioned above
```

## Running tests

```bash
test/filters/_all.sh
```
