From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 05 Aug 2015 03:30:37 +0000
Subject: Re: [PATCH] dmaengine: shdma: Make dummy shdma_chan_filter() always return false
Message-Id: <20150805031837.GG11789@localhost>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jul 10, 2015 at 12:07:25PM +0200, Geert Uytterhoeven wrote:
> If CONFIG_SH_DMAE_BASE (which is required for DMA engine support for
> legacy SH, SH/R-Mobile, and R-Car Gen1, but not for R-Car Gen2) is not
> enabled, but CONFIG_RCAR_DMAC (for R-Car Gen2 DMA engine support) is,
> and the DTS doesn't provide a "dmas" property for a device,
> dma_request_slave_channel_compat() incorrectly succeeds, and returns a
> DMA channel.
> 
> However, when trying to use that DMA channel later, it fails with:
> 
>     rcar-dmac e6700000.dma-controller: rcar_dmac_prep_slave_sg: bad parameter: len=1, id=-22
> 
> (Fortunately most drivers can handle this failure, and fall back to
> PIO)
> 
> The reason for this is that a NULL legacy filter function is used, which
> actually means "all channels are OK", not "do not match".
> If CONFIG_SH_DMAE_BASE is enabled (like in shmobile_defconfig, which
> supports other SoCs besides R-Car Gen2), shdma_chan_filter() correctly
> returns false, as no available channel on R-Car Gen2 matches a
> shdma-base channel.
> If the DTS does provide a "dmas" property, dma_request_slave_channel()
> succeeds, and legacy filter-based matching is not used.
> 
> To fix this, change shdma_chan_filter from being NULL to a dummy
> function that always returns false, like is done on other platforms.

Applied, thanks

-- 
~Vinod
