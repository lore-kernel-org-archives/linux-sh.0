From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 06:55:36 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: armadillo: Set vccq_sdhi0 regulator type in DT
Message-Id: <20131205065535.GB6817@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1385653493-9952-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385653493-9952-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131205034554.GB20388@verge.net.au> <9848623.yKHAtIGPld@avalon>
In-Reply-To: <9848623.yKHAtIGPld@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Thu, Dec 05, 2013 at 06:56:48AM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 05 December 2013 12:45:54 Simon Horman wrote:
> > On Thu, Nov 28, 2013 at 04:44:53PM +0100, Laurent Pinchart wrote:
> > > The mandatory regulator-type property is missing, add it.
> > 
> > Thanks, I will queue this up.
> 
> Mark has rightfully commented on patch 1/2 in this series that the regulator-
> type property shouldn't be mandatory but should default to voltage. We could 
> then drop this patch.

I will drop it, thanks.

> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> > > b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts index
> > > 7b80f19..013a7cd 100644
> > > --- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> > > +++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
> > > @@ -53,6 +53,8 @@
> > > 
> > >  		regulator-name = "SDHI0 VccQ";
> > >  		regulator-min-microvolt = <1800000>;
> > >  		regulator-max-microvolt = <3300000>;
> > > 
> > > +		regulator-type = "voltage";
> > > +
> > > 
> > >  		vin-supply = <&vcc_sdhi0>;
> > >  		
> > >  		enable-gpio = <&pfc 74 GPIO_ACTIVE_HIGH>;
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
