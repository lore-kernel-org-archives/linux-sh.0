From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 10 Dec 2014 19:06:34 +0000
Subject: Re: [RFC 1/2] i2c: sh_mobile: refactor DMA setup
Message-Id: <548899BA.40002@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418217709-26392-1-git-send-email-wsa@the-dreams.de> <1418217709-26392-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1418217709-26392-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>

Hello.

On 12/10/2014 04:21 PM, Wolfram Sang wrote:

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>

> Refactor DMA setup to keep the errno so we can implement better
> deferred probe support in the next step.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>   drivers/i2c/busses/i2c-sh_mobile.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)

> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index b9c8cf2aac2c..636f2297143a 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
[...]
> @@ -749,21 +749,18 @@ static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
>   };
>   MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);
>
> -static int sh_mobile_i2c_request_dma_chan(struct device *dev, enum dma_transfer_direction dir,
> -					  dma_addr_t port_addr, struct dma_chan **chan_ptr)
> +static struct dma_chan *sh_mobile_i2c_request_dma_chan(struct device *dev,
> +				enum dma_transfer_direction dir, dma_addr_t port_addr)

    Hm, alignment style changed...

[...]
> @@ -891,13 +886,15 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
>   	/* Init DMA */
>   	sg_init_table(&pd->sg, 1);
>   	pd->dma_direction = DMA_NONE;
> -	ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
> -					     res->start + ICDR, &pd->dma_rx);
> +	pd->dma_rx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_DEV_TO_MEM,
> +					     res->start + ICDR);

    The alignment of this line is strange: it's neither here nor there, i.e. 
not aligned to the next char after ( above and still contains spaces. I think 
we want the old way of the alignment kept, i.e. the line starting under 
'pd->dev'...

> +	ret = PTR_ERR(pd->dma_rx);
>   	if (ret = -EPROBE_DEFER)
>   		return ret;
>
> -	ret = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
> -					     res->start + ICDR, &pd->dma_tx);
> +	pd->dma_tx = sh_mobile_i2c_request_dma_chan(pd->dev, DMA_MEM_TO_DEV,
> +					     res->start + ICDR);

    Likewise.

[...]

WBR, Sergei

