[G. Pape](http://smarden.org/pape/)\
[runit](index.html)

--------------------------------------------------------------------------------

## [Name]{#sect0}

runsv - starts and monitors a service and optionally an appendant log service

## [Synopsis]{#sect1}

**runsv** *service*

## [Description]{#sect2}

*service* must be a directory.

**runsv** switches to the directory *service* and starts ./run. If ./run exits
and ./finish exists, **runsv** starts ./finish. If ./finish doesn't exist or
./finish exits, **runsv** restarts ./run.

If ./run or ./finish exit immediately, **runsv** waits a second before starting
./finish or restarting ./run.

Two arguments are given to ./finish. The first one is ./run's exit code, or -1
if ./run didn't exit normally. The second one is the least significant byte of
the exit status as determined by ***waitpid**(2)*; for instance it is 0 if ./run
exited normally, and the signal number if ./run was terminated by a signal. If
**runsv** cannot start ./run for some reason, the exit code is 111 and the
status is 0.

If the file *service*/down exists, **runsv** does not start ./run immediately.
The control interface (see below) can be used to start the service and to give
other commands to **runsv**.

If the directory *service*/log exists, **runsv** creates a pipe, redirects
*service*/run's and *service*/finish's standard output to the pipe, switches to
the directory *service*/log and starts ./run (and ./finish) exactly as described
above for the *service* directory. The standard input of the log service is
redirected to read from the pipe.

**runsv** maintains status information in a binary format (compatible to the
daemontools' **supervise** program) in *service*/supervise/status and
*service*/log/supervise/status, and in a human-readable format in
*service*/supervise/stat, *service*/log/supervise/stat, *service*/supervise/pid,
*service*/log/supervise/pid.

## [Control]{#sect3}

The named pipes *service*/supervise/control, and (optionally)
*service*/log/supervise/control are provided to give commands to **runsv**. You
can use ***sv**(8)* to control the service or just write one of the following
characters to the named pipe:

**u**
:   Up. If the service is not running, start it. If the service stops, restart
    it.

**d**
:   Down. If the service is running, send it a TERM signal, and then a CONT
    signal. If ./run exits, start ./finish if it exists. After it stops, do not
    restart service.

**o**
:   Once. If the service is not running, start it. Do not restart it if it
    stops.

**p**
:   Pause. If the service is running, send it a STOP signal.

**c**
:   Continue. If the service is running, send it a CONT signal.

**h**
:   Hangup. If the service is running, send it a HUP signal.

**a**
:   Alarm. If the service is running, send it a ALRM signal.

**i**
:   Interrupt. If the service is running, send it a INT signal.

**q**
:   Quit. If the service is running, send it a QUIT signal.

**1**
:   User-defined 1. If the service is running, send it a USR1 signal.

**2**
:   User-defined 2. If the service is running, send it a USR2 signal.

**t**
:   Terminate. If the service is running, send it a TERM signal.

**k**
:   Kill. If the service is running, send it a KILL signal.

**x**
:   Exit. If the service is running, send it a TERM signal, and then a CONT
    signal. Do not restart the service. If the service is down, and no log
    service exists, **runsv** exits. If the service is down and a log service
    exists, **runsv** closes the standard input of the log service, and waits
    for it to terminate. If the log service is down, **runsv** exits. This
    command is ignored if it is given to *service*/log/supervise/control.

Example: to send a TERM signal to the socklog-unix service, either do \# sv term
/service/socklog-unix\
or\
\# printf t \>/service/socklog-unix/supervise/control\

***printf**(1)* usually blocks if no **runsv** process is running in the service
directory.

## [Customize Control]{#sect4}

For each control character *c* sent to the control pipe, **runsv** first checks
if *service*/control/*c* exists and is executable. If so, it starts
*service*/control/*c* and waits for it to terminate, before interpreting the
command. If the program exits with return code 0, **runsv** refrains from
sending the service the corresponding signal. The command *o* is always
considered as command *u*. On command *d* first *service*/control/*t* is
checked, and then *service*/control/*d*. On command *x* first
*service*/control/*t* is checked, and then *service*/control/*x*. The control of
the optional log service cannot be customized.

## [Signals]{#sect5}

If **runsv** receives a TERM signal, it acts as if the character x was written
to the control pipe.

## [Exit Codes]{#sect6}

**runsv** exits 111 on an error on startup or if another **runsv** is running in
*service*.

**runsv** exits 0 if it was told to exit.

## [See Also]{#sect7}

*sv(8)*, *chpst(8)*, *svlogd(8)*, *runit(8)*, *runit-init(8)*, *runsvdir(8)*,
*runsvchdir(8)*, *utmpset(8)*

*http://smarden.org/runit/*

## [Author]{#sect8}

Gerrit Pape \<pape@smarden.org\>

--------------------------------------------------------------------------------

[**Table of Contents**]{#toc}

-   [Name](#sect0){#toc0}
-   [Synopsis](#sect1){#toc1}
-   [Description](#sect2){#toc2}
-   [Control](#sect3){#toc3}
-   [Customize Control](#sect4){#toc4}
-   [Signals](#sect5){#toc5}
-   [Exit Codes](#sect6){#toc6}
-   [See Also](#sect7){#toc7}
-   [Author](#sect8){#toc8}
