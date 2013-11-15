From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Nov 2013 00:16:44 +0000
Subject: Re: [PATCH 11/17] mmc: SDHI: add SoC specific workaround via HW version
Message-Id: <87habeo6xp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<8761rvz37d.wl%kuninori.morimoto.gx@renesas.com>
	<871u2jz33t.wl%kuninori.morimoto.gx@renesas.com>
	<5284D846.60404@cogentembedded.com>
In-Reply-To: <5284D846.60404@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi

> > One of Renesas SDHI chip needs workaround to use it,
> > and, we can judge it based on chip version.
> > This patch adds very quick-hack workaround method,
> > since we still don't know how many chips
> > need workaround in the future.
> 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >   drivers/mmc/host/sh_mobile_sdhi.c |   11 +++++++++++
> >   include/linux/mmc/tmio.h          |    1 +
> >   2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > index f1e35a7..d241d86 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -33,6 +33,8 @@
> >
> >   #include "tmio_mmc.h"
> >
> > +#define EXT_ACC           0xe4
> > +
> 
>     Why not #define it in the tmio.h? It already contains SDHI specific 
> register, CTL_DMA_ENABLE...

I'm not sure which approach is correct.
I will follow Maintainer's decision

Best regards
---
Kuninori Morimoto
