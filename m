From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 03 Oct 2013 05:03:25 +0000
Subject: Re: [PATCH 2/6] arm: shmobile: lager: Add USBHS support
Message-Id: <87a9irndye.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus, Valentine

> >> +static int usbhs_power_on(void __iomem *base)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = ioread32(base + USBHS_UGCTRL_REG) & ~USBHS_UGCTRL_PLLRESET;
> >> +       iowrite32(val, base + USBHS_UGCTRL_REG);
> >> +
> >> +       val = ioread16(base + USBHS_LPSTS_REG) | USBHS_LPSTS_SUSPM;
> >> +       iowrite16(val, base + USBHS_LPSTS_REG);
> >> +
> >> +       /*
> >> +        * The manual suggests to check PLL lock status in the UGSTS
> >> +        * register before enabling connect, however, it is always 0.
> >> +        */
> >> +       val = ioread32(base + USBHS_UGCTRL_REG) | USBHS_UGCTRL_CONNECT;
> >> +       iowrite32(val, base + USBHS_UGCTRL_REG);
> >> +       return 0;
> >> +}
> >> +
> >> +static int usbhs_power_off(void __iomem *base)
> >> +{
> >> +       u32 val;
> >> +
> >> +       val = ioread32(base + USBHS_UGCTRL_REG) & ~USBHS_UGCTRL_CONNECT;
> >> +       iowrite32(val, base + USBHS_UGCTRL_REG);
> >> +
> >> +       val = ioread16(base + USBHS_LPSTS_REG) & ~USBHS_LPSTS_SUSPM;
> >> +       iowrite16(val, base + USBHS_LPSTS_REG);
> >> +
> >> +       val = ioread32(base + USBHS_UGCTRL_REG) | USBHS_UGCTRL_PLLRESET;
> >> +       iowrite32(val, base + USBHS_UGCTRL_REG);
> >> +       return 0;
> >> +}
> >> +
> >> +static int usbhs_power_ctrl(struct platform_device *pdev,
> >> +                               void __iomem *base, int enable)
> >> +{
> >> +       if (enable)
> >> +               return usbhs_power_on(base);
> >> +
> >> +       return usbhs_power_off(base);
> >> +}
> >
> > ... to here it looks like this is USBHS support code for the r8a7790
> > SoC, not the lager board.
> >
> > Have you considered putting these SoC specific bits into drivers/usb/...
> >
> 
> I'll try to add device id table and move it to renesas_usbhs driver.
> Hope the "renesas_usbhs_rcar_h2" device name is not too long.

Unfortunately, I can't agree this idea.
Renesas USB sometimes has this kind of "SoC specific special initialization",
not only r8a7790, but other SoC have it too, and, these doesn't have compatibility.
Some SoC need special GPIO setting, some SoC need special clock setting etc...

This is the main reason why renesas_usbhs driver has callback functions.

Best regards
---
Kuninori Morimoto
