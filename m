From: Simon Horman <horms@verge.net.au>
Date: Thu, 11 Dec 2014 02:21:49 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7794: Add QSPI clock to device tree
Message-Id: <20141211022147.GF513@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1418259561-27862-1-git-send-email-horms+renesas@verge.net.au>
 <87lhmf9dss.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lhmf9dss.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 11, 2014 at 01:26:42AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > 
> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > [horms: omitted device node and alias; only add clock]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.a, not device nodes:u>
> > 
> > ---
> > Based on the renesas-devel-20141211-v3.18 tag of my renesas tree
> > 
> > Changes by Simon Horman
> > * Removed portions of patch which add device node and alias
> > * Renamed patch from
> >   "ARM: shmobile: r8a7794: Add QSPI clock and device to device tree" to
> >   "ARM: shmobile: r8a7794: Add QSPI clock to device tree"
> > ---
> >  arch/arm/boot/dts/r8a7794.dtsi            | 8 ++++++++
> >  include/dt-bindings/clock/r8a7794-clock.h | 1 +
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> > index 6d95638..9f59849 100644
> > --- a/arch/arm/boot/dts/r8a7794.dtsi
> > +++ b/arch/arm/boot/dts/r8a7794.dtsi
> > @@ -535,6 +535,14 @@
> >  			clock-output-names > >  				"vin1", "vin0", "ether";
> >  		};
> > +		mstp9_clks: mstp9_clks@e6150994 {
> > +			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
> > +			reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
> > +			clocks = <&cpg_clocks R8A7794_CLK_QSPI>;
> > +			#clock-cells = <1>;
> > +			renesas,clock-indices = <R8A7794_CLK_QSPI_MOD>;
> > +			clock-output-names = "qspi_mod";
> > +		};
> 
> We want ot use this ?
> 
> - renesas,clock-indices
> + clock-indices

Thanks, and sorry for missing that. I'll fix that up.
Do you have any objections to the patch if that problem is resolved?
