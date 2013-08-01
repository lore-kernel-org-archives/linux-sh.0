From: Simon Horman <horms@verge.net.au>
Date: Thu, 01 Aug 2013 08:02:50 +0000
Subject: Re: [PATCH v6 2/3] ARM: shmobile: lager: enable Ether
Message-Id: <20130801080248.GG15265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375175361-23027-1-git-send-email-horms+renesas@verge.net.au>
 <1375175361-23027-3-git-send-email-horms+renesas@verge.net.au>
 <87d2px3lkr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d2px3lkr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Aug 01, 2013 at 12:40:56AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > @@ -114,6 +138,7 @@ static void __init lager_add_standard_devices(void)
> >  	r8a7790_pinmux_init();
> >  
> >  	r8a7790_add_standard_devices();
> > +
> >  	platform_device_register_data(&platform_bus, "leds-gpio", -1,
> >  				      &lager_leds_pdata,
> >  				      sizeof(lager_leds_pdata));
> >@@ -125,6 +150,11 @@ static void __init lager_add_standard_devices(void)
> 
> I guess above is not needed :)

Thanks, I will fix that.

> Except above
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks.
