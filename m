From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 28 Aug 2008 03:00:52 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <20080828030051.GA20197@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 27, 2008 at 06:32:02PM +0200, Luca Santini wrote:
> Paul Mundt wrote:
> >On Wed, Aug 27, 2008 at 01:12:29PM +0200, Manuel Lauss wrote:
> >>>diff -uNr -x '*.mod.c' -x '*.o' -x '*.cmd' -x '*.d' -x 'built-in.*' -x 
> >>>'*.S' -x '*.s' -x 'vmlinux*' -x zImage -x '*syscall*' 
> >>>a/arch/sh/boards/renesas/edosk7760/setup.c 
> >>>b/arch/sh/boards/renesas/edosk7760/setup.c
> >>>--- a/arch/sh/boards/renesas/edosk7760/setup.c	1970-01-01 
> >>>01:00:00.000000000 +0100
> >>>+++ b/arch/sh/boards/renesas/edosk7760/setup.c	2008-08-27 
> >>>12:01:58.000000000 +0200
> >>>@@ -0,0 +1,177 @@
> >>>+/* 
> >>>+ * linux/arch/sh/edosk7760/setup.c
> >>>+ *
> >>>+ * Copyright (C) 2000  Kazumoto Kojima
> >>>+ *
> >>>+ *
> >>>+ * Modified for EDOSK7760 by
> >>>+ * Richard Bister
> >>>+ * 
> >>>+ * Port to 2.6.26 by
> >>>+ * Luca Santini www.spesonline.com
> >>>+ */
> >>>+
> >Please get your copyright notices fixed, and actually toss a license stub
> >in there. I can gaurantee you that Kojima-san had nothing to do with this
> >platform in 2000, especially as Camelot silicon didn't begin sampling
> >before Q1 2003.
> >
> 
> i've no idea what to write here....
> 
What does your company usually use as a copyright?

Look at things like arch/sh/boards/mach-rsk7203.c as an example.

> >>>+static struct smc91x_platdata smc91x_info = {
> >>>+	.flags = SMC91X_USE_16BIT,
> >>>+};
> >>>+
> >For some reason your flags here and your later smc91x patch for edosk7760
> >have absolutely nothing in common. This leads me to believe that you
> >either couldn't get the dynamic configuration working, in which case this
> >bit of code is useless, or that it works fine and there's no need for the
> >changes to smc91x.h. If you need both, you are doing something very
> >wrong.
> >
> 
> you're right; what i really need is
> 
> #define SMC_IO_SHIFT 1
> 
> but using the platdata flag
> 
> SMC91X_IO_SHIFT_1
> 
> doesn't work.
> 
Ok, so that's a real bug then. Magnus, can you take a look at this?

> >Indeed. Please always diff against a current kernel. diffing against
> >2.6.26 at this late in the 2.6.27 cycle is an act of futility.
> 
> i'm cloning current git repository.
> i was thinking the "current" kernel was 2.6.26
> 
Current git is always preferable for patches, as the rate of change is
very high during the initial merge window.
