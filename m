From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 02 Oct 2015 07:59:42 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: r8a7794: add VIN pin groups
Message-Id: <CAMuHMdXkjdwbqOd9XHMsTdKD6qkUyEDeJ1L5HmwkADUDP2jXXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<2918225.gAfMYgxlCz@wasted.cogentembedded.com>
In-Reply-To: <2918225.gAfMYgxlCz@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Sergei,

On Fri, Aug 28, 2015 at 10:46 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> +/* - VIN1 ----------------------------------------------------------------- */
> +static const unsigned int vin1_data8_pins[] = {
> +       RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
> +       RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
> +       RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17),
> +       RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
> +};
> +static const unsigned int vin1_data8_mux[] = {
> +       VI1_DATA0_MARK, VI1_DATA1_MARK,
> +       VI1_DATA2_MARK, VI1_DATA3_MARK,
> +       VI1_DATA4_MARK, VI1_DATA5_MARK,
> +       VI1_DATA6_MARK, VI1_DATA7_MARK,
> +};
> +static const unsigned int vin1_data12_pins[] = {
> +       RCAR_GP_PIN(5, 12), RCAR_GP_PIN(5, 13),
> +       RCAR_GP_PIN(5, 14), RCAR_GP_PIN(5, 15),
> +       RCAR_GP_PIN(5, 16), RCAR_GP_PIN(5, 17),
> +       RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19),
> +       RCAR_GP_PIN(1, 10), RCAR_GP_PIN(1, 11),
> +       RCAR_GP_PIN(1, 12), RCAR_GP_PIN(1, 13),
> +};
> +static const unsigned int vin1_data12_mux[] = {
> +       VI1_DATA0_MARK, VI1_DATA1_MARK,
> +       VI1_DATA2_MARK, VI1_DATA3_MARK,
> +       VI1_DATA4_MARK, VI1_DATA5_MARK,
> +       VI1_DATA6_MARK, VI1_DATA7_MARK,
> +       VI1_DATA8_MARK, VI1_DATA9_MARK,
> +       VI1_DATA10_MARK, VI1_DATA11_MARK,
> +};

Given Laurent asked to slightly rework this series, perhaps
vin1_data*[] can use a union to decrease memory usage, too?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
