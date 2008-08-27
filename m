From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Aug 2008 14:55:29 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <20080827145528.GC32530@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A few notes in addition to what Manuel said:

On Wed, Aug 27, 2008 at 01:12:29PM +0200, Manuel Lauss wrote:
> > diff -uNr -x '*.mod.c' -x '*.o' -x '*.cmd' -x '*.d' -x 'built-in.*' -x '*.S' -x '*.s' -x 'vmlinux*' -x zImage -x '*syscall*' a/arch/sh/boards/renesas/edosk7760/setup.c b/arch/sh/boards/renesas/edosk7760/setup.c
> > --- a/arch/sh/boards/renesas/edosk7760/setup.c	1970-01-01 01:00:00.000000000 +0100
> > +++ b/arch/sh/boards/renesas/edosk7760/setup.c	2008-08-27 12:01:58.000000000 +0200
> > @@ -0,0 +1,177 @@
> > +/* 
> > + * linux/arch/sh/edosk7760/setup.c
> > + *
> > + * Copyright (C) 2000  Kazumoto Kojima
> > + *
> > + *
> > + * Modified for EDOSK7760 by
> > + * Richard Bister
> > + * 
> > + * Port to 2.6.26 by
> > + * Luca Santini www.spesonline.com
> > + */
> > +
Please get your copyright notices fixed, and actually toss a license stub
in there. I can gaurantee you that Kojima-san had nothing to do with this
platform in 2000, especially as Camelot silicon didn't begin sampling
before Q1 2003.

Also, drop the path from the comment. Even now it's not even accurate,
which goes to show how useful that bit of information is.

> > +static struct smc91x_platdata smc91x_info = {
> > +	.flags = SMC91X_USE_16BIT,
> > +};
> > +
For some reason your flags here and your later smc91x patch for edosk7760
have absolutely nothing in common. This leads me to believe that you
either couldn't get the dynamic configuration working, in which case this
bit of code is useless, or that it works fine and there's no need for the
changes to smc91x.h. If you need both, you are doing something very
wrong.

> > +static int __init init_edosk7760_devices(void){

The { should be on a line by itself.

> > +	int ret = -1;
> > +
Pointless initialization and unused variable.

> > +/// have a look to include/asm-sh/machvec.h 

C++ comments have no place in the kernel. Just because C99 dropped the
ball doesn't mean we have to perpetuate this idiocy in-tree. The header
location is also different these days, and the comment itself is of
questionable use. If someone can't work out to look at machvec.h for
these definitions, they probably shouldn't be touching the machine vector
in the first place.

> Also, please rediff against a more current linux source tree.
> Since 2.6.27-rc2 or so, the board file organization has changed slightly; as
> long as you only have the setup.c file, I suggest you rename it to
> mach-edosk7760.c and wire it up in arch/sh/boards/Makefile.
> 
Indeed. Please always diff against a current kernel. diffing against
2.6.26 at this late in the 2.6.27 cycle is an act of futility.
