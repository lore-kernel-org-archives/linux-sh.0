From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 08 Dec 2014 12:57:25 +0000
Subject: Re: [PATCH][resend] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <20141208124525.GH16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvd4b2kh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvd4b2kh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 28, 2014 at 12:17:59AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current Renesas Audio DMAC Peri Peri driver is for Renesas R-Car series,
> but it is based on SH_DMAE_BASE driver which is used for Renesas
> SH-Mobile. But it is not fully cared about DT.
> 
> For example, current SH_DMAE_BASE base driver will return non-matching
> DMA channel if some non-SH_DMAE_BASE drivers are probed.
> So, sound driver will get wrong DMA channel if Audio DMAC (= rcar-dma)
> was not probed and Audio DMAC Peri Peri (= SH_DMAE_BASE) was probed.
> 
> OTOH, many SH-Mobile series drivers are using SH_DMAE_BASE driver, and
> Renesas R-Car series will not use it anymore. Maintenance cost for fully
> cared DT support on SH_DMAE_BASE will be very high
> (and keeping compatibility will be very complex).
> 
> In addition, Audio DMAC Peri Peri itself is very simple device, and,
> no SoC/board is usign it from non-DT environment.
> 
> This patch remakes rcar-audmapp driver simply independents
> from SH_DMAE_BASE.
Hi Kuninori

Can you please split these changes into multiple smaller changes so that we
can review this propely...

> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/dma/sh/Kconfig                         |    3 +-
>  drivers/dma/sh/rcar-audmapp.c                  |  399 +++++++++++-------------
>  include/linux/platform_data/dma-rcar-audmapp.h |   34 --
>  3 files changed, 184 insertions(+), 252 deletions(-)
>  delete mode 100644 include/linux/platform_data/dma-rcar-audmapp.h
> 
> diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
> index 8190ad2..41e5c97 100644
> --- a/drivers/dma/sh/Kconfig
> +++ b/drivers/dma/sh/Kconfig
> @@ -53,7 +53,8 @@ config RCAR_HPB_DMAE
>  
>  config RCAR_AUDMAC_PP
>  	tristate "Renesas R-Car Audio DMAC Peripheral Peripheral support"
> -	depends on SH_DMAE_BASE
> +	depends on ARCH_SHMOBILE || COMPILE_TEST
Am bit wary of this, given that folks dont test on lots of archs, like arm,
powerpc, x86 etc before turning this on, so was this done here?

> +static struct dma_async_tx_descriptor *
> +audmapp_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +			size_t buf_len, size_t period_len,
> +			enum dma_transfer_direction dir, unsigned long flags)
>  {
> -	struct audmapp_chan *auchan = to_chan(schan);
> -	u32 chcr;
> -	dma_addr_t dst;
> -	int ret;
> -
> -	ret = audmapp_get_config(auchan, slave_id, &chcr, &dst);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (try)
> -		return 0;
> -
> -	auchan->chcr		= chcr;
> -	auchan->slave_addr	= slave_addr ? : dst;
> +	struct audmapp_chan *achan = chan_to_achan(chan);
>  
> -	return 0;
> +	return &achan->async_tx;
That doesn't look right to me. So for prepare you are returning descriptor
but not really preparing one, did I miss something here

-- 
~Vinod

