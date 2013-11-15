--------------------------------------------------------------------------------
trkchg --- Track changes document editing
Copyright (C) 2013 by J.W. May -- Li Research Group -- University of Washington
E-mail: jwmay@uw.edu
Released under the LaTeX Project Public License v1.2 or later
See http://www.latex-project.org/lppl.txt
--------------------------------------------------------------------------------

The trkchg package provides a set of commands for marking up a LaTeX document.
These track changes commands result in a compiled document that highlights the
insertions, deletions, and changes made to the document.  The trkchg package
also provides a set of commands for adding easy-to-read comments in the
compiled document.  Package options allow for easy restoration of the origianl
document or for the final document, accepting all changes, to be compiled.

----------------------------------------
INSTALLATION
----------------------------------------

Quick Installation
------------------
The package is supplied in dtx format and as a pre-extracted .sty file.  The
later is most convenient for most users: simply move this file to your local
texmf directory and run texhash to update the database of file locations.

For MacTeX:

  1. Move the trkchg directory (containing the file trkchg.sty) to

       /usr/local/texlive/YEAR/texmf-dist/tex/latex/

     where YEAR corresponds to the year your LaTeX distribution was released.

     Note: if you are moving this directory in Finder, the usr folder may be
     hidden.  Press command+shift+. to show hidden files/folders.
  
  2. Since you are creating a directory as root, you will be prompted for your
     root password.
  
  3. Open terminal and execute the following command: sudo /usr/texbin/texhash
  
  4. You will again be asked for your root password.


Compiling the Code
------------------
If you want to unpack the dtx yourself:

  1. Run 'latex trkchg.ins' to extract the trkchg.sty file 

  2. Run 'latex trkchg.dtx' to typeset the documentation

  3. To fully typeset the documentation (create table of contents, change
     history, and index), you will need to run

       'makeindex -s gglo.ist -o trkchg.gls trkchg.glo'

     for the change history

  4. Then run

       'makeindex -s gind.ist -o trkchg.ind trkchg.idx'

     for the index

  5. And finally, run 'latex trkchg.dtx' twice more to compile the document with
     the change history and index, and to update the table of contents
