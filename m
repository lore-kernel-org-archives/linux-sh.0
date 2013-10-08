From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 10:00:33 +0000
Subject: Re: [PATCH 1/3] usb: phy: Add RCAR Gen2 USB phy
Message-Id: <87r4bww08y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> >  From my point of view, if you use clk_enable() on setup(),
> > then, it is easy to read if it has exit() or similar name function
> > which calls clk_disable()
> 
> Since in this case all is needed is to disable the clocks, I've decided 
> not to put it in a separate exit function. I'll add one for better 
> readability.

Thank you

> > Are these usecount++/usecount-- position correct ?
> 
> The idea was to disable the clocks here if the phy is not used by other 
> drivers (PCI USB host or USBSS), so that suspending the gadget would 
> disable USBHS clocks. However, this needs phy enabled before the 
> shutdown is called. I guess I'll drop the clock handling here and leave 
> it solely to init/shutdown callbacks.

Thank you

> >> +	clk = devm_clk_get(&pdev->dev, "usbhs");
> >> +	if (IS_ERR(clk)) {
> >> +		dev_err(&pdev->dev, "Can't get the clock\n");
> >> +		return PTR_ERR(clk);
> >> +	}
> >
> > This case (if you use usb_phy_rcar_gen2 driver),
> > you can use pm_runtime_xxx instead of clk_get/enable/disable()
> >
> 
> Yes, I could. The reason I did not is that I'm not sure that a phy 
> driver should use runtime PM, since it is actually mastered by other 
> drivers which are supposed to control its power via init/shutdown and 
> set_suspend callbacks. Thus, looks like the phy driver can't really 
> auto-suspend and doesn't really support runtime PM.
> 
> I think that handling clocks in the init/shutdown is a bit cleaner.
> It gives us more control over the phy power, where pm_runtime_xxx will 
> do nothing if CONFIG_PM_RUNTIME is disabled.

OK, it is reasonable for me

Best regards
---
Kuninori Morimoto
