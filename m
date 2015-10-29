From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2015 19:38:29 +0000
Subject: Re: [PATCH] i2c: rcar: make sure clocks are on when doing hw init
Message-Id: <CAMuHMdUvgfs=sS3TN8BvBktjaZAaE21YJ06xah45p8NgDY8vkA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1446146356-26166-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi Wolfram,

On Thu, Oct 29, 2015 at 8:19 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks for your patch!

I suspect this bug was also the cause of the spurious failures of the R-Car
Gen2 regulator quirk code I experienced sometimes during the last few
days.

> ---
>  drivers/i2c/busses/i2c-rcar.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 616433d387cdb2..ef26e933b1e9cb 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -612,7 +612,10 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->io))
>                 return PTR_ERR(priv->io);
>
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);
>         rcar_i2c_init(priv);
> +       pm_runtime_put(dev);
>
>         irq = platform_get_irq(pdev, 0);
>         init_waitqueue_head(&priv->wait);
> @@ -634,7 +637,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>                 return ret;

pm_runtime_disable() in error path?

>         }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
