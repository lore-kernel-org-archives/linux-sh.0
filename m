From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 18 Jun 2014 14:22:29 +0000
Subject: Re: [PATCH 11/12] ASoC: rsnd: DMA start address is properly used for each DMAC
Message-Id: <53A1A0A5.2040000@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com> <87wqcey4rl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wqcey4rl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org

On 06/18/2014 12:57 PM, Kuninori Morimoto wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

> R-Car sound uses Audio DMAC and Audio DMAC peri peri.
> Audio DMAC peri peri transfers data inside circuit.

> DMA transfer needs source / destination address,
> and destination address can be set via dmaengine_slave_config().
> The source address can be set when starting DMAEngine.
> Because Audio DMAC peri peri always ignores its value,
> current driver always used same source address for
> Audio DMAC / Audio DMAC peri peri
> (Audio DMAC peri peri source / destination address
> is always fixed value)
> But, This is not good match for DT booting.
> This patch properly uses DMA start address
> for Audio DMAC / Audio DMAC peri peri.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   sound/soc/sh/rcar/core.c |    2 ++
>   sound/soc/sh/rcar/rsnd.h |    1 +
>   2 files changed, 3 insertions(+)

> diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
> index 36895eb..6fb89fc 100644
> --- a/sound/soc/sh/rcar/core.c
> +++ b/sound/soc/sh/rcar/core.c
> @@ -200,6 +200,7 @@ void rsnd_dma_start(struct rsnd_dma *dma)
>   	struct dma_async_tx_descriptor *desc;
>
>   	desc = dmaengine_prep_dma_cyclic(dma->chan,
> +					 (dma->addr) ? dma->addr :

    () not needed at all.

[...]

WBR, Sergei

