From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Mon, 06 Jul 2015 11:26:59 +0000
Subject: RE: [PATCH v2 0/2] ARM: shmobile: r8a7791: add for USB-DMAC
Message-Id: <SG2PR06MB09196339D04A9FE2A8D4A6DAD8930@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent-san,

Thank you for your comment! And, I'm very sorry for the delayed response because I had completely passed over this email...

> Sent: Friday, June 19, 2015 6:39 PM
> 
> Hello Shimoda-san,
> 
> (Dropping the DT maintainers from CC and adding Linus Walleij, Kishon Vijay
> Abraham and Felipe Balbi)
> 
> On Tuesday 07 April 2015 16:53:49 Yoshihiro Shimoda wrote:
< snip >
> 
> I've successfully tested USB-DMAC integration (congratulations for the good
> work !), but ran into several issues that I wanted to discuss with you.

That's great!

> Both issues are I believe related to the fact that the HSUSB and EHCI/OHCI
> controllers share the same PHY and the same pins.
> 
> When both drivers are loaded, the following messages are printed to the kernel
> log.
> 
> [    8.917418] sh-pfc e6060000.pfc: pin GP_7_23 already requested by
> ee090000.pci; cannot claim for e6590000.usb
> [    8.927594] sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
> [    8.933913] sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from
> group usb0  on device sh-pfc
> [    8.943990] renesas_usbhs e6590000.usb: Error applying setting, reverse
> things back
> 
> This is caused by the pci0 and hsusb DT nodes referencing the same default pin
> configuration node. There should be no issue in practice as the pin
> configuration is already applied through the other device, but I'd still like
> to find a fix to avoid the error message.

I also would like to avoid the error message.
Fortunately, if I used the patches that Phil-san made, the error message disappeared on Koelsch.

http://www.spinics.net/lists/linux-usb/msg126747.html
http://www.spinics.net/lists/linux-usb/msg126738.html
http://www.spinics.net/lists/linux-usb/msg126740.html

> The other issue is that the renesas_hsusb and ehci drivers compete to control
> the same PHY. The phy-rcar-gen2 driver creates two Linux PHYs for each
> physical PHY (called channel in the driver) to ensure that each driver can get
> its own PHY instance. Arbitration is then handled in the PHY .init() handler
> which returns -EBUSY if another driver already controls the channel. The error
> value is propagated up to usbhsc_power_ctrl() where it's then ignored. This
> doesn't look like a good way to handled the shared PHY, but I'm not familiar
> enough with the PHY subsystem to know how to fix it.

After I applied Phil-san's patches, if I did "unbind/bind" the renesas_hsusb or
the ehci driver, I could change the PHY setting on Koelsch.
However, in case of Lagar, since it doesn't have OTG chip, it still has this issue.
So, I will investigate some related drivers to fix this issue somehow.

Best regards,
Yoshihiro Shimoda

> >  arch/arm/boot/dts/r8a7791.dtsi | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> 
> --
> Regards,
> 
> Laurent Pinchart
