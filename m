From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 06 Aug 2015 23:59:22 +0000
Subject: Re: [PATCH 02/13 v4][RFC] arm64: renesas: Add new Renesas R-Car Gen3 SoC Kconfig
Message-Id: <87egjgdl9v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87twscyhev.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87twscyhev.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> > Initial version of device tree for Renesas R-Car Gen3 SoC Kconfig
> >
> > Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > v3 -> v4
> >
> >  - no change
> >
> >  arch/arm64/Kconfig | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 318175f..bd1257e 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> 
> arch/arm64/Kconfig.platforms?

As I mentioned on cover letter, I have limited HW access,
no time to try new environment. 
It is based on renesas-devel-20150803-v4.2-rc5
