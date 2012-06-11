From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jun 2012 10:05:50 +0000
Subject: Re: [PATCH 18/27] ARM: shmobile: armadillo800eva: enable camera
Message-Id: <87aa0ap3id.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wr3epkkt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wr3epkkt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> > +/* Camera */
> > +static struct clk *cam1_mclk; /* initialized on eva_clock_init() */
> > +static int mt9t111_power(struct device *dev, int mode)
> > +{
> > +	if (!cam1_mclk)
> > +		return -EINVAL;
> > +
> This isn't necessary, clk_enable/disable() can handle being passed NULL
> just fine. If you've gotten control of the GPIO then you can still do
> meaningful work regardless of whether you have acquired the clock or not.
> 
> > +	cam1_mclk = clk_get(NULL, "video1");
> > +	if (IS_ERR(cam1_mclk)) {
> > +		cam1_mclk = NULL;
> > +		goto clock_error;
> > +	}
> > +
> 
> On the other hand, I don't see why you don't do this in the ->power
> routine directly, where you already have a struct device passed in for
> you.
> 
> >  	/* armadillo 800 eva extal1 is 24MHz */
> >  	clk_set_rate(xtal1, 24000000);
> >  
> >  	/* usb24s use extal1 (= system) clock (= 24MHz) */
> >  	clk_set_parent(usb24s, system);
> >  
> > +	/* video1 (= CON1 camera) expect 24MHz */
> > +	clk_set_rate(cam1_mclk, clk_round_rate(cam1_mclk, 24000000));
> > +
> >  clock_error:
> >  	if (!IS_ERR(system))
> >  		clk_put(system);
> 
> This error path makes absolutely no sense. If you fail to get the camera
> clock for some reason you skip over xtal and usb24s initialization?
> Without the xtal rate propagation pretty much every other clock in the
> system is going to be broken.
> 
> This is a good indicator that this routine is getting too big and you
> need to start splitting things out in to smaller initialization
> subroutines that you can conditionalize.

I see.
Indeed this cam1_mclk was special.
But I can use ->power routine in v2
Thanks

Best regards
---
Kuninori Morimoto
