From: Stuart MENEFY <stuart.menefy@st.com>
Date: Thu, 27 Aug 2009 14:39:36 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <4A969AA8.9020302@st.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Matt

Matt Fleming wrote:
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

Strange, this works OK for me although I'm using a slightly older
as (2.18.50.0.8.20090602). However I did see this error with gas
built on x86-64 - there is a bug in the assembler in this area
which assumes longs are 32 bit (from memory). Could that be why
you're seeing this?

> I can't really understand the motivation for the change, specifically
> the changelog for the patch states that the assembler was getting the
> sign extension wrong in one case, but I can't see where. All the uses of
> the "mov" and "and" instructions look sane to me. Could you explain the
> issues you were seeing in a bit more detail, please?

Its one of the things which has always bugged me about the SH assembler,
that its checks on the immediate argument don't take into account
whether the instruction sign extends its argument. To me more precise,
it checks all immediates are in the range -256 to +255.

So I modified binutils to take into account whether the instruction
sign extends or not, and found that entry.S had a bug:

@@ -676,8 +676,9 @@ need_resched:

        mov     #OFF_SR, r0
        mov.l   @(r0,r15), r0           ! get status register
-       and     #0xf0, r0               ! interrupts off (exception path)?
-       cmp/eq  #0xf0, r0
+       shlr    r0
+       and     #(0xf0>>1), r0
+       cmp/eq  #(0xf0>>1), r0          ! interrupts off (exception path)?
        bt      noresched
        mov.l   3f, r0
        jsr     @r0                     ! call preempt_schedule_irq

Here the "and" doesn't sign extend, but the "cmp/eq" does.

All the other changes are to clarify when sign extension is actually
taking place. Personally I'd rather see
  add #0xffffffe0, r0
than
  add #0xe0, r0
and have to remember that sign extension is taking place. This also happens
to be what my modified assembler requires!

Stuart
