From: Fabio Giovagnini <fabio.giovagnini@aurion-tech.com>
Date: Thu, 01 Apr 2010 12:42:41 +0000
Subject: Re: [uClinux-dev] Re: objdump on libgcc, again
Message-Id: <201004011442.42027.fabio.giovagnini@aurion-tech.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

in sh-2.6/arch/sh/boot/compressed/Makefile
there is
LIBGCC	:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)

Why this makefile sets LBGCC if it is not required?

Regards

Cheers


In data giovedì 01 aprile 2010 14:39:05, Fabio Giovagnini ha scritto:
: > OK. I understand, but why there is:
>   sh-uclinux-ld  -EB   --oformat elf32-shbig-linux -Ttext 0x0c800000 -e
> startup -T arch/sh/boot/compressed/../../kernel/vmlinux.lds
> arch/sh/boot/compressed/head_32.o arch/sh/boot/compressed/misc.o
> arch/sh/boot/compressed/cache.o arch/sh/boot/compressed/piggy.o
> /home/fgiovagnini/sh7203/sh7203-
> uclinux-4.4-143/build/target/bin/../lib/gcc/sh-uclinux/4.4.1/libgcc.a -o
> arch/sh/boot/compressed/vmlinux
> 
> 
> This is  the problem.
> 
> In data giovedì 01 aprile 2010 09:59:11, Andrew Stubbs ha scritto:
> : > On 01/04/10 08:37, Fabio Giovagnini wrote:
> : >
> > > This is the result,
> > > so I think libgcc is only for fdpic target, so if I need it for
> > > building kernel (and for making zImage it seems to be essential) I can
> > > link only a wrong libgcc.
> >
> > Absolutely, there is only FDPIC libgcc in the release I sent to you.
> >
> > The kernel has not needed glibc for a while now. The relevant routines
> > were copied/rewritten to arch/sh/lib.
> >
> > I expect that all the routines you need are present, so it should just
> > be makefile adjustments. If it does need something extra (that somehow
> > the whole of the rest of the kernel can do without) then I expect it can
> > be extracted from the compiler sources (gcc/config/sh/lib1funcs.asm).
> > The linker should have already told you this list of routines it needs.
> >
> > Andrew
> 

-- 
Fabio Giovagnini

Aurion s.r.l.
P.I e C.F.
00885711200
Tel. +39.051.594.78.24
Cell. +39.335.83.50.919
