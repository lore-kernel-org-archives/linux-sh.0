From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Feb 2015 06:51:48 +0000
Subject: Re: [PATCH v3 07/15] ARM: shmobile: bockw: add devices hooked up to i2c0 to DT
Message-Id: <20150225065147.GA20087@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424105939-4910-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424105939-4910-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 18, 2015 at 08:22:56AM +0100, Wolfram Sang wrote:
> On Tue, Feb 17, 2015 at 04:42:08PM -0500, Simon Horman wrote:
> > Hi Wolfram,
> > 
> > I am thinking that the binding portion of this patch could be re-posted as
> > a separate patch for you to handle? What are your thoughts?
> 
> You can have it :)
> 
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks.

Ulrich, could you please resubmit this as two patches?
One that adds the binding. And one that updates the .dts file.

> > On Mon, Feb 16, 2015 at 05:58:51PM +0100, Ulrich Hecht wrote:
> > > Cameras, RTC, and ak4643 sound codec.
> > > 
> > > Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > ---
> > >  .../devicetree/bindings/i2c/trivial-devices.txt    |  1 +
> > >  arch/arm/boot/dts/r8a7778-bockw.dts                | 25 ++++++++++++++++++++++
> > >  2 files changed, 26 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > index 9f4e382..b6fe29e 100644
> > > --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> > > @@ -75,6 +75,7 @@ nxp,pca9556		Octal SMBus and I2C registered interface
> > >  nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
> > >  nxp,pcf8563		Real-time clock/calendar
> > >  nxp,pcf85063		Tiny Real-Time Clock
> > > +oki,ml86v7667		OKI ML86V7667 video decoder
> > >  ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
> > >  pericom,pt7c4338	Real-time Clock Module
> > >  plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
> > > diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
> > > index 7347223..280a922 100644
> > > --- a/arch/arm/boot/dts/r8a7778-bockw.dts
> > > +++ b/arch/arm/boot/dts/r8a7778-bockw.dts
> > > @@ -59,6 +59,31 @@
> > >  	};
> > >  };
> > >  
> > > +&i2c0 {
> > > +	status = "okay";
> > > +
> > > +	ak4643: sound-codec@12 {
> > > +		compatible = "asahi-kasei,ak4643";
> > > +		#sound-dai-cells = <0>;
> > > +		reg = <0x12>;
> > > +	};
> > > +
> > > +	camera@41 {
> > > +		compatible = "oki,ml86v7667";
> > > +		reg = <0x41>;
> > > +	};
> > > +
> > > +	camera@43 {
> > > +		compatible = "oki,ml86v7667";
> > > +		reg = <0x43>;
> > > +	};
> > > +
> > > +	rx8581: rtc@51 {
> > > +		compatible = "epson,rx8581";
> > > +		reg = <0x51>;
> > > +	};
> > > +};
> > > +
> > >  &mmcif {
> > >  	pinctrl-0 = <&mmc_pins>;
> > >  	pinctrl-names = "default";
> > > -- 
> > > 2.2.2
> > > 


