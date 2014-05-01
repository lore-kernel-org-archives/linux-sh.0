From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 01 May 2014 13:26:15 +0000
Subject: Re: [RFC] i2c: sh_mobile: WIP! Fix clock calculation for newer SoCs
Message-Id: <CAMuHMdUVCP-dwJ-HMD1xHb9qR_qm-n0YTpYVq9w37DvD=E=X=w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398945555-12928-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398945555-12928-1-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

Hi Wolfram,

On Thu, May 1, 2014 at 1:59 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> +static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
> +       { .compatible = "renesas,rmobile-iic", .data = (void *)1 },
> +       { .compatible = "renesas,iic-r8a7790", .data = (void *)2 },
> +       { .compatible = "renesas,iic-r8a7791", .data = (void *)2 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, sh_mobile_i2c_dt_ids);

> +               const struct of_device_id *match;
> +
> +               match = of_match_device(sh_mobile_i2c_dt_ids, &dev->dev);
> +               pd->clks_per_count = match->data;

Missing cast "(int)match->data"?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
