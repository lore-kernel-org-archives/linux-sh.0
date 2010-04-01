From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 01 Apr 2010 07:37:26 +0000
Subject: objdump on libgcc
Message-Id: <201004010937.26235.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Andrew,
in my crosstool dir I have only one libgcc.a

If on it I do

fgiovagnini@aurio01:~/sh7203/sh7203-uclinux-4.4-143/build/target/lib/gcc/sh-
uclinux/4.4.1$ sh-uclinux-objdump -a libgcc.a | more
In archive libgcc.a:

_ashiftrt.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0   1604 Mar 18 22:26 2010 _ashiftrt.o


_ashiftrt_n.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0    595 Mar 18 22:26 2010 _ashiftrt_n.o


_ashiftlt.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0    603 Mar 18 22:26 2010 _ashiftlt.o


_lshiftrt.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0    603 Mar 18 22:26 2010 _lshiftrt.o


_movmem.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0   1535 Mar 18 22:26 2010 _movmem.o


_movmem_i4.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0    844 Mar 18 22:26 2010 _movmem_i4.o


_mulsi3.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0    524 Mar 18 22:26 2010 _mulsi3.o


_sdivsi3.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0    648 Mar 18 22:26 2010 _sdivsi3.o


_sdivsi3_i4.o:     file format elf32-shbig-fdpic
rw-r--r-- 2012/0    441 Mar 18 22:26 2010 _sdivsi3_i4.o

This is the result,
so I think libgcc is only for fdpic target, so if I need it for building 
kernel (and for making zImage it seems to be essential) I can link only a 
wrong libgcc.

What can I test more?

Cheers


-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
