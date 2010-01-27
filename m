From: Rob Landley <rob@landley.net>
Date: Wed, 27 Jan 2010 07:29:36 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <201001270129.37068.rob@landley.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday 25 January 2010 21:22:08 you wrote:
> On Sat, Jan 23, 2010 at 06:16:06AM -0600, Rob Landley wrote:
> > I get this error:
> >
> > arch/sh/kernel/cpu/sh4/../sh3/entry.S: Assembler messages:
> > arch/sh/kernel/cpu/sh4/../sh3/entry.S:260: Error: value of
> > 00000000fffffff0 too large for field of 2 bytes at 00000000000000a0
> > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:60: Error: value of
> > 00000000fffffff0 too large for field of 2 bytes at 00000000000000c8
> > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:172: Error: value of
> > 00000000fffffff0 too large for field of 2 bytes at 000000000000013e
> > arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:320: Error: value of
> > 00000000fffffff0 too large for field of 2 bytes at 00000000000001da
> > make[3]: *** [arch/sh/kernel/cpu/sh4/../sh3/entry.o] Error 1
>
> See the http://www.spinics.net/lists/linux-sh/msg03499.html thread.

I'm sorry, what was the resolution?  Changing the compiler means the kernel no 
longer compiles with any existing gcc release from here forward.  Also, I 
applied the patch from http://www.spinics.net/lists/linux-sh/msg03505.html to 
binutils 2.17 (the last gplv2 release), which changed the error to:

  AS      arch/sh/kernel/cpu/sh4/../sh3/entry.o
arch/sh/kernel/cpu/sh4/../sh3/entry.S: Assembler messages:
arch/sh/kernel/cpu/sh4/../sh3/entry.S:261: Error: value of 4294967280 too 
large for field of 2 bytes at 168
arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:60: Error: value of 
4294967280 too large for field of 2 bytes at 208
arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:172: Error: value of 
4294967280 too large for field of 2 bytes at 326
arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:320: Error: value of 
4294967280 too large for field of 2 bytes at 482

Which is complaining in write.c (generic code).  (The patch doesn't seem to 
adjust val, it just changes the error test...)

Rob
-- 
Latency is more important than throughput. It's that simple. - Linus Torvalds
