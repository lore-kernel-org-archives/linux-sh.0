From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 23 Jul 2013 21:19:29 +0000
Subject: Re: [PATCH v4 02/15] DMA: shdma: add r8a7740 DMAC data to the device ID table
Message-Id: <Pine.LNX.4.64.1307232233190.26199@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1374576609-27748-1-git-send-email-g.liakhovetski@gmx.de>
 <1374576609-27748-3-git-send-email-g.liakhovetski@gmx.de>
 <CANqRtoRnMkUjYKp3j2agoN7ufh9DGGbha6xQS8ugibLvK3hGfA@mail.gmail.com>
In-Reply-To: <CANqRtoRnMkUjYKp3j2agoN7ufh9DGGbha6xQS8ugibLvK3hGfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, SH-Linux <linux-sh@vger.kernel.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

On Wed, 24 Jul 2013, Magnus Damm wrote:

> Hi Guennadi,
> 
> Thanks for your efforts on this.
> 
> On Tue, Jul 23, 2013 at 7:49 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> > This configuration data will be re-used, when DMAC DT support is added to
> > r8a7740, DMAC platform data in setup-r8a7740.c will be removed.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >
> > v4: make struct sh_dmae_pdata r8a7740_dma_pdata "const"
> >
> 
> [snip]
> 
> > --- /dev/null
> > +++ b/drivers/dma/sh/shdma-r8a7740.c
> > @@ -0,0 +1,95 @@
> > +#include <linux/sh_dma.h>
> > +
> > +#include <mach/dma-register.h>
> > +#include <mach/r8a7740.h>
> 
> Including stuff from <mach/..> isn't really compatible with
> MULTIPLATFORM,

Hmm, right. I modeled this arch-specific driver code after Laurent's 
pinctrl driver revamp, which also includes <mach/*.h> headers. So, we'll 
have to think how to fix both.

> so please don't write new code like this. Actually we
> don't want any code under drivers/ to include stuff from the mach
> directory.

Sure, understood.

> I suggest that you arrange your code in a way so the C version of DMAC
> support has tables with slave ids as usual under
> arch/arm/mach-shmobile/, but the DT bits that operate independently of
> C stay in drivers/... Over time we will get rid of the C version, and
> until that happens the DT and C version can coexist in parallel.

That's already how it is. Data, that I took to drivers/dma/sh/ is needed 
for both DT and C. DMA stuff, needed only for C are only DMAC devices and 
resources. I think, I might be able to carry those DMA specific headers 
and defines over from mach/ to drivers/dma/sh. Maybe it would be easier to 
do this in several steps:

1. add my drivers/dma/sh/shdma-<arch>.c files *with* mach/ headers
2. switch arches over to those files
(the above two steps are already done in my patch series)
3. move headers to drivers/dma/sh

Ok, alternatively, I might be able to do (1) above without using mach/ 
headers at all by directly copying them to drivers/dma/sh/ and then 
removing the original mach/headers in step (2)? I'll look in more detail 
at the code tomorrow.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
