From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 02 Apr 2010 07:41:39 +0000
Subject: Re: [uClinux-dev] Re: objdump on libgcc, again
Message-Id: <20100402074139.GB14056@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201004011442.42027.fabio.giovagnini@aurion-tech.com>
In-Reply-To: <201004011442.42027.fabio.giovagnini@aurion-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 01, 2010 at 02:42:41PM +0200, Fabio Giovagnini wrote:
> in sh-2.6/arch/sh/boot/compressed/Makefile
> there is
> LIBGCC	:= $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
> 
> Why this makefile sets LBGCC if it is not required?
> 
Because in to the context of this Makefile it is required.

> In data gioved?? 01 aprile 2010 14:39:05, Fabio Giovagnini ha scritto:
> : > OK. I understand, but why there is:
> >   sh-uclinux-ld  -EB   --oformat elf32-shbig-linux -Ttext 0x0c800000 -e
> > startup -T arch/sh/boot/compressed/../../kernel/vmlinux.lds
> > arch/sh/boot/compressed/head_32.o arch/sh/boot/compressed/misc.o
> > arch/sh/boot/compressed/cache.o arch/sh/boot/compressed/piggy.o
> > /home/fgiovagnini/sh7203/sh7203-
> > uclinux-4.4-143/build/target/bin/../lib/gcc/sh-uclinux/4.4.1/libgcc.a -o
> > arch/sh/boot/compressed/vmlinux
> > 
> > 
> > This is  the problem.
> > 
The parts you conveniently left out were:

sh-uclinux-ld: /opt/tc/renesas-4.4/bin/../lib/gcc/sh-uclinux/4.4.1/libgcc.a(_ashiftlt.o): attempt to mix FDPIC and non-FDPIC objects
sh-uclinux-ld: failed to merge target specific data of file /opt/tc/renesas-4.4/bin/../lib/gcc/sh-uclinux/4.4.1/libgcc.a(_ashiftlt.o)
sh-uclinux-ld: /opt/tc/renesas-4.4/bin/../lib/gcc/sh-uclinux/4.4.1/libgcc.a(_lshiftrt.o): attempt to mix FDPIC and non-FDPIC objects
sh-uclinux-ld: failed to merge target specific data of file /opt/tc/renesas-4.4/bin/../lib/gcc/sh-uclinux/4.4.1/libgcc.a(_lshiftrt.o)

We build the kernel with -mno-fdpic which means that we won't be able to use
the FDPIC libgcc for the zImage loader. Mangling the BFD target isn't going to
help you here either, although of course if there's another BFD that we should
be using while preserving -mno-fdpic semantics for the kernel build then we can
trivially drop that in, too.

It's certainly worth trying to wean the compressed image off of libgcc, but
we're not quite at that point yet.
