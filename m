From: Yutaro Ebihara <ebiharaml@si-linux.com>
Date: Mon, 21 Jan 2008 12:22:51 +0000
Subject: debian etch sh3 and sh4
Message-Id: <82C85C285793D5ebiharaml@si-linux.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

hi all.

please let me introduce my archives.
this is debian etch sh3 and sh4
http://www.si-linux.co.jp/pub/debian-sh/

base tar balls.
http://www.si-linux.co.jp/pub/debian-sh/base/etch/


you can use following apt line in your sh-box.

landy2:~# cat /etc/apt/sources.list
deb http://www.si-linux.co.jp/pub/debian-sh etch main contrib non-free
deb-src http://ftp.debian.org/debian/       etch main contrib non-free


you can see the number of packeges here.
http://www.si-linux.co.jp/wiki/silinux/index.php?DebianSH_%A5%D3%A5%EB%A5%C9%A5%DE%A5%B7%A5%F3%BE%D2%B2%F0
(sorry japanese)


all packages are build with gcc-4.1.1.

landy2:~# gcc -v
Using built-in specs.
Target: sh4-linux-gnu
Configured with: ../src/configure -v --enable-languages=c,c++,fortran,
objc,obj-c++,treelang --prefix=/usr --enable-shared --with-system-zlib -
-disable-multilib --libexecdir=/usr/lib --without-included-gettext --
enable-threads=posix --enable-nls --program-suffix=-4.1 --enable-
__cxa_atexit --enable-clocale=gnu --enable-libstdcxx-debug --enable-mpfr 
--enable-checking=release sh4-linux-gnu
Thread model: posix
gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)



