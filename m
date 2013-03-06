From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 06 Mar 2013 08:32:08 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: clock-r8a7779: add DIV4 clock support
Message-Id: <877gllkjy3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87hakpkuyg.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus

> >> Regarding MD pins I believe r8a7779 has a MODEMR register where you
> >> can read the MD pin settings. How about r8a7778?
> >
> > Yeah, I found it.
> > But it is not needed,  becouse FRQMR showed the clcok division rate
> > for each clocks
> 
> Ok, does that include "clkz" too? On r8a7779 "clkz" and "clkzs" are
> not visible in FRQMR, but I believe they are needed for TWD support.
> Do you have any plan to include "smp_twd" clock support for the TWD
> timer driver?

Thank you for pointing it.

This patch doesn't support clkz, since it is not DIV4 clock on R-Car M1.
I will support it in additional patch.

Best regards
---
Kuninori Morimoto
