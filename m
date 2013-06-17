From: Simon Horman <horms@verge.net.au>
Date: Mon, 17 Jun 2013 02:20:16 +0000
Subject: Re: [PATCH v3 5/5] ARM: shmobile: lager: map HSCIF0/1 to unused pins
Message-Id: <20130617022015.GK15043@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370015825-29383-6-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1370015825-29383-6-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 14, 2013 at 06:51:38PM +0200, Laurent Pinchart wrote:
> Hi Ulrich ans Simon,
> 
> On Wednesday 12 June 2013 23:08:47 Simon Horman wrote:
> > On Fri, May 31, 2013 at 05:57:05PM +0200, Ulrich Hecht wrote:
> > > These pins are not actually connected on the board, but at least they
> > > don't conflict with anything else.
> 
> That's actually not true, the hscif0_data pins are used by the DU RGB output.
> 
> If the HSCIF0 and HSCIF1 are not wired on the board I don't think they should 
> be added to the pinctrl maps.
> 
> Simon, should we revert this patch now or later when I'll submit DU patches 
> for Lager ?

I will simply drop this patch for now.

I can pick it up again if you and Ulrich decide that is the best course of
action.

> > > Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
> > 
> > Thanks, I have queued this up in the pinmux branch.
> > 
> > > ---
> > > 
> > >  arch/arm/mach-shmobile/board-lager.c |    4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/arch/arm/mach-shmobile/board-lager.c
> > > b/arch/arm/mach-shmobile/board-lager.c index 1e99b17..d8bd237 100644
> > > --- a/arch/arm/mach-shmobile/board-lager.c
> > > +++ b/arch/arm/mach-shmobile/board-lager.c
> > > @@ -77,6 +77,10 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
> > > 
> > >  	/* SCIF1 (CN20: DEBUG SERIAL1) */
> > >  	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
> > >  	
> > >  				  "scif1_data", "scif1"),
> > > 
> > > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.8", "pfc-r8a7790",
> > > +				  "hscif0_data", "hscif0"),
> > > +	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.9", "pfc-r8a7790",
> > > +				  "hscif1_data_b", "hscif1"),
> > > 
> > >  };
> > >  
> > >  static void __init lager_add_standard_devices(void)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
