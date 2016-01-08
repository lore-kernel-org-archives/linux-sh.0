From: Rob Landley <rob@landley.net>
Date: Fri, 08 Jan 2016 18:12:56 +0000
Subject: Bootable sh4 qemu images.
Message-Id: <568FFC28.2010409@landley.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The question was recently raised about QEMU images for sh. Since I
maintain those as part of my Aboriginal Linux project, and put out a new
release last night, I thought I'd link to and explain them.

The project page is http://landley.net/aboriginal/about.html

The sh4 images are "qemu-system-sh4.tar.gz", the current release (1.4.4)
is based on musl-libc and kernel 4.2, and the previous release (1.4.3)
was uClibc and 4.1. The stable link to historical prebuilt binary
versions is at:

  http://landley.net/aboriginal/downloads/old/binaries/

Download a system image, extract it, and run either ./run-emulator.sh
(simple initramfs-only, without compiler) or ./dev-environment.sh (with
compiler loaded from /dev/sda squashfs image).

Unfortunately qemu's r2d board can't give me multiple block devices yet
(-hdb and later are ignored) so the 2 gig ext2 image dev-environment.sh
tries to mount on /home is inaccessible, and the native-build.sh script
is useless on this target because there's no /dev/[sh]dc. Also this
board is hardwired to provide 64 megs of ram (gcc requires 256 megs to
build linux from scratch), and when you exit and the kernel tries to
halt the emulator, qemu panics and doesn't reset the TTY properly. (Type
"reset" and hit enter to get your cursor back.)

In the current release's system image tarball is a "mini.config" file
used to build the kernel. You can expand that via:

  make ARCH=sh allnoconfig KCONFIG_ALLCONFIG=mini.config

And then you have a big config from which you can build a kernel. There
are cross-compilers in each release directory, download and extract
cross-compiler-sh4.tar.gz and add its "bin" subdirectory to your path,
and use sh4- as the prefix. (Or you can use the full path to the
compiler ending with the prefix as the prefix, and not fiddle with the
$PATH.)

  make ARCH=sh CROSS_COMPILE=sh4-

(There are also sh2eb images and compilers, sh2 big endian, but the
kernels in those boot on a Numato board, not under qemu. See
http://nommu.org/jcore for details of that. Those are all still uClibc,
they should move to musl next release.)

Again, http://landley.net/aboriginal/about.html should explain or
provide links to everything else.

This is what I've been using to regression test the sh4 kernel for the
past several years. I only got involved in the sh2 nommu stuff at the
end of 2014, and dragged Rich into it what, 6 months ago?

Rob

P.S. Sorry I've fallen a couple kernel versions behind, I'm trying to
catch up but with https://lwn.net/Articles/629362/ and
https://lwn.net/Articles/616315/ and now
http://review.cyanogenmod.org/#/c/119819/1 toybox is dominating my todo
list...
