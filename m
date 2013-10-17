From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 17 Oct 2013 13:02:29 +0000
Subject: Re: [PATCH 1/3] rcar-hpbdma: add max transfer size
Message-Id: <525FDFE5.3070703@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ioww187v.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ioww187v.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 17-10-2013 14:51, Kuninori Morimoto wrote:

> shdma_chan_probe() can set max transfer size,
> but it will be PAGE_SIZE with out this patch.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/dma/sh/rcar-hpbdma.c |    2 ++
>   1 file changed, 2 insertions(+)

> diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
> index ebad845..b1ae8dc 100644
> --- a/drivers/dma/sh/rcar-hpbdma.c
> +++ b/drivers/dma/sh/rcar-hpbdma.c
> @@ -510,6 +510,8 @@ static int hpb_dmae_chan_probe(struct hpb_dmae_device *hpbdev, int id)
>   	}
>
>   	schan = &new_hpb_chan->shdma_chan;
> +	schan->max_xfer_len = HPB_DMA_TCR_MAX + 1;
> +

    +1 is not correct here, HPB_DMA_TCR_MAX is #define'd as 16 MiB, not 16 MiB 
- 1.

WBR, Sergei

