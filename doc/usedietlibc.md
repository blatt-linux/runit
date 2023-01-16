[G. Pape](http://smarden.org/pape/)\
[runit](index.html)\

--------------------------------------------------------------------------------

# runit - use dietlibc

--------------------------------------------------------------------------------

To recompile the *runit* programs with the [diet
libc](http://www.fefe.de/dietlibc/), check that you have the recent version of
[dietlibc](http://www.fefe.de/dietlibc/) installed.

Change to the package directory of *runit*

     # cd /package/admin/runit/

Change the conf-cc and conf-ld to use diet

     # echo 'diet -Os gcc -O2 -Wall' >src/conf-cc
     # echo 'diet -Os gcc -s -Os -pipe' >src/conf-ld

Rebuild and install the *runit* programs

     # package/install

--------------------------------------------------------------------------------

[Gerrit Pape \<pape@smarden.org\>](mailto:pape@smarden.org)
