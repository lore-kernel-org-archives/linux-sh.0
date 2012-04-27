From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Apr 2012 08:09:11 +0000
Subject: Re: [PATCH 1/8] ARM: mach-shmobile: clock-r8a7740: add USB clock
Message-Id: <87r4v9a95o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87aa21fqg0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87aa21fqg0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> > R8A7740 USB needs many clocks for workaround,
> > and it has confusing name "usb24s" and "usb24".
> > This "usb24s" will be used by other clocks.
> > 
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> >  arch/arm/mach-shmobile/clock-r8a7740.c |  118 +++++++++++++++++++++++++++++++-
> >  1 files changed, 116 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
> > index 99c4d74..30535f4 100644
> > --- a/arch/arm/mach-shmobile/clock-r8a7740.c
> > +++ b/arch/arm/mach-shmobile/clock-r8a7740.c
> > +static unsigned long usb24s_recalc(struct clk *clk)
> > +{
> > +	return clk->parent->rate;
> > +};
> > +
> You don't need this, just use followparent_recalc() directly.

Thanks.
I will fix up it.

Best regards
---
Kuninori Morimoto
