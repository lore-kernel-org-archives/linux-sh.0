From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Oct 2015 11:32:17 +0000
Subject: Re: [PATCH] i2c: rcar: call rcar_i2c_init() after pm_runtime_get_sync()
Message-Id: <CAMuHMdXnMFh5umv=wJdvrcMip+DOn8rYP_3eUTufFw4q2Sr8Jw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oafiyq8y.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oafiyq8y.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linux I2C <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Oct 29, 2015 at 10:37 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> rcar_i2c_init() initializes I2C device, but it should be called
> *after* pm_runtime_get_sync(). Otherwise it outputs very hi speed
> clock. This patch solved this issue,
> This patch also removes pointless rcar_i2c_init()
> from rcar_i2c_probe()
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  drivers/i2c/busses/i2c-rcar.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 616433d..edbfefc 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -474,6 +474,8 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
>
>         pm_runtime_get_sync(dev);
>
> +       rcar_i2c_init(priv);

Hence now it's done again for every transfer?

What about moving it just before the call to i2c_add_numbered_adapter(),
and wrapping it inside pm_runtime_get_sync(dev)/pm_runtime_put()?

Wolfram, what do you think?

> +
>         ret = rcar_i2c_bus_barrier(priv);
>         if (ret < 0)
>                 goto out;
> @@ -612,8 +614,6 @@ static int rcar_i2c_probe(struct platform_device *pdev)
>         if (IS_ERR(priv->io))
>                 return PTR_ERR(priv->io);
>
> -       rcar_i2c_init(priv);
> -
>         irq = platform_get_irq(pdev, 0);
>         init_waitqueue_head(&priv->wait);

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
