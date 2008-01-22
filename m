From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Tue, 22 Jan 2008 09:16:31 +0000
Subject: Fwd: Re: Hi, all,
Message-Id: <200801221016.31906.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

This is the list of the step I did.
1) I rebuild uclibc 0.9.27-sh2 (as MPC data gave me into the cd rom)
 including support for dinamic linking. The build was successfull but no
 libdl.a I found into the tree. 2) I searched UCLIBC_LDSO and I found in
 extra/Configs/Config.in

config BUILD_UCLIBC_LDSO
	bool "Compile native shared library loader"
	depends on HAVE_SHARED && !ARCH_HAS_NO_LDSO
	default y
	help
	  uClibc has a native shared library loader for some architectures.
	  If you answer Y here, the uClibc native shared library loader will
	  be built for your target architecture.  If this option is available,
	  to you, then you almost certainly want to answer Y.

3) I looked for ARCH_HAS_NO_LDSO and I found in extra/Configs/Config.sh
config CONFIG_SH2
	select ARCH_HAS_NO_MMU
	select ARCH_HAS_NO_LDSO
	bool "SH2"

so I got the answer to my question.

Well.
Setting ARCH_HAS_NO_LDSO is needed by my sh27203 target or is a choice of M=
CP
 data for building the minimal sysstem?

Thanks a lot.

Ciao

Alle 08:58, marted=C3=AC 22 gennaio 2008, Carmelo AMOROSO ha scritto:
> Fabio Giovagnini wrote:
> > You understood properly about what I have been trying to do. Iwas trying
> > to link a simple c++ application staticxally using uclibc.
> >
> > This is the output you are asking for.
> > If it is not enogh tell me what to add more.
> >
> > fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build> make c++1stApp
> > make -f Makefile.c++1stApp
> > make[1]: Entering directory `/home/fgiovagnini/sh7203-uClinux-1.4/build'
> > make -e -C /home/fgiovagnini/sh7203-uClinux-1.4/build/../c++1stApp
> > make[2]: Entering directory
> > `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp' sh-linux-g++ -m3e -mb =
-v
> > -DGNU_SOURCE -Wall   -c -o main.o main.cpp Reading specs from
> >
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.=
6/
> >spe cs Configured with:
> >  /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/configure
> >  --prefix=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target
> > --target=3Dsh-linux
> > --with-sysroot=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target
> > --enable-languages=3Dc,c++ --disable-shared Thread model: posix
> > gcc version 3.4.6
> >
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/libexec/gcc/sh-linux/=
3.
> >4.6 /cc1plus -quiet -v -D_GNU_SOURCE -DGNU_SOURCE main.cpp -quiet
> > -dumpbase main.cpp -m3e -mb -auxbase-strip main.o -Wall -version -o
> > /tmp/ccik376j.s ignoring nonexistent directory
> >  "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/local/include"
> >  ignoring nonexistent directory
> >
> > "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4=
.6
> >/.. /../../../sh-linux/include" #include "..." search starts here:
> > #include <...> search starts here:
> >
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.=
6/
> >../ ../../../include/c++/3.4.6
> >
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.=
6/
> >../ ../../../include/c++/3.4.6/sh-linux
> >
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.=
6/
> >../ ../../../include/c++/3.4.6/backward
> >
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.=
6/
> >inc lude /home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/include E=
nd
> > of search list.
> > GNU C++ version 3.4.6 (sh-linux)
> >         compiled by GNU C version 4.1.0 (SUSE Linux).
> > GGC heuristics: --param ggc-min-expand=99 --param ggc-min-heapsize=1292=
38
> >
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.=
6/
> >../ ../../../sh-linux/bin/as -big -o main.o /tmp/ccik376j.s sh-linux-g++
> > -m3e -mb -Wl,-EB -Wl,-elf2flt=3D-s65536  -o c++1stApp main.o
> > c++1stApp.elf2flt: In function `_Unwind_Find_FDE':
> > /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-dw2-=
fd
> >e-gl ibc.c:291: undefined reference to `dl_iterate_phdr' collect2: ld
> > returned 1 exit status
> > make[2]: *** [c++1stApp] Error 1
> > make[2]: Leaving directory
> > `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp' make[1]: *** [build]
> > Error 2
> > make[1]: Leaving directory `/home/fgiovagnini/sh7203-uClinux-1.4/build'
> > make: *** [c++1stApp] Error 2
> >
> > Thanks a lot and best regards
>
> As a work-around, you may try to arrange your makefile to link statically
> against libdl.a where actually _dl_iterate_phdr is defined.
> The final solution consists of moving the _dl_iterate_phdr from libdl.a
> to libc.a,
> but it needs some other changes. I've already have a working solution
> for uClibc-nptl
> for sh4, but this is still missing from the trunk.
> I'm working to merge it to trunk asas. Then you need to use the latest
> uClibc.
>
> See if the work-around works for you.
>
> Carmelo
> -
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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

aurion.giovagnini
