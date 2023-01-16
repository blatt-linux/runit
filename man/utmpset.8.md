<!-- -*- fill-column: 80 -*- -->

# NAME

`utmpset` - logout a line from utmp and wtmp file

# SYNOPSIS

`utmpset [ -w ] line`

# DESCRIPTION

The `utmpset` program modifies the user accounting database `utmp(5)` and
optionally `wtmp(5)` to indicate that the user on the terminal `line` has logged
out.

Ordinary `init(8)` processes handle utmp file records for local login
accounting. The `runit(8)` program doesn't include code to update the utmp file,
the `getty(8)` processes are handled the same as all other services.

To enable local login accounting, add `utmpset` to the `getty(8)` `finish`
scripts, e.g.:

```
$ cat /service/getty-5/finish
#!/bin/sh
exec utmpset -w tty5
$
```

# OPTIONS

`-w`

:   wtmp. Additionally to the utmp file, write an empty record for `line` to the
    wtmp file.

# EXIT CODES

`utmpset` returns 111 on error, 1 on wrong usage, 0 in all other cases.

# SEE ALSO

`sv(8)`, `runsv(8)`, `runit(8)`, `runit-init(8)` `runsvdir(8)`, `runsvchdir(8)`,
`chpst(8)`, `svlogd(8)`, `getty(8)`

http://smarden.org/runit/

# AUTHOR

Gerrit Pape <pape@smarden.org>
