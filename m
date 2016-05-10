From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Tue, 10 May 2016 07:43:29 +0000
Subject: Re: [PATCH RESEND 10/12] sh: I/O DATA HDL-U (aka landisk) support dts
Message-Id: <87d1oupdcu.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1462079316-27771-1-git-send-email-ysato@users.sourceforge.jp>
	<1462079316-27771-11-git-send-email-ysato@users.sourceforge.jp>
	<20160504032757.GP21636@brightrain.aerifal.cx>
In-Reply-To: <20160504032757.GP21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 04 May 2016 12:27:57 +0900,
Rich Felker wrote:
> 
> On Sun, May 01, 2016 at 02:08:34PM +0900, Yoshinori Sato wrote:
> > Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> > ---
> >  arch/sh/boot/dts/landisk.dts | 150 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 150 insertions(+)
> >  create mode 100644 arch/sh/boot/dts/landisk.dts
> > 
> > diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
> > new file mode 100644
> > index 0000000..a994d19
> > --- /dev/null
> > +++ b/arch/sh/boot/dts/landisk.dts
> > @@ -0,0 +1,150 @@
> > +#include <dt-bindings/interrupt-controller/sh_intc.h>
> > +
> > +/dts-v1/;
> > +/ {
> > +	model = "I/O DATA HDL-U";
> > +	compatible = "iodata,hdl-u";
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	interrupt-parent = <&shintc>;
> > +	chosen {
> > +		stdout-path = &sci1;
> > +		bootargs = "console=ttySC1,115200";
> > +	};
> > +	aliases {
> > +		serial0 = &sci0;
> > +		serial1 = &sci1;
> > +	};
> > +
> > +	oclk: oscillator {
> > +                #clock-cells = <0>;
> > +                compatible = "fixed-clock";
> > +                clock-frequency = <22222222>;
> > +        };
> > +        pllclk: pllclk {
> > +                compatible = "renesas,sh7750-pll-clock";
> > +                clocks = <&oclk>;
> > +                #clock-cells = <0>;
> > +		renesas,mult = <12>;
> > +                reg = <0xffc00000 2>, <0xffc00008 4>;
> 
> You have inconsistent mixes of tabs and spaces here and in several
> other places.

OK.

> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		cpu@0 {
> > +		      compatible = "renesas,sh4", "renesas,sh";
> > +		      clock-frequency = <266666666>;
> > +		};
> > +	};
> 
> Do you have in mind a scenario where the plain "renesas,sh"
> fallback-compatible tag makes sense? Linux (or any kernel or baremetal
> app) can't treat all sh as the same because the trap mechanism is
> different for sh1/2 and sh3/4. Declaring that it's sh3-compatible
> might make sense but I still doubt it has much practical usefulness.

Yes. sh2 and sh3/4 exception handling is very different.
It so difficult unified binary.
I think there are no advantages that individual CPU is defined
here so much.
It doesn't make the sense so much.

> Rich

-- 
Yoshinori Sato
<ysato@users.sourceforge.jp>
