From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 15 Oct 2015 07:09:13 +0000
Subject: Re: [PATCH/RFC 2/6] boot-mode-reg: Add R-Car Gen2 driver
Message-Id: <CAMuHMdWtQ30WrbG89TKRfw7x0gU7UEQXJMvTrqc01h2Ui9L=9Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 15, 2015 at 8:59 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> --- /dev/null
> +++ b/drivers/misc/boot-mode-reg/rcar-gen2.c
> @@ -0,0 +1,61 @@
> +/*
> + * R-Car Gen2 Boot Mode Register Driver

> +#define MODEMR 0xe6160060

Shouldn't this come from DT?

> +static int __init rcar_gen2_read_mode_pins(void)
> +{
> +       void __iomem *modemr;
> +       int err = -ENOMEM;
> +       static u32 mode;
> +
> +       modemr = ioremap_nocache(MODEMR, 4);
> +       if (!modemr) {
> +               pr_err("failed to map boot mode register");
> +               goto err;
> +       }
> +       mode = ioread32(modemr);
> +       iounmap(modemr);
> +
> +       err = boot_mode_reg_set(mode);
> +err:
> +       if (err)
> +               pr_err("failed to initialise boot mode");
> +       return err;
> +}

> --- a/include/misc/boot-mode-reg.h
> +++ b/include/misc/boot-mode-reg.h
> @@ -21,4 +21,7 @@
>  int boot_mode_reg_get(u32 *mode);
>  int boot_mode_reg_set(u32 mode);
>
> +/* Allow explicit initialisation before initcalls */
> +int rcar_gen2_init_boot_mode(void);

When using explicit initialisation before initcalls, the second call will
trigger a new ioremap/ioread32/iounmap cycle.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
