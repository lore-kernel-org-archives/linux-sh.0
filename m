From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Sun, 28 Feb 2010 19:58:01 +0000
Subject: binfmt_misc fails to work on sh4
Message-Id: <4B8ACAC9.5040706@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: qemu-devel@nongnu.org
Cc: SH-Linux <linux-sh@vger.kernel.org>

Hello everyone,

I've tried qemu suing binfmt_misc for sh4, but doesn't work fine. It
spits some really weird errors.

Here are the steps to reproduce:

> ~ # wget http://mirror.switch.ch/ftp/mirror/gentoo/releases/sh/autobuilds/20090404/stage3-sh4-20090404.tar.bz2
> ~ # mkdir chroot
> ~ # tar xjfp stage3-sh4-20090404.tar.bz2 -C chroot/
> ~ # wget http://www.mpfr.org/mpfr-current/mpfr-2.4.2.tar.gz; mv mpfr-2.4.2.tar.gz chroot/root/
> ~ # echo ':sh4:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x2a\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfb\xff\xff\xff:/qemu-sh4:' >/proc/sys/fs/binfmt_misc/register
> ~ # wget http://download.savannah.gnu.org/releases/qemu/qemu-0.12.2.tar.gz
> ~ # tar zxvf qemu-0.12.2.tar.gz 
> ~ # cd qemu-0.12.2
> ~ # ./configure --target-list=sh4-linux-user --static && make
> ~ # cd..
> ~ # cp qemu-0.12.2/sh4-linux-user/qemu-sh4 /
> ~ # cp qemu-0.12.2/sh4-linux-user/qemu-sh4 chroot/
> ~ # chroot chroot/
> 
> / # su -
> ~ # tar zxvf mpfr-2.4.2.tar.gz
> ~ # cd mpfr-2.4.2
> mpfr-2.4.2# ./configure
> (RANDOM ERRORS)
> 
> ./configure
> as_echo: eval: line 1: syntax error: unexpected end of file
> /usr/bin/install -c
> as_echo: eval: line 1: syntax error: unexpected end of file
> yes
> as_echo: eval: line 1: syntax error: unexpected end of file
> /bin/mkdir -p
> as_echo: eval: line 1: syntax error: unexpected end of file
> gawk
> as_echo: eval: line 1: syntax error: unexpected end of file
> ./configure: line 3236: ${ac_cv_prog_make_make
> m_set+set}: bad substitution
> no
> as_echo: eval: line 1: syntax error: unexpected end of file
> yes
> as_echo: eval: line 1: syntax error: unexpected end of file
> config.sub: too many arguments
> Try `config.sub --help' for more information.
> configure: error: /bin/sh ./config.sub sh4-unknown-linux-gnu
> s failed
> ---------------------------------
> ./configure
> configure
> c: error: cannot find install-sh, install.sh, or shtool in ".." "../.." "../../.."
> 
> --------------------------------------
> 
> ./configure
> as_echo: eval: line 1: syntax error: unexpected end of file
> /usr/bin/install -c
> as_echo: eval: line 1: syntax error: unexpected end of file
> configure: error: ls -t appears to fail.  Make sure there is not a broken
> alias in your environment
> configure: error: newly created file is older than distributed files!
> Check your system clock
> 
> 
> 

Happens the same with the Debian userspace that you can download from here:

https://oss.renesas.com/modules/download/index.php?cid6

Any hints?

Thanks
