From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 08 Dec 2015 12:12:12 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: r8a7791: add EtherAVB pin groups
Message-Id: <CAMuHMdX5d90NS0btT28yAUD3iNSDdV_GLPOwDMAt9PcTvU4dMA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <13219129.kD4pZSmcAP@wasted.cogentembedded.com>
	<1512650.VUqGxiAB2A@wasted.cogentembedded.com>
In-Reply-To: <1512650.VUqGxiAB2A@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Sergei,

On Wed, Dec 2, 2015 at 9:11 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add the EtherAVB pin groups to the R8A7791 PFC driver.

Thanks for your patch!

> +static const unsigned int avb_mii_pins[] = {
> +       RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 20),
> +       RCAR_GP_PIN(5, 21),
> +
> +       RCAR_GP_PIN(5, 0), RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
> +       RCAR_GP_PIN(5, 3),
> +
> +       RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 10),
> +       RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 28),
> +       RCAR_GP_PIN(5, 29),
> +};
> +static const unsigned int avb_mii_mux[] = {
> +       AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
> +       AVB_TXD3_MARK,
> +
> +       AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
> +       AVB_RXD3_MARK,
> +
> +       AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
> +       AVB_CRS_MARK, AVB_TX_EN_MARK, AVB_TX_CLK_MARK,
> +       AVB_COL_MARK,
> +};

The MII pin list include RX_ER, but not TX_ER...

> +static const unsigned int avb_gmii_pins[] = {
> +       RCAR_GP_PIN(5, 18), RCAR_GP_PIN(5, 19), RCAR_GP_PIN(5, 20),
> +       RCAR_GP_PIN(5, 21), RCAR_GP_PIN(5, 22), RCAR_GP_PIN(5, 23),
> +       RCAR_GP_PIN(5, 24), RCAR_GP_PIN(5, 25),
> +
> +       RCAR_GP_PIN(5, 0), RCAR_GP_PIN(5, 1), RCAR_GP_PIN(5, 2),
> +       RCAR_GP_PIN(5, 3), RCAR_GP_PIN(5, 4), RCAR_GP_PIN(5, 5),
> +       RCAR_GP_PIN(5, 6), RCAR_GP_PIN(5, 7),
> +
> +       RCAR_GP_PIN(5, 8), RCAR_GP_PIN(5, 13), RCAR_GP_PIN(5, 10),
> +       RCAR_GP_PIN(5, 15), RCAR_GP_PIN(5, 30), RCAR_GP_PIN(5, 17),
> +       RCAR_GP_PIN(5, 26), RCAR_GP_PIN(5, 27), RCAR_GP_PIN(5, 28),
> +       RCAR_GP_PIN(5, 29),
> +};
> +static const unsigned int avb_gmii_mux[] = {
> +       AVB_TXD0_MARK, AVB_TXD1_MARK, AVB_TXD2_MARK,
> +       AVB_TXD3_MARK, AVB_TXD4_MARK, AVB_TXD5_MARK,
> +       AVB_TXD6_MARK, AVB_TXD7_MARK,
> +
> +       AVB_RXD0_MARK, AVB_RXD1_MARK, AVB_RXD2_MARK,
> +       AVB_RXD3_MARK, AVB_RXD4_MARK, AVB_RXD5_MARK,
> +       AVB_RXD6_MARK, AVB_RXD7_MARK,
> +
> +       AVB_RX_ER_MARK, AVB_RX_CLK_MARK, AVB_RX_DV_MARK,
> +       AVB_CRS_MARK, AVB_GTX_CLK_MARK, AVB_GTXREFCLK_MARK,
> +       AVB_TX_EN_MARK, AVB_TX_ER_MARK, AVB_TX_CLK_MARK,
> +       AVB_COL_MARK,
> +};

... while the GMII pin list includes both RX_ER and TX_ER. Is that correct?
Should it be the other way around?

Section "45A.3.13.1 MII Frame Transmission/Reception Timing" of the R-Car Gen2
datasheet shows timing diagrams for both AVB_TX_ER and AVB_RX_ER, so I'd expect
both pins to be needed for MII.

Unfortunately Section "45A.3.13.2 GMII Frame Reception Timing" shows timing
diagrams for receive only (thus involving AVB_RX_ER only), so I'm not sure the
AVB_TX_ER pin is actually needed for GMII.

I don't have schematics for any R-Car Gen2 board that has AVB support, so I
can't check myself how the MII/GMII is really wired.

Note that this also applies to the existing AVB pinmux data in pfc-r8a7790.c.

Can you please check/clarify? I'm not an Ethernet PHY expert.

Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
