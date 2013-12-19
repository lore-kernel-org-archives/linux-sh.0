From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 19 Dec 2013 04:58:22 +0000
Subject: Re: [PATCH 2/5] arm: shmobile: r8a7790: Add SATA clock
Message-Id: <87wqj1v3md.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine, Laurent
Cc Magnus

> > > On Wednesday 18 December 2013 16:44:17 Valentine Barshak wrote:
> > >> This adds SATA 0/1 clock support. External 100MHz SATA 0/1
> > >> 
> > >> reference clock is supposed to be applied to the following pins:
> > >>    CICREFP0_SATA/CICREFP1_SATA;
> > >>    CICREFN0_SATA/CICREFN1_SATA.
> > >> 
> > >> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> > >> ---
(snip)
> > If understand the h/w manual correctly, the external clock is connected
> > directly to the SATA module:
> > 
> > "Pin Name: CICREFP0_SATA CICREFN0_SATA CICREFP1_SATA CICREFN1_SATA
> > Description: Reference clock input to the PLL circuit in the Serial-ATA
> > module (differential input). Apply a 100-MHz clock."
> 
> That's my understanding as well, but I suspect that clock to be the PHY clock 
> only, not the SATA module functional clock.

I have same opinion with Laurent.

But I'm not sure detail of module parent clock,
since R-Car series datasheet seems doesn't have module clock relationship map.
# SH-mobile series had "Clock Assignment to Modules" in datasheet.

I will ask this to HW people, but maybe p_clk is fine here.

If you need to control CICREFN1_SATAx clocks,
it should be defined as CLKDEV_ICK_ID() and use clk_xx() function

But, hmm...
Current some clock-r8a7790 MSTP clocks have strange parent...


Best regards
---
Kuninori Morimoto
