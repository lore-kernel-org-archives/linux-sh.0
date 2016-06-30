From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 30 Jun 2016 14:47:37 +0000
Subject: Re: [PATCH v4 22/22] sh: Renesas RTS7751R2Dplus (a,k.a R2Dplus) DeviceTree
Message-Id: <87ziq2d986.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467207667-15768-1-git-send-email-ysato@users.sourceforge.jp>
	<1467207667-15768-23-git-send-email-ysato@users.sourceforge.jp>
	<c13b9615-6bfd-1e16-ffb8-f2c7b7a817b8@cogentembedded.com>
In-Reply-To: <c13b9615-6bfd-1e16-ffb8-f2c7b7a817b8@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 29 Jun 2016 23:16:52 +0900,
Sergei Shtylyov wrote:
> 
> On 06/29/2016 04:41 PM, Yoshinori Sato wrote:
> 
> > Changes v4
> > - split patch
> > 
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> 
> [...]
> 
> > diff --git a/arch/sh/boot/dts/r2dplus.dts b/arch/sh/boot/dts/r2dplus.dts
> > new file mode 100644
> > index 0000000..a1a0745
> > --- /dev/null
> > +++ b/arch/sh/boot/dts/r2dplus.dts
> > @@ -0,0 +1,83 @@
> > +/dts-v1/;
> > +
> > +#include "sh7751.dtsi"
> > +
> > +/ {
> > +	model = "Renesas RTS7751R2D+";
> 
>    The ePAPR standard says:
> 
> The recommended format is: “manufacturer,model”, where manufacturer
> is a string describing the name of the manufacturer (such as a stock
> ticker symbol), and model specifies the model number.

OK.
I lookd ePAPR standard.

> > +	compatible = "renesas,r2dplus";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	interrupt-parent = <&shintc>;
> > +	chosen {
> > +		stdout-path = &sci1;
> > +		bootargs = "console=ttySC1,115200";
> > +	};
> > +	aliases {
> > +		serial1 = &sci1;
> > +	};
> > +
> > +	memory@0c000000 {
> > +		device_type = "memory";
> > +		reg = <0x0c000000 0x4000000>;
> > +	};
> 
>    Need empty line here...
>
> > +	fpgaintc: fpga@a4000000 {
> > +		compatible = "renesas,r2dplus-intc";
> > +		#interrupt-cells = <1>;
> > +		interrupt-controller;
> > +		reg = <0xa4000000 0x40>;
> > +		interrupt-map=<0 &shintc evt2irq(0x200)>,
> > +		              <1 &shintc evt2irq(0x220)>,
> > +		              <2 &shintc evt2irq(0x240)>,
> > +			      <3 &shintc evt2irq(0x260)>,
> > +		              <4 &shintc evt2irq(0x280)>,
> > +			      <5 &shintc evt2irq(0x2a0)>,
> > +		              <6 &shintc evt2irq(0x2c0)>,
> > +			      <7 &shintc evt2irq(0x2e0)>,
> > +		              <8 &shintc evt2irq(0x300)>,
> > +			      <9 &shintc evt2irq(0x320)>,
> > +		              <10 &shintc evt2irq(0x340)>,
> > +			      <11 &shintc evt2irq(0x360)>,
> > +		              <12 &shintc evt2irq(0x380)>,
> > +			      <13 &shintc evt2irq(0x3a0)>,
> > +		              <14 &shintc evt2irq(0x3c0)>;
> > +	};
> > +	pata: pata@b4001000 {
> 
>    This node should be named "ide@..." to comply with ePAPR.

OK.
Thanks.

> MBR, Sergei
> 

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
