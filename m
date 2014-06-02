From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Jun 2014 10:32:12 +0000
Subject: Re: [PATCH 3/3] dmaengine: sh: don't use dynamic static allocation
Message-Id: <1483758.1PI4sXMDEj@avalon>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

Thank you for the patch.

On Monday 02 June 2014 09:48:24 Vinod Koul wrote:
> dynamic stack allocation in kernel is considered bad as kernel stack is low
> and we get warns on few archs as reported by kbuild test robot
> 
> >> drivers/dma/sh/shdma-base.c:671:32: sparse: Variable length array is
> >> used.
> >> drivers/dma/sh/shdma-base.c:701:1: warning: 'shdma_prep_dma_cyclic' uses
> >> dynamic stack allocation [enabled by default]
> 
> Fix this by making a static array of 32 which should be sufficient for
> shdma_prep_dma_cyclic which only user in kernel is audio and 32 periods for
> audio seems quite sufficient atm

I agree with the analysis. I'll let our sound expert, Morimoto-san (CC'ed), 
comment on the proposed fix. If it suits his needs, I'm fine with the patch.

> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> ---
>  drivers/dma/sh/shdma-base.c |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
> index 591b9d8..b35007e 100644
> --- a/drivers/dma/sh/shdma-base.c
> +++ b/drivers/dma/sh/shdma-base.c
> @@ -657,6 +657,8 @@ static struct dma_async_tx_descriptor
> *shdma_prep_slave_sg( direction, flags, false);
>  }
> 
> +#define SHDMA_MAX_SG_LEN 32
> +
>  static struct dma_async_tx_descriptor *shdma_prep_dma_cyclic(
>  	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  	size_t period_len, enum dma_transfer_direction direction,
> @@ -668,7 +670,7 @@ static struct dma_async_tx_descriptor
> *shdma_prep_dma_cyclic( unsigned int sg_len = buf_len / period_len;
>  	int slave_id = schan->slave_id;
>  	dma_addr_t slave_addr;
> -	struct scatterlist sgl[sg_len];
> +	struct scatterlist sgl[SHDMA_MAX_SG_LEN];
>  	int i;
> 
>  	if (!chan)
> @@ -676,6 +678,12 @@ static struct dma_async_tx_descriptor
> *shdma_prep_dma_cyclic(
> 
>  	BUG_ON(!schan->desc_num);
> 
> +	if (sg_len > SHDMA_MAX_SG_LEN) {
> +		dev_err(schan->dev, "sg length %d exceds limit %d",
> +				sg_len, SHDMA_MAX_SG_LEN);
> +		return NULL;
> +	}
> +
>  	/* Someone calling slave DMA on a generic channel? */
>  	if (slave_id < 0 || (buf_len < period_len)) {
>  		dev_warn(schan->dev,

-- 
Regards,

Laurent Pinchart

