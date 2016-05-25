From: Rich Felker <dalias@libc.org>
Date: Wed, 25 May 2016 23:15:25 +0000
Subject: Re: [PATCH v3 12/12] sh: add device tree source for J2 FPGA on Mimas v2  board
Message-Id: <20160525231525.GV21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <3d6f6fd6d674942a6446b0a14d9877017c53eb2f.1464148904.git.dalias@libc.org>
 <20160525103349.GH1337@leverpostej>
In-Reply-To: <20160525103349.GH1337@leverpostej>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Wed, May 25, 2016 at 11:33:50AM +0100, Mark Rutland wrote:
> On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> > Signed-off-by: Rich Felker <dalias@libc.org>
> > ---
> >  arch/sh/boot/dts/j2_mimas_v2.dts | 87 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts
> > 
> > diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
> > new file mode 100755
> > index 0000000..4a66cda
> > --- /dev/null
> > +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
> > @@ -0,0 +1,87 @@
> > +/dts-v1/;
> > +
> > +/ {
> > +	compatible = "jcore,j2-soc";
> > +	model = "J2 FPGA SoC on Mimas v2 board";
> > +
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +
> > +	interrupt-parent = <&aic>;
> > +
> > +	cpus {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		cpu@0 {
> > +			device_type = "cpu";
> > +			compatible = "jcore,j2";
> > +			reg = < 0 >;
> > +			clock-frequency = < 50000000 >;
> 
> Nit: please remove the spacing around the '<' and '>' here. If nothing
> else, it's inconsistent with the rest of this file.
> 
> > +		};
> > +	};
> > +
> > +	memory@10000000 {
> > +		device_type = "memory";
> > +		reg = < 0x10000000 0x4000000 >;
> > +	};
> 
> Likewise.

OK, I'll change both of these.

> > +
> > +	chosen {
> > +		stdout-path = "/soc@abcd0000/serial@100";
> > +	};
> 
> Please use a label for the serial node, have an alias, and describe the
> pre-configured rate per the stdout-path binding, e.g.

Per Documentation/devicetree/bindings/xilinx.txt, current-speed is a
required property for "xlnx,xps-uartlite-1.00.a". Note that uartlite
does not actually have a programmable baud rate; the property is
instead being used to describe the hardware-provided rate.

BTW our uartlite is not actually derived from Xilinx's IP core, just
interface-compatible with it, so I'd actually like to add a
"jcore,uartlite" binding too in order to express this, with
"xlnx,xps-uartlite-1.00.a" as the fallback compatible-tag. I'll
propose that as a separate patch later.

Rich
