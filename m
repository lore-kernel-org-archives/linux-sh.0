From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 13 May 2015 09:27:36 +0000
Subject: Re: [PATCH 3/3 v5] mmc: sh_mmcif: calculate best clock with parent clock
Message-Id: <87k2wcespd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <873840a4ch.wl%kuninori.morimoto.gx@renesas.com>
	<87a8x9fck7.wl%kuninori.morimoto.gx@renesas.com>
	<87617xfchj.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdV5aVEqEkOi5sk4rB2NoqzWBp2NvtP=k4pXJ0JjNeKo1w@mail.gmail.com>
	<87mw18euww.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdXXQyvBBUGA022vh2B9wWcWusi6xxjJgmY6fPFxoV4Cfw@mail.gmail.com>
In-Reply-To: <CAMuHMdXXQyvBBUGA022vh2B9wWcWusi6xxjJgmY6fPFxoV4Cfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Laurent <laurent.pinchart@ideasonboard.com>, kobayashi <keita.kobayashi.ym@renesas.com>


Hi Geert

> > I'm still not understanding about this.
> > If we can specify SoC (via compatible), the clock frequency limitation
> > can be specified in same time.
> > Why do we need to have flexibility for it ?
> 
> It's better if you don't need to update the C source file for every new SoC,
> especially if you can use a standard MMC DT property instead.
> Still, you need it for clkdiv_map, right?

Hmm... many people tell me different opinion...
I understand your opinion, but I'm confusing about dilemma.

If we can get all these settings via DT, (maybe) we don't need to
update driver for every new SoC, yes.
But it works if "this is 100% completed driver/HW".

If we get settings from DT, but MMC IP was updated in the future,
then, we need to care about ABI compatibility for it.
And sometimes (anytime ?) Renesas IP is updated strangely.
In such case, keeping ABI compatibility, and adds new feature
will be super difficult.

I discussed about this topic before with one engineer,
and the final answer was
"updating C source file is easier than updating DT / ABI compatibility"

This is the big reason why I want to get settings from driver
as much as possible.
We need to update C source code for every new SoC,
and Yes this is PITA, but easier than keeping ABI compatibility.
And updating C source code for every new SoC can indicates
"someone is caring this driver" to user

Best regards
---
Kuninori Morimoto
