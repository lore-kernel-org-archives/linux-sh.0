From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 07:30:32 +0000
Subject: Re: [PATCH 01/05] dmaengine: shdma: Remove sh_dmae_slave_chan_id
Message-Id: <Pine.LNX.4.64.1003190825530.4490@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <20100319044638.17051.97049.sendpatchset@t400s>
In-Reply-To: <20100319044638.17051.97049.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, 19 Mar 2010, Magnus Damm wrote:

> From: Magnus Damm <damm@opensource.se>
> 
> This patch replaces the sh_dmae_slave_chan_id enum
> with an unsigned int. The purpose of this chainge is
> to make it possible to separate the slave id enums
> from the dmaengine header.
> 
> The slave id enums varies with processor model, so in
> the future it makes sense to put these in the processor
> specific headers together with the pinmux enums.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/sh/include/asm/dmaengine.h |    6 +++---
>  arch/sh/include/asm/siu.h       |    8 ++++----
>  drivers/dma/shdma.c             |    8 ++++----
>  drivers/serial/sh-sci.c         |    4 ++--
>  include/linux/serial_sci.h      |    4 ++--
>  5 files changed, 15 insertions(+), 15 deletions(-)
> 
> --- 0001/arch/sh/include/asm/dmaengine.h
> +++ work/arch/sh/include/asm/dmaengine.h	2010-03-18 23:30:46.000000000 +0900
> @@ -17,7 +17,7 @@
>  
>  #define SH_DMAC_MAX_CHANNELS	6
>  
> -enum sh_dmae_slave_chan_id {
> +enum {
>  	SHDMA_SLAVE_SCIF0_TX,
>  	SHDMA_SLAVE_SCIF0_RX,
>  	SHDMA_SLAVE_SCIF1_TX,
> @@ -38,7 +38,7 @@ enum sh_dmae_slave_chan_id {
>  };
>  
>  struct sh_dmae_slave_config {
> -	enum sh_dmae_slave_chan_id	slave_id;
> +	unsigned int			slave_id;

I think, INT_MAX DMA slave IDs will be enough;) So, you could just use an 
int to save typing and to reserve -1 (or -EINVAL) as an invalid DMA ID. As 
I am currencly realising, it can be useful, e.g., if you want to enable 
DMA only on Rx and not on Tx of some device. This, of course, throughout 
this patch.

[snip]

> --- 0001/drivers/dma/shdma.c
> +++ work/drivers/dma/shdma.c	2010-03-18 23:30:46.000000000 +0900
> @@ -266,7 +266,7 @@ static struct sh_desc *sh_dmae_get_desc(
>  }
>  
>  static struct sh_dmae_slave_config *sh_dmae_find_slave(
> -	struct sh_dmae_chan *sh_chan, enum sh_dmae_slave_chan_id slave_id)
> +	struct sh_dmae_chan *sh_chan, struct sh_dmae_slave *param)

This doesn't seem to be needed, at least, not in this patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
