From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 24 Mar 2015 17:13:53 +0000
Subject: Re: [PATCH 2/3] pinctrl: sh-pfc: r8a7778: Add bias (pull-up) pinconf support
Message-Id: <CAMuHMdVYp0Df4z4T-bK6ocg47Zrpncza-yMWXCozWAAHWbwncA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426854638-9187-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1426854638-9187-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,


On Fri, Mar 20, 2015 at 1:30 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c

> @@ -2905,8 +2912,218 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
>         { },
>  };
>
> +#define PUPR0  0x100
> +#define PUPR1  0x104
> +#define PUPR2  0x108
> +#define PUPR3  0x10c
> +#define PUPR4  0x110
> +#define PUPR5  0x114
> +
> +static const struct {
> +       u16 reg;

This value is in the range 0x100..0x114.

> +       u16 bit;

This value is in the range 0..31, so you need only 5 bits.

To save memory, what about using bit fields instead?

        u16 reg : 11;
        u16 bit : 5;

By switching to PUPRx indices instead of register offsets, it can even
fit in a u8, as we have only 6 PUPRx registers.
R-Car V2H has more than 8 PUPRx registers, we there we're stuck with
at least 16 bits per pin.

> +} pullups[] = {
> +       [RCAR_GP_PIN(0,  6)] = { PUPR0,  0 },   /* A0 */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
