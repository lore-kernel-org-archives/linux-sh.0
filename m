From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Tue, 22 Jan 2008 07:58:36 +0000
Subject: Re: Hi, all,
Message-Id: <4795A22C.2010106@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Fabio Giovagnini wrote:
> You understood properly about what I have been trying to do. Iwas trying =
to
>  link a simple c++ application staticxally using uclibc.
>
> This is the output you are asking for.
> If it is not enogh tell me what to add more.
>
> fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build> make c++1stApp
> make -f Makefile.c++1stApp
> make[1]: Entering directory `/home/fgiovagnini/sh7203-uClinux-1.4/build'
> make -e -C /home/fgiovagnini/sh7203-uClinux-1.4/build/../c++1stApp
> make[2]: Entering directory `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stA=
pp'
> sh-linux-g++ -m3e -mb -v -DGNU_SOURCE -Wall   -c -o main.o main.cpp
> Reading specs from
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6=
/spe
> cs Configured with:
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/configure
>  --prefix=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target --target=3D=
sh-linux
>  --with-sysroot=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target
>  --enable-languages=3Dc,c++ --disable-shared Thread model: posix
> gcc version 3.4.6
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/target/libexec/gcc/sh-linux/3=
.4.6
> /cc1plus -quiet -v -D_GNU_SOURCE -DGNU_SOURCE main.cpp -quiet -dumpbase
>  main.cpp -m3e -mb -auxbase-strip main.o -Wall -version -o /tmp/ccik376j.s
>  ignoring nonexistent directory
>  "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/local/include"
>  ignoring nonexistent directory
>  "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.=
6/..
> /../../../sh-linux/include" #include "..." search starts here:
> #include <...> search starts here:
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6=
/../
> ../../../include/c++/3.4.6
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6=
/../
> ../../../include/c++/3.4.6/sh-linux
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6=
/../
> ../../../include/c++/3.4.6/backward
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6=
/inc
> lude /home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/include
> End of search list.
> GNU C++ version 3.4.6 (sh-linux)
>         compiled by GNU C version 4.1.0 (SUSE Linux).
> GGC heuristics: --param ggc-min-expand=99 --param ggc-min-heapsize=129238
>  /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6=
/../
> ../../../sh-linux/bin/as -big -o main.o /tmp/ccik376j.s sh-linux-g++ -m3e=
 -mb
>  -Wl,-EB -Wl,-elf2flt=3D-s65536  -o c++1stApp main.o c++1stApp.elf2flt: In
>  function `_Unwind_Find_FDE':
> /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-dw2-fd=
e-gl
> ibc.c:291: undefined reference to `dl_iterate_phdr' collect2: ld returned=
 1
>  exit status
> make[2]: *** [c++1stApp] Error 1
> make[2]: Leaving directory `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stAp=
p'
> make[1]: *** [build] Error 2
> make[1]: Leaving directory `/home/fgiovagnini/sh7203-uClinux-1.4/build'
> make: *** [c++1stApp] Error 2
>
> Thanks a lot and best regards
>  =20
As a work-around, you may try to arrange your makefile to link statically
against libdl.a where actually _dl_iterate_phdr is defined.
The final solution consists of moving the _dl_iterate_phdr from libdl.a=20
to libc.a,
but it needs some other changes. I've already have a working solution=20
for uClibc-nptl
for sh4, but this is still missing from the trunk.
I'm working to merge it to trunk asas. Then you need to use the latest=20
uClibc.

See if the work-around works for you.

Carmelo
