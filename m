From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Wed, 01 Jul 2015 15:10:00 +0000
Subject: RE: [PATCH 3/3] arm: koelsch: make USB0 perform Host/Function switching
Message-Id: <SIXPR06MB0639898D241111BB3FD97160F5A80@SIXPR06MB0639.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434984151-27274-1-git-send-email-phil.edworthy@renesas.com>
 <1434984151-27274-4-git-send-email-phil.edworthy@renesas.com>
 <55884943.9080607@cogentembedded.com> <55884A9B.9030505@cogentembedded.com>
In-Reply-To: <55884A9B.9030505@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Kishon Vijay Abraham I <kishon@ti.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Sergei,

On 22 June 2015 18:49, Sergei wrote:
> Hello.
> 
> On 06/22/2015 08:43 PM, Sergei Shtylyov wrote:
> 
> >> Both USB Host (pci0) and Function (USBHS) drivers are enabled.
> >> The USB PHY driver determines which IP block should be connected
> >> based on vbus and id signals read via gpios.
> 
> >> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >> ---
> >>   arch/arm/boot/dts/r8a7791-koelsch.dts | 7 ++++---
> >>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> >> diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> b/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> index cffe33f..8f394be 100644
> >> --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> >> +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > [...]
> >> @@ -627,13 +626,15 @@
> >>
> >>   &hsusb {
> >>       status = "okay";
> >> -    pinctrl-0 = <&usb0_pins>;
> >>       pinctrl-names = "default";
> >> -    renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
> >>   };
> >>
> >>   &usbphy {
> >>       status = "okay";
> >> +    renesas,pwr = <&gpio2 4 GPIO_ACTIVE_HIGH>;
> >> +    renesas,id = <&gpio5 31 GPIO_ACTIVE_HIGH>;
> >> +    renesas,vbus = <&gpio7 24 GPIO_ACTIVE_HIGH>;
> >> +    renesas,vbus-pwr = <&gpio7 23 GPIO_ACTIVE_HIGH>;
> 
> >     The prop names should end with "-gpio" or even "-gpios", according to the
> > GPIO bindings.
> 
>     Oh, and you didn't document the props in the previous patch.
> 
Thanks for your comments, since I've not seen any other comments I'll fix
these and repost.

Phil
