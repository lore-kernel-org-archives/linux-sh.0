From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 30 Sep 2008 06:40:05 +0000
Subject: Re: [PATCH] sh: Rework sh7720 GPIO header usage
Message-Id: <20080930064005.GA9926@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080929104626.5354.80315.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080929104626.5354.80315.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Sep 30, 2008 at 08:27:24AM +0200, Mark Jonas wrote:
> Magnus,
> 
> > --- 0001/arch/sh/include/asm/gpio.h
> > +++ work/arch/sh/include/asm/gpio.h     2008-09-29 15:31:10.000000000 +0900
> > @@ -1,10 +1,6 @@
> >  /*
> >  *  include/asm-sh/gpio.h
> >  *
> > - *  Copyright (C) 2007 Markus Brunner, Mark Jonas
> > - *
> > - *  Addresses for the Pin Function Controller
> > - *
> >  * This file is subject to the terms and conditions of the GNU General Public
> >  * License.  See the file "COPYING" in the main directory of this archive
> >  * for more details.
> > @@ -12,8 +8,4 @@
> >  #ifndef __ASM_SH_GPIO_H
> >  #define __ASM_SH_GPIO_H
> >
> > -#if defined(CONFIG_CPU_SH3)
> > -#include <cpu/gpio.h>
> > -#endif
> > -
> >  #endif /* __ASM_SH_GPIO_H */
> 
> This is most likely a stupid question but still:
> Now that arch/sh/include/asm/gpio.h is completely empty from the
> compiler's POV, why wasn't simply deleted?
> 
It was just in this patch, the subsequent patches added back to it.
Anyways, I've dropped that, and simply merged the subsequent patches
around the ifdef. There isn't any breakage for your platform, but you may
wish to look in to what it would take to get magicpanelr2 converted to
the generic framework.
