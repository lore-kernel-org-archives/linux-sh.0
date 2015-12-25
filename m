From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Dec 2015 11:49:47 +0000
Subject: RE: [PATCH 2/6] arm64: renesas: r8a7795: add USB2.0 Host (EHCI/OHCI) device nodes
Message-Id: <SG2PR06MB0919054A0FAA0F762DFEA781D8F80@SG2PR06MB0919.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451037839-572-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1451037839-572-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <567D2A2E.1080705@cogentembedded.com>
In-Reply-To: <567D2A2E.1080705@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, "horms@verge.net.au" <horms@verge.net.au>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "pawel.moll@arm.com" <pawel.moll@arm.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>, "galak@codeaurora.org" <galak@codeaurora.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@vger.kernel.org" <linux-arm-kernel@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hello,

> From: Sergei Shtylyov
> Sent: Friday, December 25, 2015 8:36 PM
> 
> Hello.
> 
> On 12/25/2015 1:03 PM, Yoshihiro Shimoda wrote:
> 
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > ---
> >   arch/arm64/boot/dts/renesas/r8a7795.dtsi | 66 ++++++++++++++++++++++++++++++++
> >   1 file changed, 66 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index 89393ea..e26073c 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -809,5 +809,71 @@
> >   			#phy-cells = <0>;
> >   			status = "disabled";
> >   		};
> > +
> > +		ehci0: usb@ee080100 {
> > +			compatible = "renesas,ehci-r8a7795", "generic-ehci";
> > +			reg = <0 0xee080100 0 0xff>;
> 
>     s/0xff/0x100? This is size, not limit.

Thank you for the point! I will fix all nodes about this.

Best regards,
Yoshihiro Shimoda

