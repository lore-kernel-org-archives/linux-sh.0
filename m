From: Simon Horman <horms@verge.net.au>
Date: Wed, 25 Sep 2013 08:07:08 +0000
Subject: Re: [PATCH v5 7/7] ARM: shmobile: ape6evm-reference: enable DMA for the MMC interface
Message-Id: <20130925080707.GD16708@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
 <1375455042-24093-8-git-send-email-g.liakhovetski@gmx.de>
 <20130925075642.GA3747@verge.net.au>
In-Reply-To: <20130925075642.GA3747@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Wed, Sep 25, 2013 at 04:56:42PM +0900, Simon Horman wrote:
> On Fri, Aug 02, 2013 at 04:50:42PM +0200, Guennadi Liakhovetski wrote:
> > This patch adds DMA slave bindings for the two required DMA channels
> > for MMCIF0 to ape6evm-reference.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> 
> Thanks, I have queue this up for v3.13.

Scratch that. I was careless and forgot that it depends on 6/7 which
I have asked you to split into two patches.

Please include this patch when you repost 6/7.

> 
> > ---
> >  arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > index 6797fac..631086a 100644
> > --- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > +++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
> > @@ -112,6 +112,9 @@
> >  	vmmc-supply = <&vcc_mmc0>;
> >  	bus-width = <8>;
> >  	non-removable;
> > +	dmas = <&dmac 0xd1
> > +		&dmac 0xd2>;
> > +	dma-names = "tx", "rx";
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&mmc0_pins>;
> >  	status = "okay";
> > -- 
> > 1.7.2.5
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
