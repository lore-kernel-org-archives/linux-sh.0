From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Mon, 21 Jan 2008 17:50:50 +0000
Subject: Re: Hi, all,
Message-Id: <200801211850.50483.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

You understood properly about what I have been trying to do. Iwas trying to
 link a simple c++ application staticxally using uclibc.

This is the output you are asking for.
If it is not enogh tell me what to add more.

fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build> make c++1stApp
make -f Makefile.c++1stApp
make[1]: Entering directory `/home/fgiovagnini/sh7203-uClinux-1.4/build'
make -e -C /home/fgiovagnini/sh7203-uClinux-1.4/build/../c++1stApp
make[2]: Entering directory `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp'
sh-linux-g++ -m3e -mb -v -DGNU_SOURCE -Wall   -c -o main.o main.cpp
Reading specs from
 /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6/s=
pe
cs Configured with:
 /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/configure
 --prefix=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target --target=3Dsh=
-linux
 --with-sysroot=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target
 --enable-languages=3Dc,c++ --disable-shared Thread model: posix
gcc version 3.4.6
 /home/fgiovagnini/sh7203-uClinux-1.4/build/target/libexec/gcc/sh-linux/3.4=
.6
/cc1plus -quiet -v -D_GNU_SOURCE -DGNU_SOURCE main.cpp -quiet -dumpbase
 main.cpp -m3e -mb -auxbase-strip main.o -Wall -version -o /tmp/ccik376j.s
 ignoring nonexistent directory
 "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/local/include"
 ignoring nonexistent directory
 "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6/=
..
/../../../sh-linux/include" #include "..." search starts here:
#include <...> search starts here:
 /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6/.=
./
../../../include/c++/3.4.6
 /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6/.=
./
../../../include/c++/3.4.6/sh-linux
 /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6/.=
./
../../../include/c++/3.4.6/backward
 /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6/i=
nc
lude /home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/include
End of search list.
GNU C++ version 3.4.6 (sh-linux)
        compiled by GNU C version 4.1.0 (SUSE Linux).
GGC heuristics: --param ggc-min-expand=99 --param ggc-min-heapsize=129238
 /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linux/3.4.6/.=
./
../../../sh-linux/bin/as -big -o main.o /tmp/ccik376j.s sh-linux-g++ -m3e -=
mb
 -Wl,-EB -Wl,-elf2flt=3D-s65536  -o c++1stApp main.o c++1stApp.elf2flt: In
 function `_Unwind_Find_FDE':
/home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-dw2-fde-=
gl
ibc.c:291: undefined reference to `dl_iterate_phdr' collect2: ld returned 1
 exit status
make[2]: *** [c++1stApp] Error 1
make[2]: Leaving directory `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp'
make[1]: *** [build] Error 2
make[1]: Leaving directory `/home/fgiovagnini/sh7203-uClinux-1.4/build'
make: *** [c++1stApp] Error 2

Thanks a lot and best regards

Alle 18:14, luned=C3=AC 21 gennaio 2008, Carmelo AMOROSO ha scritto:
> Fabio Giovagnini wrote:
> > Sorry Carmelo,
> > could you explain me better how you solved the problem?
> > Regards
>
> There is a problem into uClibc when statically linking a C++ application,
> but it's not clear if this is what you are trying to do.... even if the
> output
> is the same as in my case.
> So you should attach the whole command line used to build you app,
> further the verbose output (using -v)
> could be useful.
>
> Carmelo
>
> > Alle 08:46, luned=C3=AC 21 gennaio 2008, Carmelo AMOROSO ha scritto:
> >> Mike Frysinger wrote:
> >>> On Sunday 20 January 2008, Mike Frysinger wrote:
> >>>> On Sunday 20 January 2008, Fabio Giovagnini wrote:
> >>>>> I have such a problem with.
> >>>>> sh-uclibc-g++ 3.4.6
> >>>>>
> >>>>> /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwind-=
dw
> >>>>>2- fd e- glibc.c:291: undefined reference to `dl_iterate_phdr'
> >>>>>
> >>>>> How can I solve.
> >>>>> Any suggestion will be appreciated.
> >>>>
> >>>> a one line error isnt exactly useful ... you didnt say what version =
of
> >>>> uClibc you're using or what you're using for a build system.
> >>>
> >>> and more importantly, what exactly are you doing
> >>> -mike
> >>
> >> Hi Mike,
> >> I think that Fabio is trying to linking statically a C++ application
> >> against uClibc. If so, (Fabio please clarify), the problem is extactly
> >> the same
> >> I posted on uClibc list last week (mmove _dl_iterate_phdr from libdl.a
> >> to libc.a).
> >>
> >> I have a already fixed it for nptl/sh4 branch... I'm just now merging
> >> the patch
> >> for the uClibc branch and post it for a wider review on uClibc.
> >>
> >> I'll put Fabio into the loop.. anyway Fabio should post his full comma=
nd
> >> line
> >> used to build/link his application.
> >>
> >> Cheers,
> >> Carmelo
> >> -
> >> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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

-------------------------------------------------------
