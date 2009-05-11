From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 11 May 2009 12:26:33 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <20090511122633.GA26935@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 07:49:04PM +0900, Paul Mundt wrote:
> On Mon, May 11, 2009 at 12:51:43PM +0200, Manuel Lauss wrote:
> > On Mon, May 11, 2009 at 07:32:03PM +0900, Magnus Damm wrote:
> > > So with this patch all DMA channels must use a single linux interrupt.
> > > Requesting interrupt 34 should be ok in this case (the first DMAC
> > > vector with value 0x640) but all other interrupt sources are disabled.
> > > Interrupt 34 becomes a shared interrupt. We did similar changes for a
> > > bunch of other processor models earlier this year, but we somehow
> > > missed sh7760 then. Or ignored may be a better word, this since
> > > there's no sh7760 hardware on my desk. =)
> > 
> > Disabling DMAC solves this.  The TMU patch also seems to work fine.
> >  
> >  
> > > If you have a little time to spend on this, then feel free to test by
> > > #ifdefing out various INTC_VECT() to check which vector that makes the
> > > boot fail. A good start may be to disable all DMA users and see if
> > > that helps.
> > 
> > I'll try to figure it out if I can find some more free time.
> > 
> Try with this:
> 
> ---
> 
> diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
> index 666713a..63e9dd3 100644
> --- a/arch/sh/drivers/dma/Kconfig
> +++ b/arch/sh/drivers/dma/Kconfig
> @@ -16,7 +16,8 @@ config SH_DMA_IRQ_MULTI
>  		     CPU_SUBTYPE_SH7750S || CPU_SUBTYPE_SH7750R || \
>  		     CPU_SUBTYPE_SH7751R || CPU_SUBTYPE_SH7091  || \
>  		     CPU_SUBTYPE_SH7763  || CPU_SUBTYPE_SH7764  || \
> -		     CPU_SUBTYPE_SH7780  || CPU_SUBTYPE_SH7785
> +		     CPU_SUBTYPE_SH7780  || CPU_SUBTYPE_SH7785  || \
> +		     CPU_SUBTYPE_SH7760
>  
>  config NR_ONCHIP_DMA_CHANNELS
>  	int

Perfect!  All is working now.

Thank you both!
	Manuel Lauss
