From: Rob Landley <rob@landley.net>
Date: Fri, 29 Jan 2010 07:53:59 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <201001290153.59940.rob@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 27 January 2010 01:55:42 Paul Mundt wrote:
> On Wed, Jan 27, 2010 at 01:29:36AM -0600, Rob Landley wrote:
> > On Monday 25 January 2010 21:22:08 you wrote:
> > > On Sat, Jan 23, 2010 at 06:16:06AM -0600, Rob Landley wrote:
> > > > I get this error:
> > > >
> > > > arch/sh/kernel/cpu/sh4/../sh3/entry.S: Assembler messages:
> > > > arch/sh/kernel/cpu/sh4/../sh3/entry.S:260: Error: value of
> > > > 00000000fffffff0 too large for field of 2 bytes at 00000000000000a0
> > > > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:60: Error: value
> > > > of 00000000fffffff0 too large for field of 2 bytes at
> > > > 00000000000000c8
> > > > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:172: Error: value
> > > > of 00000000fffffff0 too large for field of 2 bytes at
> > > > 000000000000013e
> > > > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:320: Error: value
> > > > of 00000000fffffff0 too large for field of 2 bytes at
> > > > 00000000000001da make[3]: *** [arch/sh/kernel/cpu/sh4/../sh3/entry.o]
> > > > Error 1
> > >
> > > See the http://www.spinics.net/lists/linux-sh/msg03499.html thread.
> >
> > I'm sorry, what was the resolution?  Changing the compiler means the
> > kernel no longer compiles with any existing gcc release from here
> > forward.  Also, I applied the patch from
> > http://www.spinics.net/lists/linux-sh/msg03505.html to binutils 2.17 (the
> > last gplv2 release), which changed the error to:
>
> At what point in this thread was the compiler even mentioned? The entire
> topic of the thread relates only to gas, kindly refrain from making up
> imaginary problems, thanks.

You're right, the compiler never seems to emit code that triggers this bug, 
you have to hand-write assembly to do it, and intentionally ask the assembler 
to do something it can't do.

> >   AS      arch/sh/kernel/cpu/sh4/../sh3/entry.o
> > arch/sh/kernel/cpu/sh4/../sh3/entry.S: Assembler messages:
> > arch/sh/kernel/cpu/sh4/../sh3/entry.S:261: Error: value of 4294967280 too
> > large for field of 2 bytes at 168
> > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:60: Error: value of
> > 4294967280 too large for field of 2 bytes at 208
> > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:172: Error: value of
> > 4294967280 too large for field of 2 bytes at 326
> > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:320: Error: value of
> > 4294967280 too large for field of 2 bytes at 482
> >
> > Which is complaining in write.c (generic code).  (The patch doesn't seem
> > to adjust val, it just changes the error test...)
>
> It's a bug in gas on 64-bit hosts, which has subsequently been fixed
> upstream:
>
> 	http://sourceware.org/cgi-bin/cvsweb.cgi/src/gas/config/tc-sh.c.diff?r1=1.
>132&r2=1.133&cvsroot=src

The date on that commit is August 29.

So the official position of the maintainer of the Super Hitachi port is that any 
toolchain older than October 16th (the binutils 2.20 release) is too old to 
build the Linux kernel.  (With the corollary that in the 5 years since the PC 
went 64 bit, apparently nobody ever actually tried to build anything for Super 
Hitachi?)

Meanwhile Documentation/Changes still says binutils 2.12, and other 
architectures _never_ work around bugs in older toolchains (*cough* git 
2a4b9c5af8203 *cough*)...

*shrug*  I'm going to go locally revert the "cleanup" patch that asked the 
assembler to do something it can't do.  That fixes it for me.

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds

