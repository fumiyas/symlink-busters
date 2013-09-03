Symlink Busters
======================================================================

  * Copyright (c) 2013 SATOH Fumiyasu @ OSS Technology Corp., Japan
  * License: GNU General Public License version 3
  * URL: <https://github.com/fumiyas/symlink-busters>
  * Blog: <http://fumiyas.github.io/>
  * Twitter: <https://twitter.com/satoh_fumiyasu>

What's this?
---------------------------------------------------------------------

This is a `$LD_REPLOAD`-able library and a wrapper script to
block symlink(2) system call running under this library.

How to build
---------------------------------------------------------------------

    $ make
    ...
    $ sudo make install
    ...

Usage
---------------------------------------------------------------------

Run a command with `$LD_PRELOAD`-able library:

    $ export LD_PRELOAD=/usr/local/lib/symlink-filter.so
    $ ln -s /etc/passwd .
    ln: failed to create symbolic link './passwd': Operation not permitted

or:

    $ eval `/usr/local/bin/symlink-filter --sh-init`
    $ ln -s /etc/passwd .
    ln: failed to create symbolic link './passwd': Operation not permitted

Run a command via wrapper script:

    # perl -pi \
      -e \'s#^(subsystem\s+sftp\s+)#$1/usr/local/bin/symlink-filter #i' \
      /etc/ssh/sshd_config \
    ;

References
---------------------------------------------------------------------

  * http://fumiyas.github.io/2013/09/03/no-followsymlinks-is-not-safe.html

TODO
---------------------------------------------------------------------

  * Implement open_wo_symlinks() and creat_wo_symlinks() functions
    by using the following systemcalls and flags:
    * `open`(2) and `openat`(2) + `O_PATH`, `O_NOFOLLOW` flags
    * `fstatat`(2) + `AT_SYMLINK_NOFOLLOW` flag

