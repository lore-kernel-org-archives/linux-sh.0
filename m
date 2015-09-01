From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 01 Sep 2015 00:04:33 +0000
Subject: Re: [PATCH 2/2][RFC] pinctrl: sh-pfc: r8a7795: add SCIFx support
Message-Id: <878u8rgg9m.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1y7daou.wl%kuninori.morimoto.gx@renesas.com>
	<2861323.SHGHLuLyfk@avalon>
	<87fv304965.wl%kuninori.morimoto.gx@renesas.com>
	<1833045.8SRSLSWJG0@avalon>
In-Reply-To: <1833045.8SRSLSWJG0@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>


Hi Laurent

> > which style do you like ?
> >  1) It has all 1) 2) 3) in initial patch
> >     we will add 4) 5) for new feature
> > 
> >  2) It has minimum list/mapping only in initial patch
> >     we will add necessary 1) 2) 3) 4) 5) for new feature
> > 
> > I don't know which one is good style, but it is good timing to decide it,
> > since it can be base style.
> 
> The first option is easier in the sense that we'll need to go through the pain 
> of creating all the FN and MARK lists as register to FN mappings only once. 
> The downside is that there's no chance anyone will review it given how big the 
> patch is. If we go for the second option there's a higher chance that the 
> lists and mappings will be reviewed, but I'm wondering whether it's really 
> worth it, given the drawback that anyone wanting to add support for a new IP 
> core will need to go dive in the PFC driver and understand all the internals. 
> I would thus prefer the first option from a pure selfish way if I don't have 
> to create the initial PFC patch :-) Please feel free to disagree.

Thanks. I reconsidered this, and yes, I have same opinion.
[1/2] patch will be larger in v2, but it will be good for future work.
Now, I'm fighting for "readable" [1/2] patch now :P
