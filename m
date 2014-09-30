From: Simon Horman <horms@verge.net.au>
Date: Tue, 30 Sep 2014 04:23:53 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7790: Add VSP1 devices to DT
Message-Id: <20140930042353.GB24253@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Sep 15, 2014 at 02:32:07AM +0300, Laurent Pinchart wrote:
> Hi Sergei,
> 
> On Sunday 14 September 2014 21:58:47 Sergei Shtylyov wrote:
> > On 09/14/2014 03:36 AM, Laurent Pinchart wrote:
> > > Add all available VSP1 devices.
> > > 
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > >  arch/arm/boot/dts/r8a7790.dtsi | 51 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 51 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a7790.dtsi
> > > b/arch/arm/boot/dts/r8a7790.dtsi index d0e1773..7f00bec 100644
> > > --- a/arch/arm/boot/dts/r8a7790.dtsi
> > > +++ b/arch/arm/boot/dts/r8a7790.dtsi
> > > @@ -600,6 +600,57 @@
> > > 
> > >   		status = "disabled";
> > >   	
> > >   	};
> > > 
> > > +	vsp1@fe920000 {
> > 
> > Can't we call this node "video" or something alike (to comply with ePAPR)?
> 
> I don't mind renaming the node, but "video" sounds too generic to me (and 
> possibly misleading, as people might expect a video node to correspond to a 
> video output device).

Hi,

I am wondering if there has been a conclusion to this discussion.

> > > +		compatible = "renesas,vsp1";
> > > +		reg = <0 0xfe920000 0 0x8000>;
> > > +		interrupts = <0 266 IRQ_TYPE_LEVEL_HIGH>;
> > > +		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
