From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 09:49:28 +0000
Subject: Re: [PATCH 2/3] pinctrl: sh-pfc: r8a7795: add Audio clock pin support
Message-Id: <87eghx5qhg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mvx4qkzo.wl%kuninori.morimoto.gx@renesas.com>
	<87y4g57kqn.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdX7O+iA1B3kKm9LPgOTkYrJHPM8kTPEk1jdLGwhLr-exA@mail.gmail.com>
In-Reply-To: <CAMuHMdX7O+iA1B3kKm9LPgOTkYrJHPM8kTPEk1jdLGwhLr-exA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Laurent <laurent.pinchart@ideasonboard.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>


Hi Geert

> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
> 
> > +/* - AUDIO CLOCK ------------------------------------------------------------ */
> 
> > +static const unsigned int audio_clkout_c_mux[] = {
> > +       AUDIO_CLKOUT_C_MARK,
> > +};
> 
> You missed audio_clkout_d at GP5_21.

Thanks
will add in v2
