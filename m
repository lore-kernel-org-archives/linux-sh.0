From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 07 Oct 2015 12:12:34 +0000
Subject: Re: [PATCH] i2c: rcar: Remove obsolete platform data support
Message-Id: <56150C32.5040700@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444205791-25480-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444205791-25480-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 10/7/2015 11:16 AM, Geert Uytterhoeven wrote:

> Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
> setup code"), Renesas R-Car SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to use platform data
> anymore, hence remove platform data configuration.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Commit 4baadb9e05c68962 is now in arm-soc/for-next.
> ---
>   drivers/i2c/busses/i2c-rcar.c | 19 +------------------
>   include/linux/i2c/i2c-rcar.h  | 10 ----------
>   2 files changed, 1 insertion(+), 28 deletions(-)
>   delete mode 100644 include/linux/i2c/i2c-rcar.h
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 3e125654bb28..cd38406db074 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
[...]
> @@ -654,14 +652,8 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>
>   	bus_speed = 100000; /* default 100 kHz */
>   	ret = of_property_read_u32(dev->of_node, "clock-frequency", &bus_speed);

    The result can be ignored now.

> -	if (ret < 0 && pdata && pdata->bus_speed)
> -		bus_speed = pdata->bus_speed;
>
> -	if (pdev->dev.of_node)
> -		priv->devtype = (long)of_match_device(rcar_i2c_dt_ids,
> -						      dev)->data;
> -	else
> -		priv->devtype = platform_get_device_id(pdev)->driver_data;
> +	priv->devtype = (long)of_match_device(rcar_i2c_dt_ids, dev)->data;
>
>   	ret = rcar_i2c_clock_calculate(priv, bus_speed, dev);
>   	if (ret < 0)
[...]

MBR, Sergei

