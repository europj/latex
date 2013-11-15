ENTRY
  { 
    address
    author
    booktitle
    edition
    editor
    journal
    pages
    publisher
    title
    volume
    year
  }
  {}
  { label }
INTEGERS { output.state before.all mid.sentence after.sentence after.block }
FUNCTION {init.state.consts}
{ #0 'before.all :=
  #1 'mid.sentence :=
  #2 'after.sentence :=
  #3 'after.block :=
}
STRINGS { s t}
FUNCTION {output.nonnull}
{ 's :=
  output.state mid.sentence =
    { ", " * write$ }
    { output.state after.block = 
        { add.period$ write$
          newline$
          "\newblock " write$
        }
        { output.state before.all =
            'write$
            { add.period$ " " * write$ }
          if$
        }
      if$
      mid.sentence 'output.state :=
    }
  if$
  s
}
FUNCTION {output.nonnull.nostate}
{ 's :=
  output.state after.block =
    { add.period$ write$
      newline$
      "\newblock " write$
    }
    'write$
  if$
  s
}
FUNCTION {output}
{ duplicate$ empty$
    'pop$
    'output.nonnull
  if$
}
FUNCTION {output.check}
{ 't :=
  duplicate$ empty$
    { pop$ "empty " t * " in " * cite$ * warning$ }
    'output.nonnull
  if$
}
INTEGERS { nameptr namesleft numnames posothers showetal}

FUNCTION {output.bibitem}
{ newline$
  "\bibitem{" write$
  cite$ write$
  "}" write$
  newline$
  ""
  before.all 'output.state :=
}
FUNCTION {bibinfo.check}
{ swap$
  duplicate$ missing$
    {
      pop$ pop$
      ""
    }
    { duplicate$ empty$
        {
           swap$ pop$
        }
        { swap$
          pop$
        }
      if$
    }
  if$
}
FUNCTION {fin.entry}
{ add.period$
  write$
  newline$
}
FUNCTION {new.block}
{ output.state before.all =
    'skip$
    { after.block 'output.state := }
  if$
}
FUNCTION {new.sentence}
{ output.state after.block =
    'skip$
    { output.state before.all =
        'skip$
        { after.sentence 'output.state := }
      if$
    }
  if$
}
FUNCTION {add.blank}
{  " " * before.all 'output.state :=
}
FUNCTION {add.colon}
{ duplicate$ empty$
    'skip$
    { ":" * add.blank }
  if$
}
FUNCTION {not}
{   { #0 }
    { #1 }
  if$
}
FUNCTION {and}
{   'skip$
    { pop$ #0 }
  if$
}
FUNCTION {or}
{   { pop$ #1 }
    'skip$
  if$
}
FUNCTION {field.or.null}
{ duplicate$ empty$
    { pop$ "" }
    'skip$
  if$
}
FUNCTION {bolden}
{ duplicate$ empty$
    { pop$ "" }
    { "\textbf{" swap$ * "}" * }
  if$
}
FUNCTION {italize}
{ duplicate$ empty$
    { pop$ "" }
    { "\textit{" swap$ * "}" * }
  if$
}
FUNCTION {scaps}
{ duplicate$ empty$
    { pop$ "" }
    { "\textsc{" swap$ * "}" * }
  if$
}
FUNCTION {anglequote}
{ duplicate$ empty$
    { pop$ "" }
    { "<<" swap$ * ">>" * }
  if$
}
FUNCTION {singlequote}
{ duplicate$ empty$
    { pop$ "" }
    { "'{}" swap$ * "'{}" * }
  if$
}
FUNCTION {doublequote}
{ duplicate$ empty$
    { pop$ "" }
    { "``{}" swap$ * "''{}" * }
  if$
}
FUNCTION {n.dashify}
{ 't :=
  ""
    { t empty$ not }
    { t #1 #1 substring$ "-" =
        { t #1 #2 substring$ "--" = not
            { "--" *
              t #2 global.max$ substring$ 't :=
            }
            {   { t #1 #1 substring$ "-" = }
                { "-" *
                  t #2 global.max$ substring$ 't :=
                }
              while$
            }
          if$
        }
        { t #1 #1 substring$ *
          t #2 global.max$ substring$ 't :=
        }
      if$
    }
  while$
}
FUNCTION {format.names.author}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "{f. }{vv}{ll}{jj}" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #30 >
    { #30 'numnames :=
      #1 'showetal :=
    }
    { numnames #30 =
        { posothers #0 >
          { #1 'showetal :=
            #30 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{f. }{vv}{ll}{jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { showetal #0 >
                { ", " * t * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$

  showetal #0 >
    { " et~al." * }
    'skip$
  if$
}

FUNCTION {format.names.editor}
{
  's :=

  #1 'nameptr :=
  s num.names$ 'numnames :=

  numnames 'namesleft :=
  #0 'posothers :=
    { namesleft #0 > }
    { s nameptr "{f. }{vv}{ll}{jj}" format.name$ 't :=
      t "others" =
         { nameptr 'posothers := }
         'skip$
       if$
       nameptr #1 + 'nameptr :=
       namesleft #1 - 'namesleft :=
    }
  while$

  #0 'showetal :=

  numnames #30 >
    { #30 'numnames :=
      #1 'showetal :=
    }
    { numnames #30 =
        { posothers #0 >
          { #1 'showetal :=
            #30 'numnames :=
          }
          'skip$
         if$
         }
         { posothers #0 >
             { #1 'showetal :=
               #1 'numnames -
             }
             'skip$
           if$
         }
       if$
    }
  if$

  #1 'nameptr :=
  numnames 'namesleft :=
    { namesleft #0 > }
    { s nameptr "{f. }{vv}{ll}{jj}" format.name$ 't :=
      nameptr #1 >
        { namesleft #1 >
            { ", " * t * }
            { showetal #0 >
                { ", " * t * }
                { " and " * t * }
              if$
            }
          if$
        }
        't
      if$
      nameptr #1 + 'nameptr :=
      namesleft #1 - 'namesleft :=
    }
  while$

  showetal #0 >
    { " et~al." * }
    'skip$
  if$
}

FUNCTION {sortify}
{ purify$
  "l" change.case$
}

INTEGERS { len }


FUNCTION {chop.word}
{ 's :=
  'len :=
  s #1 len substring$ =
    { s len #1 + global.max$ substring$ }
    's
  if$
}

FUNCTION {format.title.short}
{ 't :=
  "A " #2
    "An " #3
      "The " #4 t chop.word
    chop.word
  chop.word
  #1 #3 substring$
}
FUNCTION {format.inbook.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inbook.booktitle}
{ booktitle
  "booktitle" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.inbook.edition}
{ edition
  "edition" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inbook.editor}
{ editor
  duplicate$ empty$ 'skip$
    { format.names.editor }
  if$
  "editor" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inbook.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inbook.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inbook.pages}
{ pages n.dashify
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {inbook}
{ output.bibitem
  author empty$
  'skip$
    {         format.inbook.author
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  booktitle empty$
  'skip$
    {  "In "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.inbook.booktitle
       output.nonnull.nostate
       "; "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  edition empty$
  'skip$
    {         format.inbook.edition
       output.nonnull.nostate
       "; "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  editor empty$
  'skip$
    {         format.inbook.editor
       output.nonnull.nostate
       " Ed.; "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.inbook.publisher
       output.nonnull.nostate
       ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.inbook.year
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  pages empty$
  'skip$
    {         format.inbook.pages
       output.nonnull.nostate
       "."
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.article.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.article.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     doublequote
   }
  if$
}
FUNCTION {format.article.journal}
{ journal
  "journal" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.article.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     bolden
   }
  if$
}
FUNCTION {format.article.volume}
{ volume
  "volume" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.article.pages}
{ pages n.dashify
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {article}
{ output.bibitem
  author empty$
  'skip$
    {         format.article.author
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.article.title
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  journal empty$
  'skip$
    {         format.article.journal
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.article.year
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  volume empty$
  'skip$
    {         format.article.volume
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  pages empty$
  'skip$
    {         format.article.pages
       output.nonnull.nostate
       "."
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.book.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.booktitle}
{ booktitle
  "booktitle" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.book.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.book.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {book}
{ output.bibitem
  author empty$
  'skip$
    {         format.book.author
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  booktitle empty$
  'skip$
    {         format.book.booktitle
       output.nonnull.nostate
       "; "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.book.publisher
       output.nonnull.nostate
       ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {         format.book.address
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.book.year
       output.nonnull.nostate
       "."
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
FUNCTION {format.inproceedings.author}
{ author
  duplicate$ empty$ 'skip$
    { format.names.author }
  if$
  "author" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inproceedings.title}
{ title
  "title" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     doublequote
   }
  if$
}
FUNCTION {format.inproceedings.booktitle}
{ booktitle
  "booktitle" bibinfo.check
  duplicate$ empty$ 'skip$
   {
     italize
   }
  if$
}
FUNCTION {format.inproceedings.editor}
{ editor
  duplicate$ empty$ 'skip$
    { format.names.editor }
  if$
  "editor" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inproceedings.publisher}
{ publisher
  "publisher" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inproceedings.address}
{ address
  "address" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inproceedings.year}
{ year
  "year" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {format.inproceedings.pages}
{ pages n.dashify
  "pages" bibinfo.check
  duplicate$ empty$ 'skip$
   {
   }
  if$
}
FUNCTION {inproceedings}
{ output.bibitem
  author empty$
  'skip$
    {         format.inproceedings.author
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  title empty$
  'skip$
    {         format.inproceedings.title
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  booktitle empty$
  'skip$
    {  "In "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.inproceedings.booktitle
       output.nonnull.nostate
       "; "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  editor empty$
  'skip$
    {         format.inproceedings.editor
       output.nonnull.nostate
       " Ed.; "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  publisher empty$
  'skip$
    {         format.inproceedings.publisher
       output.nonnull.nostate
       ": "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  address empty$
  'skip$
    {         format.inproceedings.address
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  year empty$
  'skip$
    {         format.inproceedings.year
       output.nonnull.nostate
       ", "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  pages empty$
  'skip$
    {  "pp. "
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate       format.inproceedings.pages
       output.nonnull.nostate
       "."
  duplicate$ empty$ 'skip$
   {
   }
  if$
output.nonnull.nostate    }
  if$
  new.block
  fin.entry
}
READ

STRINGS { longest.label }

INTEGERS { number.label longest.label.width }

FUNCTION {initialize.longest.label}
{ "" 'longest.label :=
  #1 'number.label :=
  #0 'longest.label.width :=
}

FUNCTION {longest.label.pass}
{ number.label int.to.str$ 'label :=
  number.label #1 + 'number.label :=
  label width$ longest.label.width >
    { label 'longest.label :=
      label width$ 'longest.label.width :=
    }
    'skip$
  if$
}

EXECUTE {initialize.longest.label}

ITERATE {longest.label.pass}

FUNCTION {begin.bib}
{ preamble$ empty$
    'skip$
    { preamble$ write$ newline$ }
  if$
  "\begin{thebibliography}{"  longest.label  * "}" * write$ newline$
}

EXECUTE {begin.bib}

EXECUTE {init.state.consts}

ITERATE {call.type$}

FUNCTION {end.bib}
{ newline$
  "\end{thebibliography}" write$ newline$
}

EXECUTE {end.bib}
