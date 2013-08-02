From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Aug 2013 11:35:47 +0000
Subject: Re: [PATCH] tmio_mmc_dma: fix PIO fallback on SDHI
Message-Id: <Pine.LNX.4.64.1308021332260.28012@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <201308020117.17897.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308020117.17897.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-mmc@vger.kernel.org, ian@mnementh.co.uk, cjb@laptop.org, linux-sh@vger.kernel.org, max.filippov@cogentembedded.com

Hi Sergei,

Thanks for your patch.

On Fri, 2 Aug 2013, Sergei Shtylyov wrote:

> I'm testing SH-Mobile SDHI driver in DMA mode with a  new DMA controller  using
> 'bonnie++' and getting DMA error after which the tmio_mmc_dma.c code falls back
> to PIO but all commands time out after that.  It turned out that the fallback
> code calls tmio_mmc_enable_dma() with RX/TX channels already freed and pointers
> to them cleared, so that the function bails out early instead  of clearing the
> DMA bit in the CTL_DMA_ENABLE register.  Fixing the RX/TX channel check so that
> it takes place only when enabling DMA helps with the PIO fallback.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> The patch is against Chris Ball's 'mmc.git' repo, 'master' branch.
> 
>  drivers/mmc/host/tmio_mmc_dma.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: mmc/drivers/mmc/host/tmio_mmc_dma.c
> =================================> --- mmc.orig/drivers/mmc/host/tmio_mmc_dma.c
> +++ mmc/drivers/mmc/host/tmio_mmc_dma.c
> @@ -25,7 +25,7 @@
>  
>  void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
>  {
> -	if (!host->chan_tx || !host->chan_rx)
> +	if (enable && !(host->chan_tx && host->chan_rx))
>  		return;

Ok, I see the problem and this does fix it. But it adds complexity to the 
driver - one more condition to an if. Whereas, I think, it can be avoided 
if we just move calls to

tmio_mmc_enable_dma(host, false);

in tmio_mmc_start_dma_rx() and tmio_mmc_start_dma_tx() a couple of lines 
up - before clearing ->chan_rx and ->chan_tx pointers? That should work 
too at no cost. I think that would be a better fix, could you, please, 
try?

Thanks
Guennadi

>  #if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
