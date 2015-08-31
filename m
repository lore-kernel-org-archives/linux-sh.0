From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 31 Aug 2015 10:53:06 +0000
Subject: Re: [PATCH 2/2][RFC] pinctrl: sh-pfc: r8a7795: add SCIFx support
Message-Id: <1833045.8SRSLSWJG0@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com> <2861323.SHGHLuLyfk@avalon> <87fv304965.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fv304965.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Monday 31 August 2015 00:06:21 Kuninori Morimoto wrote:
> Hi Laurent
> 
> >> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >> 
> >> This patch adds SCIF0/1/2/3/4/5
> >> 
> >> This patch is including Geert's SCIF support patch
> >> 
> >> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > I won't have time to review this in details. If you and Geert have double-
> > checked the data I'll trust you that they're correct.
> 
> Thanks. One question
> 
> In very pseudo code, PFC driver needs...
>  1) FN list
>  2) MARK list
>  3) register <-> FN mapping
>  4) pin <-> FN mapping
>  5) DT interface <-> pin mapping
> 
> Previous version had
>  - almost all (not all) 1),  2) list
>  - some 3), 4), 5) mapping
> 
>  -> it needs missing list, and new mapping for new feature
> 
> This version is
>  - [1/2]: frame only, minimum list, minimum mapping
>  - [2/2]: SCIF necessary list/mapping
> 
>  -> it needs all necessary FN/MARK list, and necessary mapping for new
> feature
> 
> Good point of new version is it picks up necessary list/mapping/setting.
> Bad  point of new version is it is very PITA to create/check pin.
> 
> which style do you like ?
>  1) It has all 1) 2) 3) in initial patch
>     we will add 4) 5) for new feature
> 
>  2) It has minimum list/mapping only in initial patch
>     we will add necessary 1) 2) 3) 4) 5) for new feature
> 
> I don't know which one is good style, but it is good timing to decide it,
> since it can be base style.

The first option is easier in the sense that we'll need to go through the pain 
of creating all the FN and MARK lists as register to FN mappings only once. 
The downside is that there's no chance anyone will review it given how big the 
patch is. If we go for the second option there's a higher chance that the 
lists and mappings will be reviewed, but I'm wondering whether it's really 
worth it, given the drawback that anyone wanting to add support for a new IP 
core will need to go dive in the PFC driver and understand all the internals. 
I would thus prefer the first option from a pure selfish way if I don't have 
to create the initial PFC patch :-) Please feel free to disagree.

-- 
Regards,

Laurent Pinchart

