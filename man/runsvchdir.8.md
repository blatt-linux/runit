<!-- -*- fill-column: 80 -*- -->

# NAME

`runsvchdir` - change services directory of runsvdir(8)

# SYNOPSIS

`runsvchdir dir`

# DESCRIPTION

`dir` is a services directory for the use with `runsvdir(8)`. If `dir` does not
start with a slash, it is searched in /etc/runit/runsvdir/.  `dir` must not
start with a dot.

`runsvchdir` switches to the directory `/etc/runit/runsvdir/`, copies `current`
to `previous`, and replaces `current` with a symlink pointing to `dir`.

Normally `/var/service` is a symlink to `current`, and `runsvdir(8)` is running
`/var/service/`.

# EXIT CODES

`runsvchdir` prints an error message and exits 111 on error.  `runsvchdir` exits
0 on success.

# FILES

`/etc/runit/runsvdir/previous` `/etc/runit/runsvdir/current`
`/etc/runit/runsvdir/current.new`

# SEE ALSO

`runsvdir(8)`, `runit(8)`, `runit-init(8)`, `sv(8)`, `runsv(8)`

http://smarden.org/runit/

# AUTHOR

Gerrit Pape <pape@smarden.org>
