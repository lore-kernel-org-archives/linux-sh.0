From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 18 Jun 2013 08:59:16 +0000
Subject: Re: [PATCH 2/3] dmaengine: add support for DMA multiplexer DT nodes
Message-Id: <Pine.LNX.4.64.1306181016420.30844@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
 <1370533645-23690-3-git-send-email-g.liakhovetski@gmx.de>
 <201306171816.12331.arnd@arndb.de>
In-Reply-To: <201306171816.12331.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Simon Horman <horms@verge.net.au>

Hi Arnd

Thanks for your comments

On Mon, 17 Jun 2013, Arnd Bergmann wrote:

> On Thursday 06 June 2013, Guennadi Liakhovetski wrote:
> >  Documentation/devicetree/bindings/dma/dma.txt |   44 +++++++++++++++++++++++++
> >  drivers/dma/of-dma.c                          |   31 +++++++++++++----
> >  2 files changed, 67 insertions(+), 8 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
> > index 8f504e6..a861298 100644
> > --- a/Documentation/devicetree/bindings/dma/dma.txt
> > +++ b/Documentation/devicetree/bindings/dma/dma.txt
> > @@ -31,6 +31,50 @@ Example:
> >  		dma-requests = <127>;
> >  	};
> >  
> > +* DMA multiplexer
> > +
> > +Several DMA controllers with the same #dma-cells number and the same request
> > +line IDs can be grouped under a DMA multiplexer super-node, if slaves can use
> > +DMA channels on any of them.
> > +
> > +Required property:
> > +- compatible:		Must include "dma-mux".
> > +
> > +Some standard optional properties can be helpful:
> > +
> > +Optional properties:
> > +- compatible:		You will probably also want to include compatibility
> > +			with "simple-bus" to automatically create platform
> > +			devices from subnodes.
> > +- ranges:		Map DMA controller memory areas in the parent address
> > +			space.
> > +- #address-cells:	Number of address cells in case automatic propagation
> > +			with the help of "ranges" doesn't work.
> > +- #size-cells:		Number of size cells.
> > +
> > +Example:
> > +
> > +	dmac: dma-mux {
> > +		compatible = "simple-bus", "dma-mux";
> > +		ranges;
> > +
> > +		dma0: dma@10000000 {
> > +			#dma-cells = <1>;
> > +			...
> > +		};
> > +
> > +		dma1: dma@20000000 {
> > +			#dma-cells = <1>;
> > +			...
> > +		};
> > +	};
> > +
> > +	mmc0: mmc@30000000 {
> > +			dmas = <&dmac 1
> > +				&dmac 2>;
> > +			dma-names = "tx", "rx";
> > +			...
> > +	};
> >  
> >  * DMA client
> 
> Hmm, you've clearly shown that this can work, but it feels like a really odd way to
> do this. I don't think we should do it this way, because it tries to be really
> generic but then cannot some of the interesting cases, e.g.
> 
> 1. you have multiplexed dma engines, but they need different #dma-cells.
> 1. you have multiplexed dma engines, but they need different dma specifiers.
> 2. The mux is between devices that are not on the same parent bus.

Yes, I know about these restrictions. I'm not sure whether we really ever 
will get DMA multiplexers with different #dma-cells or DMA specifiers, but 
in any case we can make this less generic - either keep it as a generic 
"uniform multiplexer" or making it shdma specific - I'm fine either way.

> I think this should either not try to be fully generic and just limited to
> the case you care about, i.e. shdma, or it should be more abstract and
> multiplex between the individual channels. In either case, I guess
> it would not need a change like this to the of_dma_request_slave_channel()
> function, and the node pointer used by the slave would be the same node
> that defines the address space for the channel descriptions with #dma-cells.
> 
> I think the easiest way would be the first of those two, so it would
> essentially look like 
> 
> 	dmac: dma-mux {
> 		compatible = "renesas,shdma-mux"; /* not simple-bus! */
> 		#dma-cells = <1>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 	
> 		dma@10000000 {
> 			compatible = "renesas,shdma";
> 			reg = <0x10000000 0x1000>;
> 			interrupts = <10>;
> 		};
> 		dma@20000000 {
> 			compatible = "renesas,shdma";
> 			reg = <0x10000000 0x1000>;
> 			interrupts = <10>;
> 		};
> 	}
> 
> You then register a device driver for the master device, which
> will call of_dma_controller_register() for itself and create
> its child devices.

Hmm, it is an interesting idea to only register one struct of_dma instance 
for all compatible shdma instances instead of one per shdma controller, 
and then call of_platform_populate() to instantiate all shdma instances. A 
couple of drawbacks:

1. we'll always have to put a mux DT node in .dts, even if there's just 
one DMAC instance on the system.

2. as AUXDATA for the new wrapper device we'll have to use an AUXDATA 
array for all child nodes, to be passed to of_platform_populate().

3. it seems confusing to me - having one ofdma instance for multiple 
dmaengine devices.

The advantage is, of course, that we don't need to extend existing OF and 
dmaengine APIs.

So, I think, it can be done this way, but do you really think it'd be an 
improvement over my original proposal?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
