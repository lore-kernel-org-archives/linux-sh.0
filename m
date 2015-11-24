From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Nov 2015 09:09:48 +0000
Subject: Re: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <87610rydit.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com>
	<8737wdfcd0.wl%kuninori.morimoto.gx@renesas.com>
	<87ziyldrxk.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVWG=0fm3_8xSCiSrOYdEwsR_UeD+AL7e+CXO1TGKNzhQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVWG=0fm3_8xSCiSrOYdEwsR_UeD+AL7e+CXO1TGKNzhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>


Hi Geert

Thank you for your review

> > +#define PORT_GP_CFG_8(bank, fn, sfx, cfg)                                              \
> > +       PORT_GP_CFG_4(bank, fn, sfx, cfg),                                              \
> >         PORT_GP_CFG_1(bank, 4,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 5,  fn, sfx, cfg),   \
> > -       PORT_GP_CFG_1(bank, 6,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 7,  fn, sfx, cfg),   \
> > +       PORT_GP_CFG_1(bank, 6,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 7,  fn, sfx, cfg)
> > +#define PORT_GP_8(bank, fn, sfx)       PORT_GP_CFG_8(bank, fn, sfx, 0)
> > +
> > +#define PORT_GP_CFG_9(bank, fn, sfx, cfg)                                              \
> > +       PORT_GP_CFG_8(bank, fn, sfx, cfg),                                              \
> > +       PORT_GP_CFG_1(bank, 8,  fn, sfx, cfg)
> > +#define PORT_GP_9(bank, fn, sfx)       PORT_GP_CFG_9(bank, fn, sfx, 0)
> > +
> > +#define PORT_GP_CFG_12(bank, fn, sfx, cfg)                                             \
> > +       PORT_GP_CFG_8(bank, fn, sfx, cfg),                                              \
> >         PORT_GP_CFG_1(bank, 8,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 9,  fn, sfx, cfg),   \
> > -       PORT_GP_CFG_1(bank, 10, fn, sfx, cfg), PORT_GP_CFG_1(bank, 11, fn, sfx, cfg),   \
> > -       PORT_GP_CFG_1(bank, 12, fn, sfx, cfg), PORT_GP_CFG_1(bank, 13, fn, sfx, cfg),   \
> > -       PORT_GP_CFG_1(bank, 14, fn, sfx, cfg), PORT_GP_CFG_1(bank, 15, fn, sfx, cfg),   \
> > -       PORT_GP_CFG_1(bank, 16, fn, sfx, cfg), PORT_GP_CFG_1(bank, 17, fn, sfx, cfg),   \
> > +       PORT_GP_CFG_1(bank, 10, fn, sfx, cfg), PORT_GP_CFG_1(bank, 11, fn, sfx, cfg)
> > +#define PORT_GP_12(bank, fn, sfx)      PORT_GP_CFG_12(bank, fn, sfx, 0)
> 
> The *_8 and *_12 definitions don't seem to be used (except for defining
> later variants in the series)?

I think _12 is used in pfc-sh7734.c ?
I added _8 because pfc-r8a7779.c is using _9.
I don't like odd number definition.


