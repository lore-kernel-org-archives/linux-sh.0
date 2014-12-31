From: Simon Horman <horms@verge.net.au>
Date: Wed, 31 Dec 2014 06:14:36 +0000
Subject: Re: [PATCH 21/30] ARM: shmobile: r8a7794: Add SDHI clocks to device tree
Message-Id: <20141231061436.GE22191@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
 <8e181633e6ca960491ac502ccd4a4aac482c3ff9.1419812186.git.horms+renesas@verge.net.au>
 <54A13791.2060201@cogentembedded.com>
In-Reply-To: <54A13791.2060201@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Dec 29, 2014 at 02:14:25PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 12/29/2014 4:43 AM, Simon Horman wrote:
> 
> >From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> 
> >Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> >[horms: omitted device nodes; only add clock]
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm/boot/dts/r8a7794.dtsi            | 20 +++++++++++++++++++-
> >  include/dt-bindings/clock/r8a7794-clock.h |  3 +++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> >diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
> >index 728d719..c376676 100644
> >--- a/arch/arm/boot/dts/r8a7794.dtsi
> >+++ b/arch/arm/boot/dts/r8a7794.dtsi
> >@@ -293,6 +293,21 @@
> >  			clock-output-names = "main", "pll0", "pll1", "pll3",
> >  					     "lb", "qspi", "sdh", "sd0", "z";
> >  		};
> >+		/* Variable factor clocks */
> >+		sd1_clk: sd2_clk@e6150078 {
> 
>    So is it SD1 or SD2 clock?
> 
> >+			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
> >+			reg = <0 0xe6150078 0 4>;
> >+			clocks = <&pll1_div2_clk>;
> >+			#clock-cells = <0>;
> >+			clock-output-names = "sd1";
> >+		};
> >+		sd2_clk: sd3_clk@e615007c {
> 
>    Same question...
> 
> >+			compatible = "renesas,r8a7794-div6-clock", "renesas,cpg-div6-clock";
> >+			reg = <0 0xe615007c 0 4>;
> >+			clocks = <&pll1_div2_clk>;
> >+			#clock-cells = <0>;
> >+			clock-output-names = "sd2";
> >+		};
> [...]

Thanks, and sorry for letting that slip through.
e6150078 should be sd1_clk and e615007c should be sd2_clk.
And for reference sd3_clk is e615026c.

I'll send an incremental patch to fix this problem.
