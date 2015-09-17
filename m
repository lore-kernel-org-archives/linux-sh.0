From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 09:50:49 +0000
Subject: Re: [PATCH 3/3] pinctrl: sh-pfc: r8a7795: add Audio SSI pin support
Message-Id: <87a8sl5qf9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvx4qkzo.wl%kuninori.morimoto.gx@renesas.com>
	<87wpvp7kq5.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXyrf1QADoV9kwUK4cLaL0925kP4YetXH2bXPJi0D=BwA@mail.gmail.com>
In-Reply-To: <CAMuHMdXyrf1QADoV9kwUK4cLaL0925kP4YetXH2bXPJi0D=BwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Laurent <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>


Hi Geert

> > +/* - SSI -------------------------------------------------------------------- */
> > +static const unsigned int ssi0_data_pins[] = {
> > +       /* SDATA */
> > +       RCAR_GP_PIN(6, 2),
> > +};
> > +static const unsigned int ssi0_data_mux[] = {
> > +       SSI_SDATA0_MARK,
> > +};
> > +static const unsigned int ssi01239_ctrl_pins[] = {
> > +       /* SCK, WS */
> > +       RCAR_GP_PIN(6, 0), RCAR_GP_PIN(6, 1),
> > +};
> > +static const unsigned int ssi01239_ctrl_mux[] = {
> > +       SSI_SCK0129_MARK, SSI_WS0129_MARK,
> > +};
> > +static const unsigned int ssi1_a_data_pins[] = {
> 
> Shouldn't this be "ssi1_data_a_pins" for consistency with other devices?
> Likewise for the other added entries.
> 
> The rest looks OK, so if you fix these, you can add my
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks
Will fix it in v2, and will add your Reviewed-by
