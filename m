From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 04 Aug 2014 15:38:27 +0000
Subject: Re: [PATCH v2 1/8] dmaengine: sh: Rework Kconfig and Makefile
Message-Id: <7434411.teHIrKfERp@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405727425-6237-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405727425-6237-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

Thank you for the review.

On Monday 04 August 2014 11:09:06 Geert Uytterhoeven wrote:
> On Sat, Jul 19, 2014 at 1:50 AM, Laurent Pinchart wrote:
> > Separate helpers and drivers in the Kconfig and Makefile to improve
> > readability and move the CONFIG_OF dependency from the Makefile to
> > Kconfig.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > ---
> > 
> > Changes since v1:
> > 
> > - Replace CONFIG_OF with OF in Kconfig
> > ---
> > 
> >  drivers/dma/sh/Kconfig  | 24 +++++++++++++++++++-----
> >  drivers/dma/sh/Makefile | 14 +++++++++++---
> >  2 files changed, 30 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> > index 0f71981..0349125 100644
> > --- a/drivers/dma/sh/Kconfig
> > +++ b/drivers/dma/sh/Kconfig
> > @@ -2,21 +2,39 @@
> >  # DMA engine configuration for sh
> >  #
> > 
> > +#
> > +# DMA Engine Helpers
> > +#
> > +
> >  config SH_DMAE_BASE
> >         bool "Renesas SuperH DMA Engine support"
> > -       depends on (SUPERH && SH_DMA) || ARCH_SHMOBILE || COMPILE_TEST
> > +       depends on SUPERH || ARCH_SHMOBILE || COMPILE_TEST
> > +       depends on !SUPERH || SH_DMA
> >         depends on !SH_DMA_API
> >         default y
> >         select DMA_ENGINE
> >         help
> >           Enable support for the Renesas SuperH DMA controllers.
> > 
> > +#
> > +# DMA Controllers
> > +#
> > +
> >  config SH_DMAE
> >         tristate "Renesas SuperH DMAC support"
> >         depends on SH_DMAE_BASE
> >         help
> >           Enable support for the Renesas SuperH DMA controllers.
> > 
> > +if SH_DMAE
> > +
> > +config SH_DMAE_R8A73A4
> > +       def_bool y
> > +       depends on ARCH_R8A73A4
> > +       depends on OF
> > +
> > +endif
> 
> What's the rationale behind putting this inside an "if/endif" block, instead
> of using "depends on"?

In my opinion it shows more clearly that the SH_DMAE_R8A73A4 option is a sub-
driver of SH_DMAE. It might just be a matter of personal taste though.

> BTW, I'm still puzzled by the difference between SH_DMAE_BASE and SH_DMAE,
> which have identical help texts.

SH_DMAE_BASE is a helper layer that aims at handling tasks required by the DMA 
engine API but not specific to drivers in a central location. There's nothing 
really SH-specific in there, it should be turned in more generic helpers and 
moved to the DMA engine core.

SH_DMAE is the SYS-DMAC driver itself. The Kconfig symbol is badly named given 
that we now have different DMA engine drivers for "sh" (in the sense SuperH + 
ARM).

> > +
> >  config SUDMAC
> >         tristate "Renesas SUDMAC support"
> >         depends on SH_DMAE_BASE
> > @@ -34,7 +52,3 @@ config RCAR_AUDMAC_PP
> >         depends on SH_DMAE_BASE
> >         help
> >           Enable support for the Renesas R-Car Audio DMAC Peripheral
> >           Peripheral controllers.> 
> > -
> > -config SHDMA_R8A73A4
> > -       def_bool y
> > -       depends on ARCH_R8A73A4 && SH_DMAE != n

-- 
Regards,

Laurent Pinchart

