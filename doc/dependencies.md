[G. Pape](http://smarden.org/pape/)\
[runit](index.html)\

--------------------------------------------------------------------------------

# runit - service dependencies

--------------------------------------------------------------------------------

*runit*\'s service supervision resolves dependencies for service daemons
designed to be run by a supervisor process automatically. The service daemon (or
the corresponding run scripts) should behave as follows:

-   before providing the service, check if all services it depends on are
    available. If not, exit with an error, the supervisor will then try again.
-   write all logs through *runit*\'s logging facility. The
    [runsv](runsv.8.html) program takes care that all logs for the service are
    written safely to disk. Therefore there\'s no need to depend on a system
    logging service.
-   optionally when the service is told to become down, take down other services
    that depend on this one after disabling the service.

If you want to run service daemons that do not support service supervision as
described above, please refer to [this
page](http://smarden.org/pape/djb/daemontools/noinit.html) about service
dependencies I wrote some time ago.

--------------------------------------------------------------------------------

[Gerrit Pape \<pape@smarden.org\>](mailto:pape@smarden.org)
