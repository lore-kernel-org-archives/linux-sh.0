From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 25 Jul 2014 08:58:09 +0000
Subject: Re: [PATCH v2 1/2] dmaengine: Clarify device parameter for dma_sync_*_for_*()
Message-Id: <20140725085148.GN8181@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405094182-13962-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1405094182-13962-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Jul 11, 2014 at 05:56:21PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - New
> ---
>  Documentation/dmaengine.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dmaengine.txt b/Documentation/dmaengine.txt
> index 879b6e31e2da..87d3f192e160 100644
> --- a/Documentation/dmaengine.txt
> +++ b/Documentation/dmaengine.txt
> @@ -100,8 +100,10 @@ The slave DMA usage consists of following steps:
>     The peripheral driver is expected to have mapped the scatterlist for
>     the DMA operation prior to calling device_prep_slave_sg, and must
>     keep the scatterlist mapped until the DMA operation has completed.
> -   The scatterlist must be mapped using the DMA struct device.  So,
> -   normal setup should look like this:
> +   The scatterlist must be mapped using the DMA struct device.
> +   If a mapping needs to be synchronized later, dma_sync_*_for_*() must be
> +   called using the DMA struct device, too.
> +   So, normal setup should look like this:
>  
>  	nr_sg = dma_map_sg(chan->device->dev, sgl, sg_len);
>  	if (nr_sg = 0)
> -- 
> 1.9.1
> 
Applied, thanks

-- 
~Vinod
