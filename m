From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 20 Dec 2014 18:51:29 +0000
Subject: Re: [PATCH] i2c: sh_mobile: fix uninitialized var when debug is enabled
Message-Id: <1538093.pfjOnlVSo3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1419064602-8529-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1419064602-8529-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Wolfram,

Thank you for tha patch.

On Saturday 20 December 2014 09:36:42 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  drivers/i2c/busses/i2c-sh_mobile.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c
> b/drivers/i2c/busses/i2c-sh_mobile.c index a12297e7680a..440d5dbc8b5f
> 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -550,6 +550,7 @@ static struct dma_chan
> *sh_mobile_i2c_request_dma_chan(struct device *dev,
> 
>  	chan = dma_request_slave_channel_reason(dev, chan_name);
>  	if (IS_ERR(chan)) {
> +		ret = PTR_ERR(chan);
>  		dev_dbg(dev, "request_channel failed for %s (%d)\n", chan_name, ret);

You could just do

		dev_dbg(dev, "request_channel failed for %s (%d)\n", chan_name,
			PTR_ERR(chan));

but that's up to you.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  		return chan;
>  	}

-- 
Regards,

Laurent Pinchart

