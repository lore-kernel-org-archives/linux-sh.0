From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Nov 2013 00:05:42 +0000
Subject: Re: [PATCH v2 2/3] ARM: shmobile: r8a7779: Wait for status on selected MSTP clocks
Message-Id: <87txf1ny5s.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384357973-27365-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384357973-27365-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Laurent, Simon

> > > From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > 
> > > When enabling some of the module clocks by clearing stop bits in the
> > > MSTP control registers, the CPG requires waiting for the status
> > > registers to signal that the clocks have started. Failure to do so will
> > > result in returning from the clk_enable() call with the clock
> > > potentially still disabled, leading to various race conditions and
> > > difficult to debug errors.
> > > 
> > > Enable status wait for all the r8a7779 MSTP clocks that report their
> > > status.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/mach-shmobile/clock-r8a7779.c | 26 ++++++++++----------------
> > >  1 file changed, 10 insertions(+), 16 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c
> > > b/arch/arm/mach-shmobile/clock-r8a7779.c index b7ce0e7..1955738 100644
> > > --- a/arch/arm/mach-shmobile/clock-r8a7779.c
> > > +++ b/arch/arm/mach-shmobile/clock-r8a7779.c
> > > @@ -52,12 +52,6 @@
> > > 
> > >  #define MSTPCR1		IOMEM(0xffc80034)
> > >  #define MSTPCR3		IOMEM(0xffc8003c)
> > >  #define MSTPSR1		IOMEM(0xffc80044)
> > > 
> > > -#define MSTPSR4		IOMEM(0xffc80048)
> > > -#define MSTPSR6		IOMEM(0xffc8004c)
> > > -#define MSTPCR4		IOMEM(0xffc80050)
> > > -#define MSTPCR5		IOMEM(0xffc80054)
> > > -#define MSTPCR6		IOMEM(0xffc80058)
> > > -#define MSTPCR7		IOMEM(0xffc80040)
> > 
> > Why do you remove these MSTPCRx in this patch ?
> > It is out-of this purpose
> 
> I've removed them as they're unused. This could be split to a separate patch 
> if preferred, I've just thought it would be overkill.

Yes, they are not used, but it doesn't have relationship to this patch.
(and, do we really need to remove these ?)

This is not super big deal,
but I was ordered many times not to do such things at other ML.

Let's follow the opinion of Simon. 

Best regards
---
Kuninori Morimoto
