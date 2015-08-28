From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 02:23:49 +0000
Subject: Re: [PATCH/RFC 05/10] arm64: dts: r8a7795: add clock for EthernetAVB
Message-Id: <20150828022343.GG7357@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-6-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-6-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 11:47:33PM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > 
> > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > [horms: updated p_clk to s3d4_clk; moved to clock node; updated changelog;
> >         use R8A7795 as prefix for clock defines]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 11 +++++++++++
> >  include/dt-bindings/clock/r8a7795-clock.h |  1 +
> >  2 files changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index a608eb92a172..0b435d8274e4 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -227,6 +227,16 @@
> >  					clock-output-names = "hsusb", "ehci0", "ehci1", "ehci2";
> >  				};
> >  
> > +				mstp8_clks: mstp8_clks@e6150990 {
> > +					compatible = "renesas,r8a7795-mstp-clocks",
> > +						     "renesas,cpg-mstp-clocks";
> > +					reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> > +					clocks =  <&s3d4_clk>;
> > +					#clock-cells = <1>;
> > +					renesas,clock-indices = <R8A7795_CLK_AVB>;
> 
> Maybe this is my v7 fault, but we need to use "clock-indices" instead of "renesas,clock-indices".
> I will fix these in next v8

Thanks, it looks like we both have some updates to make.
