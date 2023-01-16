[G. Pape](http://smarden.org/pape/)\
[runit](index.html)

--------------------------------------------------------------------------------

## [Name]{#sect0}

runsvchdir - change services directory of *runsvdir(8)*

## [Synopsis]{#sect1}

**runsvchdir** *dir*

## [Description]{#sect2}

*dir* is a services directory for the use with ***runsvdir**(8)*. If *dir* does
not start with a slash, it is searched in /etc/runit/runsvdir/. *dir* must not
start with a dot.

**runsvchdir** switches to the directory */etc/runit/runsvdir/*, copies
*current* to *previous*, and replaces *current* with a symlink pointing to
*dir*.

Normally */service* is a symlink to *current*, and ***runsvdir**(8)* is running
*/service/*.

## [Exit Codes]{#sect3}

**runsvchdir** prints an error message and exits 111 on error. **runsvchdir**
exits 0 on success.

## [Files]{#sect4}

/etc/runit/runsvdir/previous\
/etc/runit/runsvdir/current\
/etc/runit/runsvdir/current.new\

## [See Also]{#sect5}

*runsvdir(8)*, *runit(8)*, *runit-init(8)*, *sv(8)*, *runsv(8)*

*http://smarden.org/runit/*

## [Author]{#sect6}

Gerrit Pape \<pape@smarden.org\>

--------------------------------------------------------------------------------

[**Table of Contents**]{#toc}

-   [Name](#sect0){#toc0}
-   [Synopsis](#sect1){#toc1}
-   [Description](#sect2){#toc2}
-   [Exit Codes](#sect3){#toc3}
-   [Files](#sect4){#toc4}
-   [See Also](#sect5){#toc5}
-   [Author](#sect6){#toc6}
