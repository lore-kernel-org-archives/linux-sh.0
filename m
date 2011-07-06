From: kuninori.morimoto.gx@renesas.com
Date: Wed, 06 Jul 2011 01:28:30 +0000
Subject: Re: [RFC][PATCH 1/8] sh: clock-sh7724: add CLKDEV_ICK_ID for cleanup
Message-Id: <87iprgjiyp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87tyb0jjge.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87tyb0jjge.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Thank you for your reply

> On Tue, Jul 05, 2011 at 06:17:55PM -0700, Kuninori Morimoto wrote:
> > diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
> > index 77bcef5..0891876 100644
> > --- a/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
> > +++ b/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
> > @@ -254,6 +254,7 @@ static struct clk mstp_clks[HWBLK_NR] = {
> >  
> >  #define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
> >  #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
> > +#define CLKDEV_ICK_ID(_cid, _did, _clk) { .con_id = _cid, .dev_id = _did, .clk = _clk }
> >  
> >  static struct clk_lookup lookups[] = {
> >  	/* main clocks */
> 
> Perhaps while we're at it, it would help to move these macros in to
> sh_clk.h.

OK.

Can I send incremental patch which name will be "move CLKDDEV_XXX_ID macro to sh_clk.h"
or v2 patch set ?

Best regards
---
Kuninori Morimoto
