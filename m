From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Oct 2015 00:03:10 +0000
Subject: Re: [PATCH] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <87io5pgrcr.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>


Hi, Wolfram

> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 616433d387cdb2..ef26e933b1e9cb 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -612,7 +612,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>  	if (IS_ERR(priv->io))
>  		return PTR_ERR(priv->io);
>  
> +	pm_runtime_enable(dev);
> +	pm_runtime_get_sync(dev);
>  	rcar_i2c_init(priv);
> +	pm_runtime_put(dev);

Please correct me if I'm misunderstanding, but in my experience,
above rcar_i2c_init() result can be removed if SoC has power-off feature,
and if IP doesn't keep register value power-off case ?
This case register doesn't keep myfunc_A's setting,
because it calls pm_runtime_put()

     pm_runtime_get_sync()
     myfunc_A()
     pm_runtime_put()
     ...
     pm_runtime_get_sync()
     myfunc_B()
     pm_runtime_put()

It should be this ?

     pm_runtime_get_sync()
     myfunc_A()
     myfunc_B()
     pm_runtime_put()
