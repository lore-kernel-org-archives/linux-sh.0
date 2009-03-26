From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Thu, 26 Mar 2009 18:01:50 +0000
Subject: sh-2.6.git fails to compile with gcc-4.3 (warnings treated as errors)
Message-Id: <49CBC30E.9020901@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

make -f scripts/Makefile.build obj=usr
make -f scripts/Makefile.build obj=arch/sh/kernel
  sh4-unknown-linux-gnu-gcc -Wp,-MD,arch/sh/kernel/.setup.o.d  -nostdinc
-isystem /usr/lib/gcc/sh4-unknown-linux-gnu/4.3.3/include -Iinclude
-I/root/sh-2.6/arch/sh/include -include include/linux/autoconf.h
-D__KERNEL__ -m4 -m4-nofpu -m4a -m4a-nofpu -ml -Wa,-isa=sh4a-up
-ffreestanding -Iarch/sh/include/cpu-sh4 -Iarch/sh/include/cpu-common
-Iarch/sh/include/mach-common -Wall -Wundef -Wstrict-prototypes
-Wno-trigraphs -fno-strict-aliasing -fno-common
-Werror-implicit-function-declaration -Os -pipe -m4 -m4-nofpu -m4a
-m4a-nofpu -ml -Wa,-isa=sh4a-up -ffreestanding -Iarch/sh/include/cpu-sh4
-Iarch/sh/include/cpu-common -Iarch/sh/include/mach-common
-fno-stack-protector -fomit-frame-pointer -Wdeclaration-after-statement
-Wno-pointer-sign -Werror  -D"KBUILD_STR(s)=#s"
-D"KBUILD_BASENAME=KBUILD_STR(setup)"
-D"KBUILD_MODNAME=KBUILD_STR(setup)"  -c -o arch/sh/kernel/setup.o
arch/sh/kernel/setup.c
cc1: warnings being treated as errors
arch/sh/kernel/setup.c: In function 'early_parse_mem':
arch/sh/kernel/setup.c:111: error: format not a string literal and no
format arguments
make[1]: *** [arch/sh/kernel/setup.o] Error 1
make: *** [arch/sh/kernel] Error 2

I just used the default sh7785lcr_defconfig .

Paul said its easy to fix, so feel free to submit a patch.
