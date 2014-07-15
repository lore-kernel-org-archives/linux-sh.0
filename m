From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 15 Jul 2014 22:50:36 +0000
Subject: Re: [PATCH 1/7] dmaengine: sh: Rework Kconfig and Makefile
Message-Id: <1613941.6uN1RdcV7Y@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405455522-20676-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405455522-20676-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

Thank you for the review.

On Wednesday 16 July 2014 01:36:21 Sergei Shtylyov wrote:
> On 07/16/2014 12:18 AM, Laurent Pinchart wrote:
> > Separate helpers and drivers in the Kconfig and Makefile to improve
> > readability and move the CONFIG_OF dependency from the Makefile to
> > Kconfig.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   drivers/dma/sh/Kconfig  | 24 +++++++++++++++++++-----
> >   drivers/dma/sh/Makefile | 14 +++++++++++---
> >   2 files changed, 30 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> > index 0f71981..383b21f 100644
> > --- a/drivers/dma/sh/Kconfig
> > +++ b/drivers/dma/sh/Kconfig
> > @@ -2,21 +2,39 @@
> >   # DMA engine configuration for sh
> >   #
> > 
> > +#
> > +# DMA Engine Helpers
> > +#
> > +
> >   config SH_DMAE_BASE
> >   	bool "Renesas SuperH DMA Engine support"
> > -	depends on (SUPERH && SH_DMA) || ARCH_SHMOBILE || COMPILE_TEST
> > +	depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> > +	depends on !SUPERH || SH_DMA
> 
> s/||/&&/?

No. The driver can be used on SUPERH only when SH_DMA is enabled, and can be 
used on other architectures regardless of SH_DMA. This could have been 
expressed as (SUPERH && SH_DMA) || !SUPERH as well.

> >   	depends on !SH_DMA_API
> >   	default y
> >   	select DMA_ENGINE
> >   	help
> >   	  Enable support for the Renesas SuperH DMA controllers.
> > +#
> > +# DMA Controllers
> > +#
> > +
> >   config SH_DMAE
> >   	tristate "Renesas SuperH DMAC support"
> >   	depends on SH_DMAE_BASE
> >   	help
> >   	  Enable support for the Renesas SuperH DMA controllers.
> > 
> > +if SH_DMAE
> > +
> > +config SH_DMAE_R8A73A4
> > +	def_bool y
> > +	depends on ARCH_R8A73A4
> > +	depends on CONFIG_OF
> 
> s/CONFIG_//.

My bad, will fix.

> > +
> > +endif
> > +
> >   config SUDMAC
> >   	tristate "Renesas SUDMAC support"
> >   	depends on SH_DMAE_BASE
> 
> [...]

-- 
Regards,

Laurent Pinchart

