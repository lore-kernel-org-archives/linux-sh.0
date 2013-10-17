From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 17 Oct 2013 13:23:28 +0000
Subject: Re: [PATCH 3/3] rcar-hpbdma: fixup channel busy check for double plane
Message-Id: <525FE4D0.2080406@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvs01876.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvs01876.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 17-10-2013 14:51, Kuninori Morimoto wrote:

> The device busy check method is different between
> single and double planes.
> It will always return "busy" without this patch
> if channel used as double plane.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   drivers/dma/sh/rcar-hpbdma.c |    5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
> index 0518135..6fc37b4 100644
> --- a/drivers/dma/sh/rcar-hpbdma.c
> +++ b/drivers/dma/sh/rcar-hpbdma.c
> @@ -388,7 +388,10 @@ static bool hpb_dmae_channel_busy(struct shdma_chan *schan)
>   	struct hpb_dmae_chan *chan = to_chan(schan);
>   	u32 dstsr = ch_reg_read(chan, HPB_DMAE_DSTSR);
>
> -	return (dstsr & HPB_DMAE_DSTSR_DMSTS) = HPB_DMAE_DSTSR_DMSTS;
> +	if (chan->xfer_mode = XFER_DOUBLE)
> +		return dstsr & HPB_DMAE_DSTSR_DQSTS;

    This bit is not #define'd in the driver. Did you compile this?

WBR, Sergei

