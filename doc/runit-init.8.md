[G. Pape](http://smarden.org/pape/)\
[runit](index.html)

--------------------------------------------------------------------------------

## [Name]{#sect0}

init - a UNIX process no 1

## [Synopsis]{#sect1}

**init** \[ 0 \| 6 \]

## [Description]{#sect2}

**runit-init** is the first process the kernel starts. If **runit-init** is
started as process no 1, it runs and replaces itself with ***runit**(8)*.

If **runit-init** is started while the system is up, it must be either called as
**init 0** or **init 6:**

**init 0**
:   tells the Unix process no 1 to shutdown and halt the system. To signal
    ***runit**(8)* the system halt request, **runit-init** removes all
    permissions of the file */etc/runit/reboot* (chmod 0), and sets the execute
    by owner permission of the file */etc/runit/stopit* (chmod 100). Then a CONT
    signal is sent to ***runit**(8)*.

**init 6**
:   tells the Unix process no 1 to shutdown and reboot the system. To signal
    ***runit**(8)* the system reboot request, **runit-init** sets the execute by
    owner permission of the files */etc/runit/reboot* and */etc/runit/stopit*
    (chmod 100). Then a CONT signal is sent to ***runit**(8)*.

## [Exit Codes]{#sect3}

**runit-init** returns 111 on error, 0 in all other cases.

## [See Also]{#sect4}

*runit(8)*, *runsvdir(8)*, *runsvchdir(8)*, *sv(8)*, *runsv(8)*, *chpst(8)*,
*utmpset(8)*, *svlogd(8)*

*http://smarden.org/runit/*

## [Author]{#sect5}

Gerrit Pape \<pape@smarden.org\>

--------------------------------------------------------------------------------

[**Table of Contents**]{#toc}

-   [Name](#sect0){#toc0}
-   [Synopsis](#sect1){#toc1}
-   [Description](#sect2){#toc2}
-   [Exit Codes](#sect3){#toc3}
-   [See Also](#sect4){#toc4}
-   [Author](#sect5){#toc5}
