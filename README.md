latex
=====

LaTeX manuscript templates, bibliography files, packages, and more.

This repository contains all needed files for writing a manuscript in LaTeX.
It includes the latest versions of the following items:
 * ACS Manuscript Template
 * Bibliography Formatting Guide
 * Gamelin Group References
 * Jouranl Long Names
 * Journal Short Names
 * Li Group References
 * Manuscript Template
 * trkchg package

---------------------------------------------------------------------------------

Bibliographies
--------------

If you use LaTeX, you will eventually need to create a bibliography (.bib) file.
To make bib files portable within the group, some formatting standards have been
implemented for the group.


#### Bibliography Formatting Guide ####

The Bibliography Formatting Guide contains the standard formatting guidelines
for bib files used in the Li group.  Please adhere to these guidelines when
creating your bib files.


#### Li Group Bibliography ####

The Li Group Bibliography file contains references to papers published in the
group from 2005 to the present. It also contains references to Gaussian09 and
several versions of GDV. Use this file when referencing Li group papers. Note
that you can reference multiple bib files in your tex file,
(i.e., `\bibliography{Li_Group_References,MyBibFile,etc.}`).


#### Gamelin Group Bibliography ####

The Gamelin Group Bibliography file contains references to papers published by
Daniel R. Gamelin from 1994 to the present. It also contains references to some
of his graduate students Ph.D. theses. Use this file when referencing Gamelin
group papers. Any papers co-authored by Li and Gamelin are stored in the
Li_Group_References.bib file. Note that you can reference multiple bib files in
your tex file
(i.e., `\bibliography{Li_Group_References,Gamelin_Group_References,MyBibFile,etc.}`).


#### Journal Abbreviations ####

These files are used to convert journal abbreviations in a bib file into the
journal short or long name. Place the contents of one of these files at the top
of your bib file. For more information on the use of journal abbreviations in
your bib files, see the Bibliography Formatting Guide.



Templates
---------

If writing your manuscript in LaTeX, use one of the provided template files.
The first file is for a manuscript to be submitted to an ACS journal and makes
use of the ACS's `achemso` package. For any other journal submission, use the
second template provided. Both templates call the `trkchg` package, which is
included with this repository.



Packages
--------

LaTeX packages developed by the Li group are provided with this repository.
Once you have downloaded and extracted the .zip file, view the `README.txt`
file for installation instructions. The .pdf file included in the folder
contains information about the package and how to use the package.


#### trkchg ####

The trkchg package provides a set of commands for tracking changes in a LaTeX
document. The commands produce easy-to-read markup in the compiled document.
The built-in original and final options allow for quick reversal or acceptance
of the changes made to the document.
