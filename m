From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 12:13:17 +0000
Subject: Re: [PATCH] phy: rcar-gen3-usb2: Add R-Car Gen3 USB2 PHY driver
Message-Id: <CAMuHMdXshUCWs=sbVA8pBmsdOm3GwkWJ5NN8YCDXYX_6W5QFAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440052098-4840-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1440052098-4840-1-git-send-email-yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: kishon-l0cyMroinI0@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Shimoda-san,

On Thu, Aug 20, 2015 at 8:28 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> This patch adds support for R-Car generation 3 USB2 PHY driver.
> This SoC has 3 EHCI/OHCI channels, and the channel 0 is shared
> with the HSUSB (USB2.0 peripheral) device.
>
> So, the purpose of this driver is:
>  1) initializes some registers of SoC specific to use the
>     {ehci,ohci}-platform driver.
>
>  2) detects id pin to select host or peripheral on the channel 0.
>
> For now, this driver only supports 1) above.

Thanks for your patch!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt
> @@ -0,0 +1,37 @@
> +* Renesas R-Car generation 3 USB 2.0 PHY
> +
> +This file provides information on what the device node for the R-Car generation
> +3 USB 2.0 PHY contains.
> +
> +Required properties:
> +- compatible: "renesas,usb2-phy-r8a7795" if the device is a part of R8A7795 SoC.

"an R8A7795 SoC".

> +- reg: offset and length of the USB2.0 host register block.
> +- reg-names: must be "usb2".
> +- clocks: clock phandle and specifier pair.

"pair(s)."

> +- clock-names: string, clock input name, must be "usb2", and optional "hsusb".

names

> +- #phy-cells: see phy-bindings.txt in the same directory, must be <0>.
> +
> +Optional proparies:

properties

> +To use a USB channel which EHCI/OHCI and HSUSB are combined, the device tree

s/which/where/

> +node should set HSUSB proparies to reg and reg-names proparies:

properties (x2)

> +- reg: offset and length of the HSUSB register block.
> +- reg-names: must be "hsusb".
> +
> +Example (R-Car H3):
> +
> +       usb-phy@ee080200 {
> +               compatible = "renesas,usb2-phy-r8a7795";
> +               reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
> +               reg-names = "usb2", "hsusb";
> +               clocks = <&mstp7_clks R8A7795_CLK_EHCI0>,
> +                        <&mstp7_clks R8A7795_CLK_HSUSB>;

If you ever want to enable Runtime PM, do you want the first MSTP clock to be
managed automatically?
What about the second optional clock?

> +               clock-names = "usb2", "hsusb";
> +       };
> +
> +       usb-phy@ee0a0200 {
> +               compatible = "renesas,usb2-phy-r8a7795";
> +               reg = <0 0xee0a0200 0 0x6ff>;
> +               reg-names = "usb2";
> +               clocks = <&mstp7_clks R8A7795_CLK_EHCI0>;
> +               clock-names = "usb2";
> +       };

> --- /dev/null
> +++ b/drivers/phy/phy-rcar-gen3-usb2.c

> +static int rcar_gen3_phy_usb2_init(struct phy *p)
> +{
> +       struct rcar_gen3_phy_usb2_channel *channel = phy_get_drvdata(p);
> +       unsigned long flags;
> +       void __iomem *usb2_base = channel->usb2.base;
> +       void __iomem *hsusb_base = channel->hsusb.base;
> +       u32 tmp;
> +
> +       /* Since ops->init() is called once, this driver enables both clocks */
> +       clk_prepare_enable(channel->usb2.clk);
> +       clk_prepare_enable(channel->hsusb.clk);

So this driver manages its clock(s) itself, and doesn't support Runtime PM.

> +static int rcar_gen3_phy_usb2_exit(struct phy *p)
> +{
> +       struct rcar_gen3_phy_usb2_channel *channel = phy_get_drvdata(p);
> +
> +       writel(0, channel->usb2.base + USB2_INT_ENABLE);
> +
> +       clk_disable_unprepare(channel->hsusb.clk);
> +       clk_disable_unprepare(channel->usb2.clk);
> +
> +       return 0;
> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
