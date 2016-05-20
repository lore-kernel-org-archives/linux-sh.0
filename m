From: Rich Felker <dalias@libc.org>
Date: Fri, 20 May 2016 22:42:05 +0000
Subject: Re: [PATCH v2 12/12] sh: add device tree source for J2 FPGA on Mimas v2 board
Message-Id: <20160520224205.GW21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1463708766.git.dalias@libc.org>
 <9960d6526523727d1bee3d11c6704e09e600c6fe.1463708766.git.dalias@libc.org>
 <CAMuHMdVr-gZbfo9hG=w5bB3_x6v67sFd2yAPLLbPyWyg-jUmug@mail.gmail.com>
In-Reply-To: <CAMuHMdVr-gZbfo9hG=w5bB3_x6v67sFd2yAPLLbPyWyg-jUmug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>

On Fri, May 20, 2016 at 10:17:34AM +0200, Geert Uytterhoeven wrote:
> On Fri, May 20, 2016 at 4:53 AM, Rich Felker <dalias@libc.org> wrote:
> > --- /dev/null
> > +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
> > @@ -0,0 +1,87 @@
> > +/dts-v1/;
> > +
> > +/ {
> > +       compatible = "jcore,j2-soc";
> > +       model = "J2 FPGA SoC on Mimas v2 board";
> > +
> > +       #address-cells = <1>;
> > +       #size-cells = <1>;
> > +
> > +       interrupt-parent = <&aic>;
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               cpu@0 {
> > +                       device_type = "cpu";
> > +                       compatible = "jcore,j2";
> > +                       reg = < 0 >;
> > +                       clock-frequency = < 50000000 >;
> > +               };
> > +       };
> > +
> > +       memory@10000000 {
> > +               device_type = "memory";
> > +               reg = < 0x10000000 0x4000000 >;
> > +       };
> > +
> > +       chosen {
> > +               stdout-path = "/soc@abcd0000/serial@100";
> > +       };
> > +
> > +       soc@abcd0000 {
> > +               compatible = "simple-bus";
> > +               ranges = <0 0xabcd0000 0x100000>;
> > +
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +
> > +               aic: interrupt-controller {
> 
> aic: interrupt-controller@200 {
> 
> > +                       compatible = "jcore,aic1";
> > +                       reg = < 0x200 0x10 >;
> > +                       interrupt-controller;
> > +                       #interrupt-cells = <1>;
> > +               };
> > +
> > +               cache-controller {
> 
> @c0
> 
> > +                       compatible = "jcore,cache";
> > +                       reg = < 0xc0 4 >;
> > +               };
> > +
> > +               timer {
> 
> @200
> 
> > +                       compatible = "jcore,pit";
> > +                       reg = < 0x200 0x30 >;
> > +                       interrupts = < 0x48 >;
> > +               };
> > +
> > +               spi {
> 
> @40
> 
> > +                       compatible = "jcore,spi2";
> > +
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +
> > +                       spi-max-frequency = <12500000>;
> > +
> > +                       reg = < 0x40 0x8 >;
> > +
> > +                       sdcard@1 {
> 
> @0, to match reg below?

Yes; thanks for catching that. The chipselect logic was wrong a long
time ago and the wrong setting to compensate for that was fixed in the
actual reg cell but not in the name when the driver was fixed. I'm
applying all these changes.

Rich
