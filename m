From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Fri, 19 Mar 2010 07:56:30 +0000
Subject: building sh-2.6 git kernel with gcc 4.1.1 Sourgery G++ Lite 4.4-45
Message-Id: <201003190856.31112.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

  sh-linux-gnu-gcc -Wp,-MD,arch/sh/kernel/.hw_breakpoint.o.d  -nostdinc -
isystem /home/fgiovagnini/CodeSourcery/Sourcery_G++_Lite/bin/../lib/gcc/sh-
linux-gnu/4.4.1/include -I/home/fgiovagnini/sh7203/sh7203-uclinux-
arn/sh-2.6/arch/sh/include -Iinclude  -include include/generated/autoconf.h=
 -
D__KERNEL__ -mb -ffreestanding -Iarch/sh/include/cpu-sh2a -
Iarch/sh/include/cpu-sh2 -Iarch/sh/include/cpu-common -Iarch/sh/include/mac=
h-
rsk -Iarch/sh/include/mach-common -Wall -Wundef -Wstrict-prototypes -Wno-
trigraphs -fno-strict-aliasing -fno-common -Werror-implicit-function-
declaration -Wno-format-security -fno-delete-null-pointer-checks -Os -pipe =
-mb=20
-ffreestanding -Iarch/sh/include/cpu-sh2a -Iarch/sh/include/cpu-sh2 -
Iarch/sh/include/cpu-common -Iarch/sh/include/mach-rsk -Iarch/sh/include/ma=
ch-
common -Wframe-larger-than=1024 -fno-stack-protector -fno-omit-frame-pointe=
r -
fno-optimize-sibling-calls -g -Wdeclaration-after-statement -Wno-pointer-si=
gn=20
-fno-strict-overflow -fno-dwarf2-cfi-asm -fconserve-stack -Werror   -
D"KBUILD_STR(s)=3D#s" -D"KBUILD_BASENAME=3DKBUILD_STR(hw_breakpoint)"  -
D"KBUILD_MODNAME=3DKBUILD_STR(hw_breakpoint)"  -c -o=20
arch/sh/kernel/hw_breakpoint.o arch/sh/kernel/hw_breakpoint.c
   sh-linux-gnu-ld  -EB   -r -o arch/sh/kernel/built-in.o=20
arch/sh/kernel/debugtraps.o arch/sh/kernel/dma-nommu.o=20
arch/sh/kernel/dumpstack.o arch/sh/kernel/idle.o arch/sh/kernel/io.o=20
arch/sh/kernel/io_generic.o arch/sh/kernel/irq.o arch/sh/kernel/irq_32.o=20
arch/sh/kernel/machvec.o arch/sh/kernel/nmi_debug.o arch/sh/kernel/process.=
o=20
arch/sh/kernel/process_32.o arch/sh/kernel/ptrace_32.o arch/sh/kernel/reboo=
t.o=20
arch/sh/kernel/return_address.o arch/sh/kernel/setup.o=20
arch/sh/kernel/signal_32.o arch/sh/kernel/sys_sh.o arch/sh/kernel/sys_sh32.=
o=20
arch/sh/kernel/syscalls_32.o arch/sh/kernel/time.o arch/sh/kernel/topology.=
o=20
arch/sh/kernel/traps.o arch/sh/kernel/traps_32.o arch/sh/kernel/unwinder.o =

arch/sh/kernel/cpu/built-in.o arch/sh/kernel/cpufreq.o=20
arch/sh/kernel/sh_ksyms_32.o arch/sh/kernel/module.o=20
arch/sh/kernel/disassemble.o arch/sh/kernel/perf_event.o=20
arch/sh/kernel/perf_callchain.o arch/sh/kernel/hw_breakpoint.o=20
sh-linux-gnu-ld: internal error: merge of architecture 'sh2a' with=20
architecture 'sh4a-nofpu' produced unknown architecture

sh-linux-gnu-ld: arch/sh/kernel/module.o: uses instructions which are=20
incompatible with instructions used in previous modules
sh-linux-gnu-ld: failed to merge target specific data of file=20
arch/sh/kernel/module.o
make[2]: *** [arch/sh/kernel/built-in.o] Errore 1
make[1]: *** [arch/sh/kernel] Errore 2
make[1]: uscita dalla directory =AB/home/fgiovagnini/sh7203/sh7203-uclinux-
arn/sh-2.6=BB




I'm using

fgiovagnini@aurio01:~/sh7203/sh7203-uclinux-arn/build$ ./target/bin/sh-linu=
x-
gnu-gcc -v
Using built-in specs.
Target: sh-linux-gnu
Configured with: /scratch/ams/4.4-sh-linux-gnu-lite/src/gcc-4.4/configure --
build=3Di686-pc-linux-gnu --host=3Di686-pc-linux-gnu --target=3Dsh-linux-gn=
u --
enable-threads --disable-libmudflap --disable-libssp --disable-libstdcxx-pc=
h --
with-cpu=3Dsh4a --with-multilib-list=3Dsh4al,!mb/m4al --with-endian=3Dlittl=
e,big --
enable-extra-sgxxlite-multilibs --enable-incomplete-targets --with-gnu-as --
with-gnu-ld --with-specs=3D'%{O2:%{!fno-remove-local-statics: -fremove-loca=
l-
statics}} %{O*:%{O|O0|O1|O2|Os:;:%{!fno-remove-local-statics: -fremove-loca=
l-
statics}}}' --enable-languages=3Dc,c++ --enable-shared --disable-lto --enab=
le-
symvers=3Dgnu --enable-__cxa_atexit --with-pkgversion=3D'Sourcery G++ Lite =
4.4-45'=20
--with-bugurl=3Dhttps://support.codesourcery.com/GNUToolchain/ --disable-nl=
s --
prefix=3D/opt/codesourcery --with-sysroot=3D/opt/codesourcery/sh-linux-gnu/=
libc --
with-build-sysroot=3D/scratch/ams/4.4-sh-linux-gnu-lite/install/sh-linux-
gnu/libc --with-gmp=3D/scratch/ams/4.4-sh-linux-gnu-lite/obj/host-libs-4.4-=
45-
sh-linux-gnu-i686-pc-linux-gnu/usr --with-mpfr=3D/scratch/ams/4.4-sh-linux-=
gnu-
lite/obj/host-libs-4.4-45-sh-linux-gnu-i686-pc-linux-gnu/usr --with-
ppl=3D/scratch/ams/4.4-sh-linux-gnu-lite/obj/host-libs-4.4-45-sh-linux-gnu-=
i686-
pc-linux-gnu/usr --with-host-libstdcxx=3D'-static-libgcc -Wl,-Bstatic,-lstd=
c++,-
Bdynamic -lm' --with-cloog=3D/scratch/ams/4.4-sh-linux-gnu-lite/obj/host-
libs-4.4-45-sh-linux-gnu-i686-pc-linux-gnu/usr --disable-libgomp --enable-
poison-system-directories --with-build-time-tools=3D/scratch/ams/4.4-sh-lin=
ux-
gnu-lite/install/sh-linux-gnu/bin --with-build-time-tools=3D/scratch/ams/4.=
4-sh-
linux-gnu-lite/install/sh-linux-gnu/bin
Thread model: posix
gcc version 4.4.1 (Sourcery G++ Lite 4.4-45)=20

What cound be my problem?

Thanks

--=20
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
