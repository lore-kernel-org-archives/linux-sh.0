From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Sep 2015 12:20:20 +0000
Subject: Re: [PATCH 1/3] pinctrl: sh-pfc: Remove hardcoded IRQ numbers
Message-Id: <CAMuHMdURjNwgkBWWBgrkwEQfcmhm_LZmbGgPxakjUJNfyuM06w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440797837-25516-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1440797837-25516-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Aug 28, 2015 at 11:37 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Now that all ARM-based Renesas SoCs use multiplatform kernels only the
> hardcoded IRQ numbers can be dropped as they're dynamically allocated.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Thanks for your patch!

> ---
>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c | 116 +++++++++++++++++------------------
>  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  68 ++++++++++----------
>  drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  68 ++++++++++----------
>  drivers/pinctrl/sh-pfc/sh_pfc.h      |   7 +--
>  4 files changed, 123 insertions(+), 136 deletions(-)

> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
> @@ -100,13 +100,8 @@ struct pinmux_irq {

Can you please also remove the "int irq" field that fell out of the diff
context above, as it's now always zero?

Should gpio_pin_to_irq() now always return "pfc->irqs[i]", i.e. can we remove
the check for "pfc->num_irqs", or is there a good reason to keep the check
and return 0?

>         const short *gpios;
>  };
>
> -#ifdef CONFIG_ARCH_MULTIPLATFORM
> -#define PINMUX_IRQ(irq_nr, ids...)                        \
> +#define PINMUX_IRQ(ids...)                        \
>         { .gpios = (const short []) { ids, -1 } }
> -#else
> -#define PINMUX_IRQ(irq_nr, ids...)                        \
> -       { .irq = irq_nr, .gpios = (const short []) { ids, -1 } }
> -#endif

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
