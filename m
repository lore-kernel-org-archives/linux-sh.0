From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 31 Aug 2015 00:06:21 +0000
Subject: Re: [PATCH 2/2][RFC] pinctrl: sh-pfc: r8a7795: add SCIFx support
Message-Id: <87fv304965.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
	<87a8tbdamb.wl%kuninori.morimoto.gx@renesas.com>
	<2861323.SHGHLuLyfk@avalon>
In-Reply-To: <2861323.SHGHLuLyfk@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Laurent

> > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > This patch adds SCIF0/1/2/3/4/5
> > 
> > This patch is including Geert's SCIF support patch
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> I won't have time to review this in details. If you and Geert have double-
> checked the data I'll trust you that they're correct.

Thanks. One question

In very pseudo code, PFC driver needs...
 1) FN list
 2) MARK list
 3) register <-> FN mapping
 4) pin <-> FN mapping
 5) DT interface <-> pin mapping

Previous version had 
 - almost all (not all) 1),  2) list
 - some 3), 4), 5) mapping

 -> it needs missing list, and new mapping for new feature

This version is
 - [1/2]: frame only, minimum list, minimum mapping
 - [2/2]: SCIF necessary list/mapping

 -> it needs all necessary FN/MARK list, and necessary mapping for new feature

Good point of new version is it picks up necessary list/mapping/setting.
Bad  point of new version is it is very PITA to create/check pin.

which style do you like ?
 1) It has all 1) 2) 3) in initial patch
    we will add 4) 5) for new feature

 2) It has minimum list/mapping only in initial patch
    we will add necessary 1) 2) 3) 4) 5) for new feature

I don't know which one is good style, but it is good timing to decide it,
since it can be base style.

