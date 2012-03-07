From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 07 Mar 2012 00:11:12 +0000
Subject: Re: AP4EVB board couldn't boot on latest linus/master
Message-Id: <87399lp8x1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87booawe57.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87booawe57.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Rafael

Thank you for your help !!

> > > I could skip this issue by removing CONFIG_FRAMEBUFFER_CONSOLE from my
> > > .config
> > > 
> > > ap4evb lcdc_info settings are less than mackerel.
> > > (note, ap4evb_init adds more settings for it)
> > > Does it missing something ?
> > 
> > Could you please enable CONFIG_LOCKDEP_SUPPORT support in the kernel to catch 
> > AB-BA deadlocks ?

Thank you !!
But it still dead-lock. Hmm...
I disable CONFIG_FRAMEBUFFER_CONSOLE for current work around.

> > > what is required for ap4evb ?
> > 
> > I had a similar issue on Mackerel, and I've worked around it by disabling 
> > CONFIG_SH_TIMER_TMU.
> 
> Please try the sh-sci patch posted here:
> http://marc.info/?l=linux-sh&m3073065924863&w=4

Thank you !!
It solved AP4 boot issue.

Thank you very much your help again.

Best regards
---
Kuninori Morimoto
