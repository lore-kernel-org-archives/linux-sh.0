From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Jul 2013 15:16:46 +0000
Subject: Re: [PATCH v2 2/2] ARM: shmobile: ape6evm-reference: add MMCIF and SDHI DT nodes
Message-Id: <Pine.LNX.4.64.1307301650550.25629@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1307231318070.19465@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1307231318070.19465@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

Thanks for your review.

On Tue, 30 Jul 2013, Laurent Pinchart wrote:

> Hi Simon and Guennadi,
> 
> On Tuesday 30 July 2013 11:23:06 Simon Horman wrote:
> > On Tue, Jul 23, 2013 at 01:19:14PM +0200, Guennadi Liakhovetski wrote:
> > > This patch adds MMCIF0, SDHI0 and SDHI1 DT nodes and a fixed voltage
> > > reglator for them to the ape6evm-reference platform.
> > 
> > Magnus or Laurent, could you please review this?
> 
> Sure.
> 
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > ---
> > > 
> > > v2: also add a regulator
> > > 
> > >  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |   51 ++++++++++++++++++
> > >  1 files changed, 51 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > > b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts index bbd09d8..74a2e1c
> > > 100644
> > > --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > > +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > > @@ -24,6 +24,14 @@
> > >  		reg = <0 0x40000000 0 0x40000000>;
> > >  	};
> > > 
> > > +	ape6evm_fixed_3v3: fixedregulator@0 {
> > > +		compatible = "regulator-fixed";
> > > +		regulator-name = "3V3";
> > > +		regulator-min-microvolt = <3300000>;
> > > +		regulator-max-microvolt = <3300000>;
> > > +		regulator-always-on;
> > > +	};
> > > +
> > >  	lbsc {
> > >  		compatible = "simple-bus";
> > >  		#address-cells = <1>;
> > > @@ -62,4 +70,47 @@
> > >  		renesas,groups = "scifa0_data";
> > >  		renesas,function = "scifa0";
> > >  	};
> > > +
> > > +	mmc0_pins: mmcif {
> > > +		renesas,groups = "mmc0_data8", "mmc0_ctrl";
> > > +		renesas,function = "mmc0";
> > > +	};
> > > +
> > > +	sdhi0_pins: sdhi0 {
> > > +		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
> > > +		renesas,function = "sdhi0";
> > > +	};
> > > +
> > > +	sdhi1_pins: sdhi1 {
> > > +		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
> > > +		renesas,function = "sdhi1";
> > > +	};
> > > +};
> > > +
> > > +&mmcif0 {
> > > +	vmmc-supply = <&ape6evm_fixed_3v3>;
> > > +	bus-width = <8>;
> > > +	non-removable;
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&mmc0_pins>;
> > > +	status = "okay";
> > > +};
> 
> According to the APE6EVM datasheet, the eMMC power supply is 2.8V, not 3.3V. 
> Could you please verify that ? I don't think the power supply can be GPIO-
> controlled by I might have overlooked something, could you please also verify 
> that ?
> 
> > > +&sdhi0 {
> > > +	vmmc-supply = <&ape6evm_fixed_3v3>;
> > > +	bus-width = <4>;
> > > +	toshiba,mmc-wrprotect-disable;
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&sdhi0_pins>;
> > > +	status = "okay";
> > > +};
> 
> SDHI0 seems to be powered by a GPIO-controller regulator (on port 76). Could 
> you please verify that and update the patch accordingly ?

Yes, you're right, there are multiple regulators on APE6EVM, that supply 
power to MMC and SD cards. But if you look at board-ape6evm.c it also only 
uses one "dummy" 3.3V regulator for all those interfaces. The reason is, 
that a proper complete power supply description for MMC0, SDHI0 and SDHI1 
should also include SDHI0 VccQ supply, implemented by a tps80032 
regulator, providing VCCQ_SDHI to the APE6 SoC. And this hasn't been done 
yet, because on the one hand we don't yet know for sure, whether APE6's 
VCCQ_SDHI can be switched on and off, and because OTOH the same tps80032 
is also providing a number of other voltages to the system, so, it should 
rather be described completely, which hasn't been done yet either.

But we can also implement only Vcc regulators for now, I'll post an RFC 
patch for that in a minute for the C-based ape6evm implementation. If 
accepted, I will do the same for ape6evm-reference.

Thanks
Guennadi

> > > +&sdhi1 {
> > > +	vmmc-supply = <&ape6evm_fixed_3v3>;
> > > +	bus-width = <4>;
> > > +	broken-cd;
> > > +	toshiba,mmc-wrprotect-disable;
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&sdhi1_pins>;
> > > +	status = "okay";
> > > 
> > >  };
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
