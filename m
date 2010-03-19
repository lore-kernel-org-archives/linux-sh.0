From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 19 Mar 2010 08:15:57 +0000
Subject: Re: [PATCH 05/05] dmaengine: shdma: Enable on SH-Mobile ARM
Message-Id: <20100319081557.GC10003@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044719.17051.57155.sendpatchset@t400s>
In-Reply-To: <20100319044719.17051.57155.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 19, 2010 at 05:15:42PM +0900, Magnus Damm wrote:
> Hey Guennadi,
> 
> On Fri, Mar 19, 2010 at 4:24 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > On Fri, 19 Mar 2010, Magnus Damm wrote:
> >> --- 0005/include/linux/serial_sci.h
> >> +++ work/include/linux/serial_sci.h ? 2010-03-18 23:38:59.000000000 +0900
> >> @@ -3,7 +3,7 @@
> >>
> >> ?#include <linux/serial_core.h>
> >> ?#ifdef CONFIG_SERIAL_SH_SCI_DMA
> >> -#include <asm/dmaengine.h>
> >> +#include <linux/sh_dma.h>
> >
> > Shouldn't this be done in patch "04/05"?
> 
> It could, but nothing requires this change in 04/05. So the final
> point where this is needed is 05/05.
> 
The ifdefs are also superfluous at this point, but those can be killed
off with an incremental patch.
