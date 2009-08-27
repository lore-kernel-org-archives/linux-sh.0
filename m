From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 27 Aug 2009 20:13:11 +0000
Subject: Re: Recent assembler sign extension patch
Message-Id: <20090827201311.GA6791@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090827132813.GB4668@console-pimps.org>
In-Reply-To: <20090827132813.GB4668@console-pimps.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2009 at 03:39:36PM +0100, Stuart MENEFY wrote:
> 
> Strange, this works OK for me although I'm using a slightly older
> as (2.18.50.0.8.20090602). However I did see this error with gas
> built on x86-64 - there is a bug in the assembler in this area
> which assumes longs are 32 bit (from memory). Could that be why
> you're seeing this?
> 

Bingo! Good call there, Stuart. It is indeed a 64-bit host bug in the
assembler. The bug is still present in the latest binutils sources. I've
attached a patch that I will push towards the binutils folks.

> 
> Its one of the things which has always bugged me about the SH assembler,
> that its checks on the immediate argument don't take into account
> whether the instruction sign extends its argument. To me more precise,
> it checks all immediates are in the range -256 to +255.
> 
> So I modified binutils to take into account whether the instruction
> sign extends or not, and found that entry.S had a bug:
> 

Are you planning on submitting these assembler changes upstream? It'd be
cool if you can.

> @@ -676,8 +676,9 @@ need_resched:
> 
>         mov     #OFF_SR, r0
>         mov.l   @(r0,r15), r0           ! get status register
> -       and     #0xf0, r0               ! interrupts off (exception path)?
> -       cmp/eq  #0xf0, r0
> +       shlr    r0
> +       and     #(0xf0>>1), r0
> +       cmp/eq  #(0xf0>>1), r0          ! interrupts off (exception path)?
>         bt      noresched
>         mov.l   3f, r0
>         jsr     @r0                     ! call preempt_schedule_irq
> 
> Here the "and" doesn't sign extend, but the "cmp/eq" does.
> 
> All the other changes are to clarify when sign extension is actually
> taking place. Personally I'd rather see
>   add #0xffffffe0, r0
> than
>   add #0xe0, r0
> and have to remember that sign extension is taking place. This also happens
> to be what my modified assembler requires!
> 
> Stuart

Ah right, I understand now. That makes sense.


Index: gas/config/tc-sh.c
=================================RCS file: /cvs/src/src/gas/config/tc-sh.c,v
retrieving revision 1.132
diff -u -r1.132 tc-sh.c
--- gas/config/tc-sh.c	24 Jul 2009 11:45:00 -0000	1.132
+++ gas/config/tc-sh.c	27 Aug 2009 20:09:14 -0000
@@ -156,6 +156,11 @@
 #define ENCODE_RELAX(what,length) (((what) << 4) + (length))
 #define GET_WHAT(x) ((x>>4))
 
+/* Truncate and sign-extend at 32 bits, so that building on a 64-bit host
+   gives identical results to a 32-bit host.  */
+#define TRUNC(X)	((long) (X) & 0xffffffff)
+#define SEXT(X)		((TRUNC (X) ^ 0x80000000) - 0x80000000)
+
 /* These are the three types of relaxable instruction.  */
 /* These are the types of relaxable instructions; except for END which is
    a marker.  */
@@ -4183,7 +4188,7 @@
 	val = ((val >> shift)
 	       | ((long) -1 & ~ ((long) -1 >> shift)));
     }
-  if (max != 0 && (val < min || val > max))
+  if (max != 0 && (SEXT(val) < min || SEXT(val) > max))
     as_bad_where (fixP->fx_file, fixP->fx_line, _("offset out of range"));
   else if (max != 0)
     /* Stop the generic code from trying to overlow check the value as well.

