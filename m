From: Simon Horman <horms@verge.net.au>
Date: Thu, 26 Dec 2013 02:13:32 +0000
Subject: Re: [PATCH 6/6] ARM: shmobile: r8a7791: Add SSI clocks in device tree
Message-Id: <20131226021326.GA11888@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1387468266-13625-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1387468266-13625-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 25, 2013 at 07:41:20PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 25 December 2013 22:07:59 Simon Horman wrote:
> > On Thu, Dec 19, 2013 at 04:51:06PM +0100, Laurent Pinchart wrote:
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Hi Laurent,
> > 
> > I have queued this up and it is present in
> > renesas-next-v3.13-rc5-20131224v4.
> > 
> > However, I have observed that it prevents the Koelsch board booting
> > to the point where anything is displayed on the serial console.
> > Likewise on Lager with the r8a7790 variant of this patch.
> > 
> > Could you take a look into this?
> 
> Indeed, I've been able to reproduce the problem. Could you please drop this 
> patch and the related Lager patch ? I'll send a new version as an RFC as the 
> problem might be in the CCF core.

As I have already sent a pull request that included these changes
I think that I would prefer to revert them than drop them.

> 
> > For reference I have attached my .config converted into
> > a more compact defconfig using make savedefconfig.
> > 
> > > ---
> > > 
> > >  arch/arm/boot/dts/r8a7791.dtsi            | 20 ++++++++++++++++++++
> > >  include/dt-bindings/clock/r8a7791-clock.h | 13 +++++++++++++
> > >  2 files changed, 33 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a7791.dtsi
> > > b/arch/arm/boot/dts/r8a7791.dtsi index 19c6550..e92c1f7 100644
> > > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > > @@ -495,6 +495,26 @@
> > >  				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c4", "i2c3",
> > >  				"i2c2", "i2c1", "i2c0";
> > >  		};
> > > 
> > > +		mstp10_clks: mstp10_clks@e6150998 {
> > > +			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-
> mstp-clocks";
> > > +			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
> > > +			clocks = <&p_clk>, <&mstp10_clks R8A7791_CLK_SSI>,
> > > +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks 
> R8A7791_CLK_SSI>,
> > > +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks 
> R8A7791_CLK_SSI>,
> > > +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks 
> R8A7791_CLK_SSI>,
> > > +				 <&mstp10_clks R8A7791_CLK_SSI>, <&mstp10_clks 
> R8A7791_CLK_SSI>,
> > > +				 <&mstp10_clks R8A7791_CLK_SSI>;
> > > +			#clock-cells = <1>;
> > > +			renesas,clock-indices = <
> > > +				R8A7791_CLK_SSI R8A7791_CLK_SSI9 R8A7791_CLK_SSI8
> > > +				R8A7791_CLK_SSI7 R8A7791_CLK_SSI6 R8A7791_CLK_SSI5
> > > +				R8A7791_CLK_SSI4 R8A7791_CLK_SSI3 R8A7791_CLK_SSI2
> > > +				R8A7791_CLK_SSI1 R8A7791_CLK_SSI0
> > > +			>;
> > > +			clock-output-names > > > +				"ssi", "ssi9", "ssi8", "ssi7", "ssi6", "ssi5",
> > > +				"ssi4", "ssi3", "ssi2", "ssi1", "ssi0";
> > > +		};
> > > 
> > >  		mstp11_clks: mstp11_clks@e615099c {
> > >  			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-
> mstp-clocks";
> > >  			reg = <0 0xe615099c 0 4>, <0 0xe61509ac 0 4>;
> > > diff --git a/include/dt-bindings/clock/r8a7791-clock.h
> > > b/include/dt-bindings/clock/r8a7791-clock.h index 30f82f2..1c8f00d 100644
> > > --- a/include/dt-bindings/clock/r8a7791-clock.h
> > > +++ b/include/dt-bindings/clock/r8a7791-clock.h
> > > @@ -103,6 +103,19 @@
> > > 
> > >  #define R8A7791_CLK_I2C1		30
> > >  #define R8A7791_CLK_I2C0		31
> > > 
> > > +/* MSTP10 */
> > > +#define R8A7791_CLK_SSI			5
> > > +#define R8A7791_CLK_SSI9		6
> > > +#define R8A7791_CLK_SSI8		7
> > > +#define R8A7791_CLK_SSI7		8
> > > +#define R8A7791_CLK_SSI6		9
> > > +#define R8A7791_CLK_SSI5		10
> > > +#define R8A7791_CLK_SSI4		11
> > > +#define R8A7791_CLK_SSI3		12
> > > +#define R8A7791_CLK_SSI2		13
> > > +#define R8A7791_CLK_SSI1		14
> > > +#define R8A7791_CLK_SSI0		15
> > > +
> > > 
> > >  /* MSTP11 */
> > >  #define R8A7791_CLK_SCIFA3		6
> > >  #define R8A7791_CLK_SCIFA4		7
> -- 
> Regards,
> 
> Laurent Pinchart
> 
