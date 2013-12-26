From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Dec 2013 14:16:23 +0000
Subject: Re: [PATCH 2/5] arm: shmobile: r8a7790: Add SATA clock
Message-Id: <1690612.mAoDhgp57L@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Valentine,

On Tuesday 24 December 2013 01:24:14 Valentine wrote:
> On 12/19/2013 08:58 AM, Kuninori Morimoto wrote:
> > Hi Valentine, Laurent
> > Cc Magnus
> > 
> >>>> On Wednesday 18 December 2013 16:44:17 Valentine Barshak wrote:
> >>>>> This adds SATA 0/1 clock support. External 100MHz SATA 0/1
> >>>>> 
> >>>>> reference clock is supposed to be applied to the following pins:
> >>>>>     CICREFP0_SATA/CICREFP1_SATA;
> >>>>>     CICREFN0_SATA/CICREFN1_SATA.
> >>>>> 
> >>>>> Signed-off-by: Valentine Barshak
> >>>>> <valentine.barshak@cogentembedded.com>
> >>>>> ---
> > 
> > (snip)
> > 
> >>> If understand the h/w manual correctly, the external clock is connected
> >>> directly to the SATA module:
> >>> 
> >>> "Pin Name: CICREFP0_SATA CICREFN0_SATA CICREFP1_SATA CICREFN1_SATA
> >>> Description: Reference clock input to the PLL circuit in the Serial-ATA
> >>> module (differential input). Apply a 100-MHz clock."
> >> 
> >> That's my understanding as well, but I suspect that clock to be the PHY
> >> clock only, not the SATA module functional clock.
> > 
> > I have same opinion with Laurent.
> > 
> > But I'm not sure detail of module parent clock,
> > since R-Car series datasheet seems doesn't have module clock relationship
> > map. # SH-mobile series had "Clock Assignment to Modules" in datasheet.
> > 
> > I will ask this to HW people, but maybe p_clk is fine here.
> 
> Morimoto-san,
> is there any news?
> 
> It says "PLL in the Serial-ATA module" not the "Serial-ATA phy", but without
> the clock map it's hard to say.
>
> > If you need to control CICREFN1_SATAx clocks,
> > it should be defined as CLKDEV_ICK_ID() and use clk_xx() function
> 
> If MSTP814/MSTP815 controls the internal SATA clocks, then I'm not sure how
> to control the external CICREF[PN][01]_SATA ones.

If my guess is correct the CICREF[PN][01]_SATA clock doesn't need to be 
controlled.

> > But, hmm...
> > Current some clock-r8a7790 MSTP clocks have strange parent...

-- 
Regards,

Laurent Pinchart

