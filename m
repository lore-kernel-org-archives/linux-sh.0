From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 08:44:41 +0000
Subject: Re: [PATCH 03/13 v4][RFC] arm64: renesas: Add initial r8a7795 SoC support
Message-Id: <878u9oyfkg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87si7wyhde.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87si7wyhde.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Shimoda-san

> > Sent: Thursday, August 06, 2015 5:06 PM
> > 
> > From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > 
> > Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v3 -> v4
> > 
> >  - use simple-bus topology
> >  - remove IRDA from clock.h
> >  - RCAR_GEN3_CLK_xxxx -> RCAR_R8A7795_CLK_xxxx
> 
> I prefer R8A7795_CLK_xxxx than RCAR_R8A7795_CLK_xxxx :)
> After that, it is the same style as previous SoCs like R8A7790_CLK_xxxx.

Wow ! good catch !
I will fix up it in v5
