[G. Pape](http://smarden.org/pape/)\
[runit](index.html)

--------------------------------------------------------------------------------

## [Name]{#sect0}

runit - a UNIX process no 1

## [Synopsis]{#sect1}

**runit**

## [Description]{#sect2}

**runit** must be run as Unix process no 1. It performs the system's booting,
running, and shutdown in three stages:

## [Stage 1]{#sect3}

**runit** runs */etc/runit/1* and waits for it to terminate. The system's one
time tasks are done here. */etc/runit/1* has full control of */dev/console* to
be able to start an emergency shell if the one time initialization tasks fail.
If */etc/runit/1* crashes, or exits 100, **runit** will skip stage 2 and enter
stage 3.

## [Stage 2]{#sect4}

**runit** runs */etc/runit/2*, which should not return until system shutdown; if
it crashes, or exits 111, it will be restarted. Normally */etc/runit/2* starts
***runsvdir**(8)*. **runit** is able to handle the ctrl-alt-del keyboard request
in stage 2, see below.

## [Stage 3]{#sect5}

If **runit** is told to shutdown the system, or stage 2 returns, it terminates
stage 2 if it is running, and runs */etc/runit/3*. The systems tasks to shutdown
and possibly halt or reboot the system are done here. If stage 3 returns,
**runit** checks if the file */etc/runit/reboot* exists and has the execute by
owner permission set. If so, the system is rebooted, it's halted otherwise.

## [Ctrl-alt-del]{#sect6}

If **runit** receives the ctrl-alt-del keyboard request and the file
*/etc/runit/ctrlaltdel* exists and has the execute by owner permission set,
**runit** runs */etc/runit/ctrlaltdel*, waits for it to terminate, and then
sends itself a CONT signal.

## [Signals]{#sect7}

**runit** only accepts signals in stage 2.

If **runit** receives a CONT signal and the file */etc/runit/stopit* exists and
has the execute by owner permission set, **runit** is told to shutdown the
system.

if **runit** receives an INT signal, a ctrl-alt-del keyboard request is
triggered.

## [See Also]{#sect8}

*runit-init(8)*, *runsvdir(8)*, *runsvchdir(8)*, *sv(8)*, *runsv(8)*,
*chpst(8)*, *utmpset(8)*, *svlogd(8)*

*http://smarden.org/runit/*

## [Author]{#sect9}

Gerrit Pape \<pape@smarden.org\>

--------------------------------------------------------------------------------

[**Table of Contents**]{#toc}

-   [Name](#sect0){#toc0}
-   [Synopsis](#sect1){#toc1}
-   [Description](#sect2){#toc2}
-   [Stage 1](#sect3){#toc3}
-   [Stage 2](#sect4){#toc4}
-   [Stage 3](#sect5){#toc5}
-   [Ctrl-alt-del](#sect6){#toc6}
-   [Signals](#sect7){#toc7}
-   [See Also](#sect8){#toc8}
-   [Author](#sect9){#toc9}
