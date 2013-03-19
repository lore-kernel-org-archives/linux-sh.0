From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Mar 2013 11:25:24 +0000
Subject: Re: [PATCH v2 4/8] ARM: shmobile: move GIC and I2C devices from sh73a0 common .dtsi to reference
Message-Id: <Pine.LNX.4.64.1303191211070.11768@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-5-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-5-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi

Let me return briefly to this 1 month-old thread just to make sure we're 
happy about the current state of kzm9g DT:

On Wed, 13 Feb 2013, Simon Horman wrote:

> On Wed, Feb 13, 2013 at 10:59:41AM +0100, Guennadi Liakhovetski wrote:
> > Hi Simon
> > 
> > On Wed, 13 Feb 2013, Simon Horman wrote:
> > 
> > > On Fri, Feb 08, 2013 at 07:38:28PM +0100, Guennadi Liakhovetski wrote:
> > > > In "legacy" mode, when all devices are initialised by the board .c file,
> > > > there is no need to install the GIC and all I2C devices from the device
> > > > tree too. Move them to the reference implementation, that fully relies upon
> > > > DT.
> > > 
> > > The motivation for placing the code in sh73a0.dtsi was so that
> > > it would be available to the non-reference board code if/when it
> > > moves over to using DT.
> > > 
> > > I'm happy to switch things around if its preferred to keep
> > > the dts small.
> > 
> > As I said, I do think it is good to keep devices in a central .dtsi, 
> > included by all, but they should be disabled by default, using the 
> > 'status="disabled"' property, and only enabled on boards, that actually 
> > use those devices.
> 
> Ok, that makes sense to me. Do you think you could update this patch
> accordingly?

Here's my understanding of the DT situation on kzm9g:

1. legacy board-kzm9g.c + sh73a0-kzm9g.dts + sh73a0.dtsi: board's 
struct machine_desc defines a .dt_compat field, this shall allow to 
include this kzm9g support in multiarch kernels, using DT. sh73a0.dtsi 
includes nodes for all I2C devices and the GIC interrupt controller, but 
of_platform_populate() is never called, so, those nodes are unused.

2. DT mode board-kzm9g-reference.c + sh73a0-kzm9g-reference.dts + 
sh73a0-reference.dtsi + sh73a0.dtsi: .dt_compat is obviously used similar 
to the above, but with a different match string, of_platform_populate() is 
called, so i2c and gic nodes are used and respective devices are 
instantiated.

So, in principle all works as expected, but it just seems a bit unclean 
and confusing to me, that in "legacy" mode [1] above a bunch of devices 
are provided in DT, listed in /proc/device-tree/ but remain unused. using 
'status="disabled"' as proposed above could be done, but having to add 
nodes like

&gic = {
	status = "okay";
};

&i2c0...

on all boards, that do use DT, seems a bit clumsy to me.

Thanks
Guennadi

> > I'm just not sure what's the difference between the two 
> > DT-"patching" syntaxes - using '&' and not using it.
> 
> Unfortunately I'm not sure either.
> 
> > Thanks
> > Guennadi
> > 
> > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > ---
> > > > 
> > > > I think, this is a fix and should be applied.
> > > > 
> > > >  arch/arm/boot/dts/sh73a0-reference.dtsi |   69 +++++++++++++++++++++++++++++++
> > > >  arch/arm/boot/dts/sh73a0.dtsi           |   69 -------------------------------
> > > >  2 files changed, 69 insertions(+), 69 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/boot/dts/sh73a0-reference.dtsi b/arch/arm/boot/dts/sh73a0-reference.dtsi
> > > > index d4bb012..457afc7 100644
> > > > --- a/arch/arm/boot/dts/sh73a0-reference.dtsi
> > > > +++ b/arch/arm/boot/dts/sh73a0-reference.dtsi
> > > > @@ -21,4 +21,73 @@
> > > >  			      0 141 0x4>;
> > > >  		reg-io-width = <4>;
> > > >  	};
> > > > +
> > > > +	gic: interrupt-controller@f0001000 {
> > > > +		compatible = "arm,cortex-a9-gic";
> > > > +		#interrupt-cells = <3>;
> > > > +		#address-cells = <1>;
> > > > +		interrupt-controller;
> > > > +		reg = <0xf0001000 0x1000>,
> > > > +		      <0xf0000100 0x100>;
> > > > +	};
> > > > +
> > > > +	i2c0: i2c@0xe6820000 {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +		compatible = "renesas,rmobile-iic";
> > > > +		reg = <0xe6820000 0x425>;
> > > > +		interrupt-parent = <&gic>;
> > > > +		interrupts = <0 167 0x4
> > > > +			      0 168 0x4
> > > > +			      0 169 0x4
> > > > +			      0 170 0x4>;
> > > > +	};
> > > > +
> > > > +	i2c1: i2c@0xe6822000 {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +		compatible = "renesas,rmobile-iic";
> > > > +		reg = <0xe6822000 0x425>;
> > > > +		interrupt-parent = <&gic>;
> > > > +		interrupts = <0 51 0x4
> > > > +			      0 52 0x4
> > > > +			      0 53 0x4
> > > > +			      0 54 0x4>;
> > > > +	};
> > > > +
> > > > +	i2c2: i2c@0xe6824000 {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +		compatible = "renesas,rmobile-iic";
> > > > +		reg = <0xe6824000 0x425>;
> > > > +		interrupt-parent = <&gic>;
> > > > +		interrupts = <0 171 0x4
> > > > +			      0 172 0x4
> > > > +			      0 173 0x4
> > > > +			      0 174 0x4>;
> > > > +	};
> > > > +
> > > > +	i2c3: i2c@0xe6826000 {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +		compatible = "renesas,rmobile-iic";
> > > > +		reg = <0xe6826000 0x425>;
> > > > +		interrupt-parent = <&gic>;
> > > > +		interrupts = <0 183 0x4
> > > > +			      0 184 0x4
> > > > +			      0 185 0x4
> > > > +			      0 186 0x4>;
> > > > +	};
> > > > +
> > > > +	i2c4: i2c@0xe6828000 {
> > > > +		#address-cells = <1>;
> > > > +		#size-cells = <0>;
> > > > +		compatible = "renesas,rmobile-iic";
> > > > +		reg = <0xe6828000 0x425>;
> > > > +		interrupt-parent = <&gic>;
> > > > +		interrupts = <0 187 0x4
> > > > +			      0 188 0x4
> > > > +			      0 189 0x4
> > > > +			      0 190 0x4>;
> > > > +	};
> > > >  };
> > > > diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
> > > > index 8a59465..6837b3f 100644
> > > > --- a/arch/arm/boot/dts/sh73a0.dtsi
> > > > +++ b/arch/arm/boot/dts/sh73a0.dtsi
> > > > @@ -28,73 +28,4 @@
> > > >  			reg = <1>;
> > > >  		};
> > > >  	};
> > > > -
> > > > -	gic: interrupt-controller@f0001000 {
> > > > -		compatible = "arm,cortex-a9-gic";
> > > > -		#interrupt-cells = <3>;
> > > > -		#address-cells = <1>;
> > > > -		interrupt-controller;
> > > > -		reg = <0xf0001000 0x1000>,
> > > > -		      <0xf0000100 0x100>;
> > > > -	};
> > > > -
> > > > -	i2c0: i2c@0xe6820000 {
> > > > -		#address-cells = <1>;
> > > > -		#size-cells = <0>;
> > > > -		compatible = "renesas,rmobile-iic";
> > > > -		reg = <0xe6820000 0x425>;
> > > > -		interrupt-parent = <&gic>;
> > > > -		interrupts = <0 167 0x4
> > > > -			      0 168 0x4
> > > > -			      0 169 0x4
> > > > -			      0 170 0x4>;
> > > > -	};
> > > > -
> > > > -	i2c1: i2c@0xe6822000 {
> > > > -		#address-cells = <1>;
> > > > -		#size-cells = <0>;
> > > > -		compatible = "renesas,rmobile-iic";
> > > > -		reg = <0xe6822000 0x425>;
> > > > -		interrupt-parent = <&gic>;
> > > > -		interrupts = <0 51 0x4
> > > > -			      0 52 0x4
> > > > -			      0 53 0x4
> > > > -			      0 54 0x4>;
> > > > -	};
> > > > -
> > > > -	i2c2: i2c@0xe6824000 {
> > > > -		#address-cells = <1>;
> > > > -		#size-cells = <0>;
> > > > -		compatible = "renesas,rmobile-iic";
> > > > -		reg = <0xe6824000 0x425>;
> > > > -		interrupt-parent = <&gic>;
> > > > -		interrupts = <0 171 0x4
> > > > -			      0 172 0x4
> > > > -			      0 173 0x4
> > > > -			      0 174 0x4>;
> > > > -	};
> > > > -
> > > > -	i2c3: i2c@0xe6826000 {
> > > > -		#address-cells = <1>;
> > > > -		#size-cells = <0>;
> > > > -		compatible = "renesas,rmobile-iic";
> > > > -		reg = <0xe6826000 0x425>;
> > > > -		interrupt-parent = <&gic>;
> > > > -		interrupts = <0 183 0x4
> > > > -			      0 184 0x4
> > > > -			      0 185 0x4
> > > > -			      0 186 0x4>;
> > > > -	};
> > > > -
> > > > -	i2c4: i2c@0xe6828000 {
> > > > -		#address-cells = <1>;
> > > > -		#size-cells = <0>;
> > > > -		compatible = "renesas,rmobile-iic";
> > > > -		reg = <0xe6828000 0x425>;
> > > > -		interrupt-parent = <&gic>;
> > > > -		interrupts = <0 187 0x4
> > > > -			      0 188 0x4
> > > > -			      0 189 0x4
> > > > -			      0 190 0x4>;
> > > > -	};
> > > >  };
> > > > -- 
> > > > 1.7.2.5
> > > > 
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > > 
> > > 
> > 
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
