From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Nov 2013 07:42:02 +0000
Subject: Re: [PATCH 0/16] ARM: shmobile: SDHI support for r8a7790
Message-Id: <878uwm6tru.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<87txffxofc.wl%kuninori.morimoto.gx@renesas.com>
	<87a9h6o2gi.wl%kuninori.morimoto.gx@renesas.com>
	<20131118072111.GG27935@verge.net.au>
In-Reply-To: <20131118072111.GG27935@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Simon

> > These are v2 of SDHI support for r8a7790.
> > 
> > Kuninori Morimoto (2):
> >       ARM: shmobile: lager: add gpio/fixed regulator for SDHI
> >       ARM: shmobile: lager: add SDHI0/2 support
> > 
> >  arch/arm/mach-shmobile/board-lager.c |  149 +++++++++++++++++++++++++++++++++-
> 
> Hi Morimoto-san,
> 
> I assume that these two patches depend on at least
> some of the first 14 patches. Is that correct?

Compile itself is not depend on first 14 patches,
but, it doesn't work correctly without these patches.
So, yes, it depend on 14 patches.

Best regards
---
Kuninori Morimoto
