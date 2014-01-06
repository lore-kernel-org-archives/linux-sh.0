From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 06 Jan 2014 01:25:16 +0000
Subject: Re: [PATCH 2/5] arm: shmobile: r8a7790: Add SATA clock
Message-Id: <87zjn9kikm.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

Happy new year, and sorry for my late response

> >>> I will ask this to HW people, but maybe p_clk is fine here.
> >>
> >> Morimoto-san,
> >> is there any news?
> >>
> >> It says "PLL in the Serial-ATA module" not the "Serial-ATA phy", but without
> >> the clock map it's hard to say.
> >>
> >>> If you need to control CICREFN1_SATAx clocks,
> >>> it should be defined as CLKDEV_ICK_ID() and use clk_xx() function
> >>
> >> If MSTP814/MSTP815 controls the internal SATA clocks, then I'm not sure how
> >> to control the external CICREF[PN][01]_SATA ones.
> >
> > If my guess is correct the CICREF[PN][01]_SATA clock doesn't need to be
> > controlled.
> 
> I agree. Still the question remains whether it's OK to use p_clk here.

According to HW guys, parent clock of SATA module is zs_clk.

Best regards
---
Kuninori Morimoto
