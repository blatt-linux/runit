[G. Pape](http://smarden.org/pape/)

--------------------------------------------------------------------------------

# runit - a UNIX init scheme with service supervision

--------------------------------------------------------------------------------

[How to install runit](install.html)\
[Upgrading from previous versions of runit](upgrade.html)

[Benefits](benefits.html)\
[How to replace init](replaceinit.html)\
[How to use runit with current init](useinit.html)\
[How to use dietlibc](usedietlibc.html)\
[Frequently asked questions](faq.html)\

[Runlevels](runlevels.html)\
[Service dependencies](dependencies.html)\
[A collection of run scripts](runscripts.html)\

[The runit program](runit.8.html)\
[The runit-init program](runit-init.8.html)\
\
[The sv program](sv.8.html)\
\
[The runsvdir program](runsvdir.8.html)\
[The runsvchdir program](runsvchdir.8.html)\
[The runsv program](runsv.8.html)\
\
[The svlogd program](svlogd.8.html)\
\
[The chpst program](chpst.8.html)\
[The utmpset program](utmpset.8.html)\

--------------------------------------------------------------------------------

*runit* is a cross-platform Unix init scheme with service supervision, a
replacement for [sysvinit](ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/),
and other init schemes. It runs on **GNU/Linux**, **\*BSD**, **MacOSX**,
**Solaris**, and can easily be adapted to other Unix operating systems. If
*runit* runs for you on any other operating system, please [let me
know](mailto:supervision@list.skarnet.org).

--------------------------------------------------------------------------------

*runit* is discussed on the
[\<supervision@list.skarnet.org\>](http://skarnet.org/lists/#supervision)
mailing list. Please contact this list and not me privately.

To subscribe send an empty email to
[\<supervision-subscribe@list.skarnet.org\>](mailto:supervision-subscribe@list.skarnet.org).

Mailing list archives are available at
[skarnet.org](http://skarnet.org/lists/archive.cgi?2), and
[gmane.org](http://news.gmane.org/gmane.comp.sysutils.supervision.general).

--------------------------------------------------------------------------------

The program [runit](runit.8.html) is intended to run as Unix process no 1, it is
automatically started by the [runit-init](runit-init.8.html)
/sbin/init-replacement if this is started by the kernel.

[runit](runit.8.html) performs the system\'s *booting*, *running* and *shutting
down* in **three stages**:

-   **Stage 1:**\
    *runit* starts /etc/runit/1 and waits for it to terminate. The system\'s one
    time initialization tasks are done here. /etc/runit/1 has full control over
    /dev/console to be able to start an emergency shell in case the one time
    initialization tasks fail.
-   **Stage 2:**\
    *runit* starts /etc/runit/2 which should not return until the system is
    going to halt or reboot; if it crashes, it will be restarted. Normally,
    /etc/runit/2 runs [runsvdir](runsvdir.8.html). In Stage 2 *runit* optionally
    handles the INT signal (ctrl-alt-del keyboard request on Linux/i386).
-   **Stage 3:**\
    If *runit* is told to halt or reboot the system, or Stage 2 returns without
    errors, it terminates Stage 2 if it is running, and runs /etc/runit/3. The
    systems tasks to shutdown and halt or reboot are done here.

These are working examples for Debian sarge: [/etc/runit/1](debian/1),
[/etc/runit/2](debian/2), [/etc/runit/3](debian/3).

The program [runit-init](runit-init.8.html) is intended to replace /sbin/init.
The command **init 0** tells *runit* to halt the system, and **init 6** to
reboot. [Runlevels](runlevels.html) are handled through the
[runsvdir](runsvdir.8.html) and [runsvchdir](runsvchdir.8.html) programs.
Service [dependencies](dependencies.html) are resolved automatically.

*runit* is optimized for reliability and small size. The amount of code in
process no 1 should be minimal.

--------------------------------------------------------------------------------

See [How to install runit](install.html) for installing *runit*, and [How to
replace init](replaceinit.html) for configuring *runit* to run as process no 1.
See [How to use with current init](useinit.html) if you want to use *runit*
without replacing the current init scheme. Please read the list of [Frequently
asked questions with answers](faq.html).

--------------------------------------------------------------------------------

If *runit* on Linux is compiled and linked with the
[dietlibc](http://www.fefe.de/dietlibc/), it yields in a statically linked runit
binary of 8.5k size and this ps axuw output on my system:

     USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
     root         1  0.0  0.0    20   16 ?        S     2002   0:02 runit

I recommend doing this; for instructions, see [How to use
dietlibc](usedietlibc.html).

--------------------------------------------------------------------------------

The following distributions are known to include or package *runit*:

-   [Debian GNU/Linux](http://packages.qa.debian.org/runit) (as alternative init
    scheme)
-   [FreeBSD](http://www.freshports.org/sysutils/runit/)
-   [OpenBSD](http://www.openbsd.org/cgi-bin/cvsweb/ports/sysutils/runit/)
-   [NetBSD](http://pkgsrc.se/wip/runit/)
-   [Ubuntu](http://packages.ubuntu.com/runit) (as alternative init scheme)
-   [Gentoo](http://packages.gentoo.org/package/sys-process/runit)
-   [Linux from Scratch](https://code.google.com/p/runit-for-lfs/)
-   [Finnix](http://www.finnix.org/)
-   [SME server](http://www.smeserver.org/)
-   [Linux-VServer](http://linux-vserver.org/Running_runit-supervised_services_inside_a_vserver)
-   [T2](http://www.t2-project.org/)
-   [GoboLinux](http://www.gobolinux.org/)
-   [Dragora GNU/Linux](http://www.dragora.org/) (as default init scheme)
-   [ArchLinux](https://wiki.archlinux.org/index.php/Runit)
-   [OpenSDE](http://www.opensde.org/)
-   [Zinux Linux](http://zinux.cynicbytrade.com/) (as default init scheme)
-   [deepOfix Mail Server](http://deepofix.org/) (as default init scheme)

If you know of more distributions, please [let me
know](mailto:supervision@list.skarnet.org).

--------------------------------------------------------------------------------

***runit* in use**: I replaced *sysvinit* successfully with *runit* on several
server systems and a laptop running Debian/GNU Linux sarge, woody, and potato.
Here is an example:

     # strings /proc/1/exe |grep Id
     $Id: runit.c,v 1.7 2002/02/13 09:59:52 pape Exp $
     # uptime
      11:59:13 up 365 days, 23:22,  3 users,  load average: 0.01, 0.02, 0.00
     # ps axuw |head -n20
     USER       PID %CPU %MEM   VSZ  RSS TTY      STAT START   TIME COMMAND
     root         1  0.0  0.0    20   16 ?        S     2002   0:07 runit
     root         2  0.0  0.0     0    0 ?        SW    2002   0:00 [keventd]
     root         3  0.0  0.0     0    0 ?        SWN   2002   0:51 [ksoftirqd_CPU0]
     root         4  0.0  0.0     0    0 ?        SW    2002 144:38 [kswapd]
     root         5  0.0  0.0     0    0 ?        SW    2002   0:08 [bdflush]
     root         6  0.0  0.0     0    0 ?        SW    2002   7:24 [kupdated]
     root       168  0.0  0.0  1652  168 ?        S     2002   0:27 /usr/sbin/cron
     root       174  0.0  0.0    36   24 ?        S     2002   1:06 runsvdir /var/service log: ...............................................................................................
     root       176  0.0  0.0    20   20 ?        S     2002   0:00 runsv qmail-send
     root       177  0.0  0.0    20   20 ?        S     2002   0:00 runsv getty-5
     root       178  0.0  0.0    20   20 ?        S     2002   0:00 runsv getty-4
     root       179  0.0  0.0    20   20 ?        S     2002   0:00 runsv getty-3
     root       180  0.0  0.0    20   20 ?        S     2002   0:00 runsv getty-2
     root       182  0.0  0.0    20   20 ?        S     2002   0:00 runsv socklog-unix
     root       183  0.0  0.0  1256    4 tty5     S     2002   0:00 /sbin/getty 38400 tty5 linux
     root       184  0.0  0.0  1256    4 tty3     S     2002   0:00 getty 38400 tty3 linux
     root       185  0.0  0.0    20   20 ?        S     2002   0:00 runsv socklog-klog
     root       186  0.0  0.0    20   20 ?        S     2002   0:00 runsv ssh
     root       187  0.0  0.0  1256    4 tty4     S     2002   0:00 getty 38400 tty4 linux
     # pstree
     runit-+-bdflush
           |-cron
           |-gcache
           |-keventd
           |-ksoftirqd_CPU0
           |-kswapd
           |-kupdated
           `-runsvdir-+-runsv-+-multilog
                      |       `-qmail-send-+-qmail-clean
                      |                    |-qmail-lspawn
                      |                    `-qmail-rspawn---qmail-remote
                      |-4*[runsv---getty]
                      |-2*[runsv-+-multilog]
                      |          `-socklog]
                      |-runsv-+-multilog
                      |       `-sshd-+-sshd---sshd---bash---bash---pstree
                      |              `-sshd---sshd---rsync
                      |-runsv---clockspeed
                      |-runsv-+-dnscache
                      |       `-multilog
                      |-runsv---apache-ssl-+-9*[apache-ssl]
                      |                    |-gcache
                      |                    `-4*[multilog]
                      |-7*[runsv-+-multilog]
                      |          `-tcpserver]
                      |-4*[runsv-+-multilog]
                      |          `-tinydns]
                      |-runsv---uncat
                      |-2*[runsv-+-multilog]
                      |          `-tcpsvd]
                      |-runsv-+-svlogd
                      |       `-tcpsvd-+-smtpfront-qmail
                      |                `-smtpfront-qmail---qmail-queue
                      `-runsv-+-svlogd
                              `-tcpsvd---bincimap-up---bincimapd

--------------------------------------------------------------------------------

See <http://smarden.org/runit/> for recent informations.

--------------------------------------------------------------------------------

Related links:

-   [minit](http://www.fefe.de/minit/) - a small yet feature-complete init
-   [svscan as process 1](http://multivac.cwru.edu/svscan-1/) - by Paul Jarc
-   [sysvinit](ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/) - source code
-   [FreeBSD\'s init](http://www.freebsd.org/cgi/cvsweb.cgi/src/sbin/init/) -
    CVS repository
-   [NetBSD\'s init](http://cvsweb.netbsd.org/bsdweb.cgi/src/sbin/init/) - CVS
    repository
-   [OpenBSD\'s init](http://www.openbsd.org/cgi-bin/cvsweb/src/sbin/init/) -
    CVS repository
-   [Linux Boot Scripts](http://www.atnf.csiro.au/~rgooch/linux/boot-scripts/) -
    by Richard Gooch

--------------------------------------------------------------------------------

[Gerrit Pape \<pape@smarden.org\>](mailto:pape@smarden.org)
