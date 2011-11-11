From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Nov 2011 05:42:09 +0000
Subject: Re: Question about clk->usecount
Message-Id: <20111111054208.GF29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fwihj3x8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 03, 2011 at 09:30:12PM -0700, Kuninori Morimoto wrote:
> 
> Hi Paul
> 
> > > @@ -152,7 +159,12 @@ int __init sh_hwblk_clk_register(struct clk *clks, int nr)
> > >  			continue;
> > >  
> > >  		clkp->ops = &sh_hwblk_clk_ops;
> > > -		ret |= clk_register(clkp);
> > > +		ret = clk_register(clkp);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +
> > > +		if (hwblk_info)
> > > +			hwblk_info->hwblks[k].clk = clkp;
> > >  	}
> > >  
> > >  	return ret;
> > 
> > The error path handling here is a bit of an unusual case. clk_register()
> > failing on one clock is not necessarily an indicator that other clocks
> > can't be succesfully registered, so we're better off simply checking if
> > clk_register() succeeds and then stashing the clock pointer, rather than
> > bailing on the loop entirely.
> > 
> > The general idea seems to be heading in the right direction though.
> 
> Thank you for your comment.
> I understand it.
> 
> But I have 1 thing to worry about on this rough patch.
> it is clock parent.
> I'm not sure who/how control clock parent.
> 
> Because current pm_runtime_xxx() functions which was calling hwblk_enable/disable()
> (seems) didn't care its parent clock.
> but clk_enable/disable() care it.
> 
> if we used clk_enable/disable() instead of hwblk_enable/disable(),
> but some upper function is already caring clock parent,
> it will be double cared (from upper function / clk_enable/disable())
> But if upper function didn't care parent,
> clock parent will be out of PM control (?).
> I'm not sure.
> 
Incidentally I also seem to see some issues on SH7786 with the late clock
disabling and runtime PM built in, even though there really isn't any
specific runtime PM support for the platform. I expect we're somehow
getting in to a refcounting war somehow which is causing unexpected
disabling behaviour.

I'll see about getting runtime PM support properly enabled on SH7786 to
see if the issues persist, but for now I'm just leaving it turned off.
You may wish to see if that also helps in your case.
