From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Jun 2014 07:52:14 +0000
Subject: Re: [PATCH v2 2/7] ARM: shmobile: r8a7790: Add default PCIe bus clock
Message-Id: <20140613075214.GF15286@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1402484753-7471-3-git-send-email-phil.edworthy@renesas.com>
In-Reply-To: <1402484753-7471-3-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 13, 2014 at 07:48:58AM +0000, Phil Edworthy wrote:
> Hi Simon,
> 
> On 13 June 2014 08:45, Simon wrote:
> > On Thu, Jun 12, 2014 at 04:23:59PM +0000, Phil Edworthy wrote:
> > > Hi Laurent,
> > >
> > > On 12 June 2014 16:35, Laurent wrote:
> > > > On Wednesday 11 June 2014 12:05:48 Phil Edworthy wrote:
> > > > > This patch adds a default PCIe bus clock node.
> > > > >
> > > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > > > ---
> > > > > v2:
> > > > >  - Use a default PCIe bus clock in the device's dtsi
> > > > >
> > > > >  arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
> > > > >  1 file changed, 8 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> > > > b/arch/arm/boot/dts/r8a7790.dtsi
> > > > > index 7eb882c..13b4e63 100644
> > > > > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > > > > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > > > > @@ -487,6 +487,14 @@
> > > > >  			clock-output-names = "extal";
> > > > >  		};
> > > > >
> > > > > +		/* External PCIe clock - can be overridden by the board */
> > > > > +		pcie_bus_clk: pcie_bus_clk {
> > > > > +			compatible = "fixed-clock";
> > > > > +			#clock-cells = <0>;
> > > > > +			clock-frequency = <100000000>;
> > > > > +			clock-output-names = "pcie_bus";
> > > >
> > > > As the clock isn't present on all r8a7790 boards, how about making it
> > disabled
> > > > (status = "disabled") by default ?
> > >
> > > Ah, right. I hadn't considered that the clock could also be disabled. Ok...
> > 
> > Hi Phil,
> > 
> > Am I right in thinking that this change is the only
> > issue outstanding for the entire series?
> > 
> > If so, could you repost the entire series with that change?
> 
> Sure, I was planning on doing that this morning, after I've finished some other work!

Great, thanks.
