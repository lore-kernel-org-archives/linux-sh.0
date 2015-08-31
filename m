From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 31 Aug 2015 00:04:06 +0000
Subject: Re: [PATCH 2/2][RFC] pinctrl: sh-pfc: r8a7795: add SCIFx support
Message-Id: <87egik493d.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
	<87a8tbdamb.wl%kuninori.morimoto.gx@renesas.com>
	<CANqRtoQsH_6mTr774_sT4hD=9rd2rUPWMTY52Ezwox3ZiTb0gQ@mail.gmail.com>
In-Reply-To: <CANqRtoQsH_6mTr774_sT4hD=9rd2rUPWMTY52Ezwox3ZiTb0gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon <horms@verge.net.au>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Magnus

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >
> > This patch adds SCIF0/1/2/3/4/5
> >
> > This patch is including Geert's SCIF support patch
> >
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 446 +++++++++++++++++++++++++++++++----
> >  1 file changed, 405 insertions(+), 41 deletions(-)
> 
> Thanks a lot for your efforts breaking out this!
> 
> Just to double check, are all SCIF patches from this series rolled
> into this patch?
> [PATCH 0/5] pinctrl: sh-pfc: r8a7795: (H)SCIF Updates

Not all. this includes SCIF part only. "H"SCIF can be next patch.
But all SCIF part are inlcuded I believe

Best regards
---
Kuninori Morimoto
