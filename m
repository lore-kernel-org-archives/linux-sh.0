From: Simon Horman <horms@verge.net.au>
Date: Fri, 08 Jan 2016 01:37:13 +0000
Subject: Re: [PATCH v2 1/6] arm64: renesas: r8a7795: add usb2_phy device nodes
Message-Id: <20160108013713.GA9600@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1451044361-5896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1451044361-5896-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdWXFVRgMAg90Xxa2N_81ckPdyzJtge8SPUghaSK0EcGOw@mail.gmail.com>
 <SG2PR06MB09198CEABDD4B74DD95B5250D8F50@SG2PR06MB0919.apcprd06.prod.outlook.com>
In-Reply-To: <SG2PR06MB09198CEABDD4B74DD95B5250D8F50@SG2PR06MB0919.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@vger.kernel.org" <linux-arm-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Jan 07, 2016 at 01:47:47AM +0000, Yoshihiro Shimoda wrote:
> Hi Geert-san,
> 
> Thank you for your comment and sorry for the delayed response.
> 
> > From: Geert Uytterhoeven
> > Sent: Monday, January 04, 2016 9:42 PM
> > 
> > On Fri, Dec 25, 2015 at 12:52 PM, Yoshihiro Shimoda
> > <yoshihiro.shimoda.uh@renesas.com> wrote:
> > > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > > @@ -775,5 +775,39 @@
> > >                         clocks = <&cpg CPG_MOD 815>;
> > >                         status = "disabled";
> > >                 };
> > > +
> > > +               usb2_phy0: usb-phy@ee080200 {
> > > +                       compatible = "renesas,usb2-phy-r8a7795";
> > > +                       reg = <0 0xee080200 0 0x700>, <0 0xe6590100 0 0x100>;
> > > +                       reg-names = "usb2_host", "hsusb";
> > > +                       interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
> > 
> > Isn't 108 the EHCI0 interrupt?
> > Cfr. the other usb-phy nodes that don't have interrupts.
> 
> Yes, 108 is the EHCI0 interrupt.
> However, as the 73.5.1 Interrupt Signal List in the datasheet is described,
> this EHCI0 has also phy interrupt (the datasheet names "UCON").
> 
> > > +                       clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
> > > +                       clock-names = "usb2", "hsusb";
> > > +                       power-domains = <&cpg>;
> > 
> > This device has two modules clocks, but the CPG/MSSR driver only manages
> > the first modulo clock.
> > Who enables the second clock (HS-USB-IF)?
> 
> Oops! Thank you for the point.
> The second clock was enabled by a boot loader.
> If a boot loader doesn't enable this clock,
> a panic happens as the followings in probing timing of the renesas-hsusb driver:
> 
> renesas_usbhs e6590000.usb: transceiver found
> renesas_usbhs e6590000.usb: gadget probed
> Bad mode in Error handler detected, code 0xbf000002 -- SError
> CPU: 3 PID: 1 Comm: swapper/0 Not tainted 4.4.0-rc6+ #42
> Hardware name: Renesas Salvator-X board based on r8a7795 (DT)
> task: ffffffc031868000 ti: ffffffc031870000 task.ti: ffffffc031870000
> PC is at rcar_gen3_phy_usb2_init+0x38/0x114
> LR is at phy_init+0x60/0xcc
> 
> So, I will fix this issue somehow.
> Also, I would like to revert this patch set to avoid any troubles.
> Simon-san, would you revert this patch set?

Sure, I will drop the entire patchset.
