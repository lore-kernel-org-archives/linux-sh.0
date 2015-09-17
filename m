From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Sep 2015 08:15:29 +0000
Subject: Re: [PATCH 3/3] pinctrl: sh-pfc: r8a7795: add Audio SSI pin support
Message-Id: <CAMuHMdXyrf1QADoV9kwUK4cLaL0925kP4YetXH2bXPJi0D=BwA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvx4qkzo.wl%kuninori.morimoto.gx@renesas.com>
	<87wpvp7kq5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wpvp7kq5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Laurent <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Thu, Sep 17, 2015 at 6:10 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> @@ -1775,6 +1775,183 @@ static const unsigned int scif5_clk_mux[] = {
>         SCK5_MARK,
>  };
>
> +/* - SSI -------------------------------------------------------------------- */
> +static const unsigned int ssi0_data_pins[] = {
> +       /* SDATA */
> +       RCAR_GP_PIN(6, 2),
> +};
> +static const unsigned int ssi0_data_mux[] = {
> +       SSI_SDATA0_MARK,
> +};
> +static const unsigned int ssi01239_ctrl_pins[] = {
> +       /* SCK, WS */
> +       RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 1),
> +};
> +static const unsigned int ssi01239_ctrl_mux[] = {
> +       SSI_SCK0129_MARK, SSI_WS0129_MARK,
> +};
> +static const unsigned int ssi1_a_data_pins[] = {

Shouldn't this be "ssi1_data_a_pins" for consistency with other devices?
Likewise for the other added entries.

The rest looks OK, so if you fix these, you can add my
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> +       /* SDATA */
> +       RCAR_GP_PIN(6, 3),
> +};
> +static const unsigned int ssi1_a_data_mux[] = {
> +       SSI_SDATA1_A_MARK,
> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
