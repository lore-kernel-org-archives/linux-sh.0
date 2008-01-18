From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Fri, 18 Jan 2008 08:19:07 +0000
Subject: Hi all, a question about toolchain
Message-Id: <200801180919.07750.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

I'm still involved into build a c++ toolchain based on gcc-3.4.6 and uClibc.
I see that gcc at stage1 (only c language) in configured with:

/home/fgiovagnini/sh7203-uClinux-1.4/gcc-3.4.6/gcc/configure
 --cache-file=./config.cache --build=i686-pc-linux-gnu
 --host=i686-pc-linux-gnu --target=sh-linux
 --prefix=/home/fgiovagnini/sh7203-uClinux-1.4/build/target --without-headers
 --enable-languages=c --disable-shared --disable-threads
 --with-gcc-version-trigger=/home/fgiovagnini/sh7203-uClinux-1.4/gcc-3.4.6/gc
c/version.c --program-transform-name=s,^,sh-linux-,; 
 --srcdir=/home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc

while at stage2 (building also g++ and libstdc++) gcc is still configured as
 follow: $ /home/fgiovagnini/sh7203-uClinux-1.4/gcc-3.4.6/gcc/configure
 --cache-file=./config.cache --build=i686-pc-linux-gnu
 --host=i686-pc-linux-gnu --target=sh-linux
 --prefix=/home/fgiovagnini/sh7203-uClinux-1.4/build/target
 --with-sysroot=/home/fgiovagnini/sh7203-uClinux-1.4/build/target
 --enable-languages=c,c++ --disable-shared
 --with-gcc-version-trigger=/home/fgiovagnini/sh7203-uClinux-1.4/gcc-3.4.6/gc
c/version.c --program-transform-name=s,^,sh-linux-,; 
 --srcdir=/home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc


and libstdc++ is configured sa follow:
 /home/fgiovagnini/sh7203-uClinux-1.4/gcc-3.4.6/libstdc++-v3/configure
 --cache-file=./config.cache --host=sh-linux --build=i686-pc-linux-gnu
 --enable-multilib --with-cross-host=i686-pc-linux-gnu
 --prefix=/home/fgiovagnini/sh7203-uClinux-1.4/build/target
 --with-sysroot=/home/fgiovagnini/sh7203-uClinux-1.4/build/target
 --enable-languages=c,c++ --disable-shared
 --with-gcc-version-trigger=/home/fgiovagnini/sh7203-uClinux-1.4/gcc-3.4.6/gc
c/version.c --program-transform-name=s,^,sh-linux-,; 
 --srcdir=/home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/libstdc++-v
3 --with-target-subdir=sh-linux

WITHOUT --target option.

and I think is is abnormal.

Where do I have top act to fix such a bug?

Thanks in advance.


-- 
Fabio Giovagnini

Aurion s.r.l.
via degli orti 11,
40050 Funo di Argelato (BO)
P.I e C.F.
00885711200
Tel. +39.335.8350919
Fax +39.051.8659009

www.aurion-tech.com

account telefono VoIP skype (www.skype.com):
aurion.giovagnini
