From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 03 Oct 2013 04:53:26 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <87bo37nef7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Valentine

> >> +static int usbhs_hardware_init(struct platform_device *pdev)
> >> +{
> >> +	struct usbhs_private *priv = usbhs_get_priv(pdev);
> >> +	struct clk *clk;
> >> +
> >> +	clk = clk_get(NULL, "hsusb");
> >> +	if (IS_ERR(clk))
> >> +		return -ENODEV;
> >
> > It is automatically enable/disabled by driver
> > if MSTP704 clock name was "renesas_usbhs".
> 
> The reason I did not bind usbhs clock to renesas_usbhs device is because
> the same clock is also used by the lager_add_usb_devices() function in 
> the next patches. We need that since the global USB settings that affect 
> USBHS/USBSS and PCI USB host channel sharing are done in the USBHS 
> UGCTRL2 register. So we need this clock even if the renesas_usbhs driver 
> is disabled. IIUC, biding it to "renesas_usbhs" device would make it 
> impossible to use the clock if renesas_usbhs device is not registered.

I understand your situation, but you can use renesas_usbhs binded clock anyway ?
As Laurent mentioned, pci-rcar-gen2 care about it in driver ?
Maybe callback function is nice solution in this situation ?
Like this

--- clock --------------
  CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
  CLKDEV_ICK_ID("hsusb", "pci-rcar-gen2", &mstp_clks[MSTP704]),

--- platform -----------
int rcar_pci_hw_init(struct platform_device *pdev)
{
        clk = clk_get("hsusb", pdev->dev);
        if (IS_ERR(clk))
                 return -EIO;

        clk_enable(clk);
        clk_put(clk);

        ...

        return 0;
}

--- driver ---
static int __init rcar_pci_probe(struct platform_device *pdev)
{
        ...
        if (info->hw_init)
             ret = info->hw_init(pdev);
        ...
}

Best regards
---
Kuninori Morimoto
