From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 12 Jun 2014 16:23:59 +0000
Subject: RE: [PATCH v2 2/7] ARM: shmobile: r8a7790: Add default PCIe bus clock
Message-Id: <d1c120c2c2f54968bd2d7915cf310316@HKXPR06MB168.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1402484753-7471-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1402484753-7471-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On 12 June 2014 16:35, Laurent wrote:
> On Wednesday 11 June 2014 12:05:48 Phil Edworthy wrote:
> > This patch adds a default PCIe bus clock node.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v2:
> >  - Use a default PCIe bus clock in the device's dtsi
> >
> >  arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> b/arch/arm/boot/dts/r8a7790.dtsi
> > index 7eb882c..13b4e63 100644
> > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > @@ -487,6 +487,14 @@
> >  			clock-output-names = "extal";
> >  		};
> >
> > +		/* External PCIe clock - can be overridden by the board */
> > +		pcie_bus_clk: pcie_bus_clk {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <100000000>;
> > +			clock-output-names = "pcie_bus";
> 
> As the clock isn't present on all r8a7790 boards, how about making it disabled
> (status = "disabled") by default ?

Ah, right. I hadn't considered that the clock could also be disabled. Ok...

> > +		};
> > +
> >  		/*
> >  		 * The external audio clocks are configured as 0 Hz fixed
> frequency
> > clocks by * default. Boards that provide audio clocks should override them.

Thanks
Phil
