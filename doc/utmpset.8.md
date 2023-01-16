[G. Pape](http://smarden.org/pape/)\
[runit](index.html)

--------------------------------------------------------------------------------

## [Name]{#sect0}

utmpset - logout a line from utmp and wtmp file

## [Synopsis]{#sect1}

**utmpset** \[ **-w** \] *line*

## [Description]{#sect2}

The **utmpset** program modifies the user accounting database ***utmp**(5)* and
optionally ***wtmp**(5)* to indicate that the user on the terminal *line* has
logged out.

Ordinary ***init**(8)* processes handle utmp file records for local login
accounting. The ***runit**(8)* program doesn't include code to update the utmp
file, the ***getty**(8)* processes are handled the same as all other services.

To enable local login accounting, add **utmpset** to the ***getty**(8)* *finish*
scripts, e.g.:

\$ cat /service/getty-5/finish\
#!/bin/sh\
exec utmpset -w tty5\
\$\

## [Options]{#sect3}

**-w**
:   wtmp. Additionally to the utmp file, write an empty record for *line* to the
    wtmp file.

## [Exit Codes]{#sect4}

**utmpset** returns 111 on error, 1 on wrong usage, 0 in all other cases.

## [See Also]{#sect5}

*sv(8)*, *runsv(8)*, *runit(8)*, *runit-init(8)* *runsvdir(8)*, *runsvchdir(8)*,
*chpst(8)*, *svlogd(8)*, *getty(8)*

*http://smarden.org/runit/*

## [Author]{#sect6}

Gerrit Pape \<pape@smarden.org\>

--------------------------------------------------------------------------------

[**Table of Contents**]{#toc}

-   [Name](#sect0){#toc0}
-   [Synopsis](#sect1){#toc1}
-   [Description](#sect2){#toc2}
-   [Options](#sect3){#toc3}
-   [Exit Codes](#sect4){#toc4}
-   [See Also](#sect5){#toc5}
-   [Author](#sect6){#toc6}
