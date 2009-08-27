From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 27 Aug 2009 13:35:42 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <20090827133542.GA5097@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2009 at 02:28:13PM +0100, Matt Fleming wrote:
> Hey Stuart,
> 
> Your recent patch "sh: Remove implicit sign extension from assembler
> immediates" (fea966f7564205fcf5919af9bde031e753419c96 in Paul's tree)
> causes gas to error out for me. I'm using today's version of the
> binutils assembler, GNU assembler version 2.19.51 (sh4-linux) using BFD
> version (GNU Binutils) 2.19.51.20090827.
> 
> arch/sh/kernel/cpu/sh4/../sh3/entry.S:260: Error: offset out of range
> arch/sh/kernel/cpu/sh4/../sh3/entry.S:260: Error: value of 4294967280 too large for field of 2 bytes at 160
> arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:60: Error: offset out of range
> arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:60: Error: value of 4294967280 too large for field of 2 bytes at 248
> arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:172: Error: offset out of range
> arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:172: Error: value of 4294967280 too large for field of 2 bytes at 516
> arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:320: Error: offset out of range
> arch/sh/kernel/cpu/sh4/../sh3/../../entry-common.S:320: Error: value of 4294967280 too large for field of 2 bytes at 820
> make[3]: *** [arch/sh/kernel/cpu/sh4/../sh3/entry.o] Error 1
> make[2]: *** [arch/sh/kernel/cpu/sh4] Error 2
> make[1]: *** [arch/sh/kernel/cpu] Error 2
> make: *** [arch/sh/kernel] Error 2
> 
> I can't really understand the motivation for the change, specifically
> the changelog for the patch states that the assembler was getting the
> sign extension wrong in one case, but I can't see where. All the uses of
> the "mov" and "and" instructions look sane to me. Could you explain the
> issues you were seeing in a bit more detail, please?
> 
> I could be missing something blatantly obvious, however ;-)

Incidentally, this produces the proper results with the version of
binutils I am using, so it seems there are two separate issues, and that
the sign extension issue in question is likely already fixed by more
recent binutils versions.

It looks like we will have to version it and bury the sign extension in a
macro to deal with the different binutils versions. Your version of
binutils looks like it is doing the right thing, but I am concerned about
the other versions that require the explicit sign extension.
