From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Fri, 21 Oct 2016 18:16:31 +0000
Subject: [sh]: glibc file offset problems since 2.24
Message-Id: <53fb3565-53cc-fa22-403f-b7220a5fa4d4@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi!

We have recently run into a rather odd regression with glibc on Debian/sh4.
Starting with glibc 2.24, file offsets are apparently wrong which results
into all weird side effects.

One of these effects is that many applications error out with "File too large",
for example firebird3.0 during build:

sh -x -c "lockfile -1 /<<PKGBUILDDIR>>/gen/Release/firebird/bin/build-db.lock && /<<PKGBUILDDIR>>/gen/Release/firebird/bin/isql -q -i
/<<PKGBUILDDIR>>/src/dbs/metadata.sql; res=\$?; rm -f /<<PKGBUILDDIR>>/gen/Release/firebird/bin/build-db.lock; exit \$res"
+ lockfile -1 /<<PKGBUILDDIR>>/gen/Release/firebird/bin/build-db.lock
ERROR: ld.so: object 'libeatmydata.so' from LD_PRELOAD cannot be preloaded (cannot open shared object file): ignored.
+ /<<PKGBUILDDIR>>/gen/Release/firebird/bin/isql -q -i /<<PKGBUILDDIR>>/src/dbs/metadata.sql
can't format message 17:0 -- message file /usr/lib/sh4-linux-gnu/firebird/3.0/firebird.msg not found
I/O error during "write" operation for file "/<<PKGBUILDDIR>>/gen/metadata.fdb"
-Error while trying to write to file
-File too large
can't format message 17:120 -- message file /usr/lib/sh4-linux-gnu/firebird/3.0/firebird.msg not found
+ res=1
+ rm -f /<<PKGBUILDDIR>>/gen/Release/firebird/bin/build-db.lock
+ exit 1

Or the systemd-journal:

[   13.088000] systemd-journald[524]: Failed to create new system journal: File too large

Another side effect is that mkfs does not work properly anymore since it writes the superblock
at an incorrect offset. With a properly working glibc, the superblock is written at an offset
of 0x400 while with the broken glibc (2.24), the superblock starts at 0x000. As a result,
it's not possible to create a usable filesystem on affected machines:

root@tirpitz:~> mkfs.ext4 /dev/sda2
mke2fs 1.43.3 (04-Sep-2016)
Suggestion: Use Linux kernel >= 3.18 for improved stability of the metadata and journal checksum features.
Creating filesystem with 16252928 4k blocks and 4063232 inodes
Filesystem UUID: 7d9bf1ee-a913-45d0-895b-4032020c1f3b
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424

Allocating group tables: done
Writing inode tables: done
Creating journal (65536 blocks): done
Writing superblocks and filesystem accounting information: done

root@tirpitz:~> blkid /dev/sda2
/dev/sda2: PARTUUID="e6077cf7-02"
root@tirpitz:~> mount /dev/sda2 /srv
mount: wrong fs type, bad option, bad superblock on /dev/sda2,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
root@tirpitz:~>

Does anyone have a clue what could be the issue with glibc?

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
