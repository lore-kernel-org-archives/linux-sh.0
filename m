From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Wed, 23 Jan 2008 23:06:40 +0000
Subject: Re: Hi, all,
Message-Id: <200801240006.41478.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
References: <200801201730.07407.vapier@gentoo.org>
In-Reply-To: <200801201730.07407.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: linux-sh@vger.kernel.org

Definitively I have mate a tar.bz2 with gcc-3.4.6 modified to mak it able t=
o=20
build properly on top of binutils-2.17 (from sh7203-uclinux-1.4 of MPC Data)
and on uClibc-0.9.27-sh2 form same source.

The only problem stiill present is I have to modify the files=20
build/stage/gcc/sh-linux/pic/libiberty/Mikefole to add ac CC line -m4=20
and
The only problem stiill present is I have to modify the files=20
build/stage/gcc/sh-linux/pic/mb/libiberty/Mikefole to add ac CC line -m4

otherwise I get an assembler error.

But for my purpouse the toolchain work; I have benn able to compile a very =

sample application  based on SDL and GUIlib (you can check on libsdl.org.)
GUIlib a a c++ framework for building a graphical application.
The app is 540 kbyte, so also the size is good for me.

I think havign c++ working on such a target is a very usefull think.

Let me know if you like to download the tar.bz2 from my server.
If yes I'll open a tempiorary account and I send you all the necessary info=
s.

Best reagrds






Alle 20:50, mercoled=EC 23 gennaio 2008, Fabio Giovagnini ha scritto:
> Now following the suggetion of Carmelo,  I got a working gcc / g++ - ucli=
bc
> based tool-chian for my sh7203 based board.
> About libiberty compilation I had a lot of problems related to the missing
> of target specifig compiling option (-mb, -m3e, ...) at the moment of cro=
ss
> compiling of the librery.
> I solved the problem manually into the make file, but each time you
> reconfigure the problem appears again obviusly.
> I can compress the tollchain source dir ad put on our fpt server. I' not =
so
> smart doing patches and I think it is better that a guy starter than me
> gives a look at my work before considering it good also for others.
>
> Keiram let me know if you like to download from our server so that a send
> you username and passwrod for a temporary account.
>
> P.S.
> I got on the trget Hello World!!! in c++.
> This give me the capabiliti of developing on target usign alse c++ GUI
> framework based on libSDL.org
>
> Best regards.
>
> Alle 10:34, marted=EC 22 gennaio 2008, Kieran Bingham ha scritto:
> > Hi Fabio,
> >
> > The SH2/SH2a does not have any support for shared librarys yet. I
> > think its something renesas are thinking about but they haven't got to
> > yet.
> >
> > This was a problem we hit while working on the board too.
> >
> > > 3) I looked for ARCH_HAS_NO_LDSO and I found in extra/Configs/Config.=
sh
> > > config CONFIG_SH2
> > >         select ARCH_HAS_NO_MMU
> > >         select ARCH_HAS_NO_LDSO
> > >         bool "SH2"
> > >
> > > so I got the answer to my question.
> > >
> > > Well.
> > > Setting ARCH_HAS_NO_LDSO is needed by my sh27203 target or is a choice
> > > of MCP data for building the minimal sysstem?
> >
> > No, this was not a choice of MPC Data. We didn't change anything in
> > that uClibc source tree.
> >
> > Carmello: What is this `dl_iterate_phdr' - is it something that is
> > part of dynamic linking / shared libraries?
> > --
> > Kieran
> >
> > > Thanks a lot.
> > >
> > > Ciao
> > >
> > > Alle 08:58, marted=EC 22 gennaio 2008, Carmelo AMOROSO ha scritto:
> > > > Fabio Giovagnini wrote:
> > > > > You understood properly about what I have been trying to do. Iwas
> > > > > trying to link a simple c++ application staticxally using uclibc.
> > > > >
> > > > > This is the output you are asking for.
> > > > > If it is not enogh tell me what to add more.
> > > > >
> > > > > fgiovagnini@aurio02:~/sh7203-uClinux-1.4/build> make c++1stApp
> > > > > make -f Makefile.c++1stApp
> > > > > make[1]: Entering directory
> > > > > `/home/fgiovagnini/sh7203-uClinux-1.4/build' make -e -C
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/../c++1stApp make[2]:
> > > > > Entering directory
> > > > > `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp' sh-linux-g++ -m3e
> > > > > -mb -v -DGNU_SOURCE -Wall   -c -o main.o main.cpp Reading specs
> > > > > from
> > > > >
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linu=
x/
> > > > >3. 4.6/ spe cs Configured with:
> > > > >  /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/configure
> > > > >  --prefix=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target
> > > > > --target=3Dsh-linux
> > > > > --with-sysroot=3D/home/fgiovagnini/sh7203-uClinux-1.4/build/target
> > > > > --enable-languages=3Dc,c++ --disable-shared Thread model: posix
> > > > > gcc version 3.4.6
> > > > >
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/libexec/gcc/sh-=
li
> > > > >nu x/3. 4.6 /cc1plus -quiet -v -D_GNU_SOURCE -DGNU_SOURCE main.cpp
> > > > > -quiet -dumpbase main.cpp -m3e -mb -auxbase-strip main.o -Wall
> > > > > -version -o /tmp/ccik376j.s ignoring nonexistent directory
> > > > >
> > > > > "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/local/incl=
ud
> > > > >e" ignoring nonexistent directory
> > > > >
> > > > > "/home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-lin=
ux
> > > > >/3 .4.6 /.. /../../../sh-linux/include" #include "..." search star=
ts
> > > > > here: #include <...> search starts here:
> > > > >
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linu=
x/
> > > > >3. 4.6/ ../ ../../../include/c++/3.4.6
> > > > >
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linu=
x/
> > > > >3. 4.6/ ../ ../../../include/c++/3.4.6/sh-linux
> > > > >
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linu=
x/
> > > > >3. 4.6/ ../ ../../../include/c++/3.4.6/backward
> > > > >
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linu=
x/
> > > > >3. 4.6/ inc lude
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/usr/include End
> > > > > of search list.
> > > > > GNU C++ version 3.4.6 (sh-linux)
> > > > >         compiled by GNU C version 4.1.0 (SUSE Linux).
> > > > > GGC heuristics: --param ggc-min-expand=99 --param
> > > > > ggc-min-heapsize=129238
> > > > >
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/target/lib/gcc/sh-linu=
x/
> > > > >3. 4.6/ ../ ../../../sh-linux/bin/as -big -o main.o /tmp/ccik376j.s
> > > > > sh-linux-g++ -m3e -mb -Wl,-EB -Wl,-elf2flt=3D-s65536  -o c++1stApp
> > > > > main.o
> > > > > c++1stApp.elf2flt: In function `_Unwind_Find_FDE':
> > > > > /home/fgiovagnini/sh7203-uClinux-1.4/build/../gcc-3.4.6/gcc/unwin=
d-
> > > > >dw 2-fd e-gl ibc.c:291: undefined reference to `dl_iterate_phdr'
> > > > > collect2: ld returned 1 exit status
> > > > > make[2]: *** [c++1stApp] Error 1
> > > > > make[2]: Leaving directory
> > > > > `/home/fgiovagnini/sh7203-uClinux-1.4/c++1stApp' make[1]: ***
> > > > > [build] Error 2
> > > > > make[1]: Leaving directory
> > > > > `/home/fgiovagnini/sh7203-uClinux-1.4/build' make: *** [c++1stApp]
> > > > > Error 2
> > > > >
> > > > > Thanks a lot and best regards
> > > >
> > > > As a work-around, you may try to arrange your makefile to link
> > > > statically against libdl.a where actually _dl_iterate_phdr is
> > > > defined. The final solution consists of moving the _dl_iterate_phdr
> > > > from libdl.a to libc.a,
> > > > but it needs some other changes. I've already have a working soluti=
on
> > > > for uClibc-nptl
> > > > for sh4, but this is still missing from the trunk.
> > > > I'm working to merge it to trunk asas. Then you need to use the
> > > > latest uClibc.
> > > >
> > > > See if the work-around works for you.
> > > >
> > > > Carmelo
> > > > -
> > > > To unsubscribe from this list: send the line "unsubscribe linux-sh"
> > > > in the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > > --
> > > Fabio Giovagnini
> > >
> > > Aurion s.r.l.
> > > via degli orti 11,
> > > 40050 Funo di Argelato (BO)
> > > P.I e C.F.
> > > 00885711200
> > > Tel. +39.335.8350919
> > > Fax +39.051.8659009
> > >
> > > www.aurion-tech.com
> > >
> > > account telefono VoIP skype (www.skype.com):
> > > aurion.giovagnini
> > >
> > > aurion.giovagnini
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
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
