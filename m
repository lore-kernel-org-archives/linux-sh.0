From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 24 Feb 2015 16:38:19 +0000
Subject: Re: [PATCH 01/28 v3] dmaengine: export symbol of of_dma_request_slave_channel()
Message-Id: <20150224162619.GH5208@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
 <87egpkop98.wl%kuninori.morimoto.gx@renesas.com>
 <87bnkk162d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bnkk162d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon <horms@verge.net.au>, Mark Brown <broonie@kernel.org>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Arnd Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org

On Tue, Feb 24, 2015 at 12:54:16AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current DMAEngine implementation of DT bindings can't support
> DT subnode. This patch export symbols of of_dma_request_slave_channel()
> for subnode DMA DT bingings.
> 
> ex)
> 
> rcar_sound: rcar_sound@ec500000 {
>         ...
>         rcar_sound,dvc {
>                 dvc0: dvc@0 {
>                         dmas = <&audma0 0xbc>;
>                         dma-names = "tx";
>                 };
>                 dvc1: dvc@1 {
>                         dmas = <&audma0 0xbe>;
>                         dma-names = "tx";
>                 };
>         };
>         ...
> };
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> v2 -> v3
> 
>  - don't remove export from of_dma.h
> 
>  drivers/dma/of-dma.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
> index ca31f1b..cbd4a8a 100644
> --- a/drivers/dma/of-dma.c
> +++ b/drivers/dma/of-dma.c
> @@ -194,6 +194,7 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
>  
>  	return ERR_PTR(ret_no_channel);
>  }
> +EXPORT_SYMBOL_GPL(of_dma_request_slave_channel);
>  
>  /**
>   * of_dma_simple_xlate - Simple DMA engine translation function
Typically you should post whole series. Anyway, i am okay with this patch,
how do you want to merge this, should i pick it up or everything goes thru
ASoC tree or something else?

-- 
~Vinod

