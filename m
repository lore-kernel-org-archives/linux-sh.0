From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Jun 2013 13:23:33 +0000
Subject: Re: [PATCH 2/3] dmaengine: add support for DMA multiplexer DT nodes
Message-Id: <201306181523.33959.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de> <201306171816.12331.arnd@arndb.de> <Pine.LNX.4.64.1306181016420.30844@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306181016420.30844@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Simon Horman <horms@verge.net.au>

On Tuesday 18 June 2013, Guennadi Liakhovetski wrote:
> > 
> > Hmm, you've clearly shown that this can work, but it feels like a really odd way to
> > do this. I don't think we should do it this way, because it tries to be really
> > generic but then cannot some of the interesting cases, e.g.
> > 
> > 1. you have multiplexed dma engines, but they need different #dma-cells.
> > 1. you have multiplexed dma engines, but they need different dma specifiers.
> > 2. The mux is between devices that are not on the same parent bus.
> 
> Yes, I know about these restrictions. I'm not sure whether we really ever 
> will get DMA multiplexers with different #dma-cells or DMA specifiers, but 
> in any case we can make this less generic - either keep it as a generic 
> "uniform multiplexer" or making it shdma specific - I'm fine either way.

Ok, let's make it shdma specific then.

> > I think this should either not try to be fully generic and just limited to
> > the case you care about, i.e. shdma, or it should be more abstract and
> > multiplex between the individual channels. In either case, I guess
> > it would not need a change like this to the of_dma_request_slave_channel()
> > function, and the node pointer used by the slave would be the same node
> > that defines the address space for the channel descriptions with #dma-cells.
> > 
> > I think the easiest way would be the first of those two, so it would
> > essentially look like 
> > 
> > 	dmac: dma-mux {
> > 		compatible = "renesas,shdma-mux"; /* not simple-bus! */
> > 		#dma-cells = <1>;
> > 		#address-cells = <1>;
> > 		#size-cells = <1>;
> > 	
> > 		dma@10000000 {
> > 			compatible = "renesas,shdma";
> > 			reg = <0x10000000 0x1000>;
> > 			interrupts = <10>;
> > 		};
> > 		dma@20000000 {
> > 			compatible = "renesas,shdma";
> > 			reg = <0x10000000 0x1000>;
> > 			interrupts = <10>;
> > 		};
> > 	}
> > 
> > You then register a device driver for the master device, which
> > will call of_dma_controller_register() for itself and create
> > its child devices.
> 
> Hmm, it is an interesting idea to only register one struct of_dma instance 
> for all compatible shdma instances instead of one per shdma controller, 
> and then call of_platform_populate() to instantiate all shdma instances. A 
> couple of drawbacks:
> 
> 1. we'll always have to put a mux DT node in .dts, even if there's just 
> one DMAC instance on the system.
>
> 2. as AUXDATA for the new wrapper device we'll have to use an AUXDATA 
> array for all child nodes, to be passed to of_platform_populate().

My suggestion above is just one of the possible ways to do it, and I'm
less concerned about it if you make it specific to shdma. Other
options would be:

1 using phandles from the mux to the individual dma engine instances,
  but have them as independent nodes.
2 same as 1, but using phandles from the individual instances to the mux
3 Keep using the simple-bus.
4 Have just one combined device node for all shdma instances, with multiple
  'reg' and 'interrupts' properties, and handle the muxing in the shdma
  driver. You could create platform_device_create_resndata from the
  top-level driver to reuse most of the existing code.

In any of these cases you should be able to support both muxed and non-muxed
operation in the shdma driver if you want to. You'd just have two separate
ofdma registrations.

> 3. it seems confusing to me - having one ofdma instance for multiple 
> dmaengine devices.

I don't see a better way around this one, but I also don't see it as problematic.
Wiht a mux, you always end up having just one node that the slaves
point to, but multiple dma_device structures in the kernel. struct ofdma
really refers to the first one.

> The advantage is, of course, that we don't need to extend existing OF and 
> dmaengine APIs.
> 
> So, I think, it can be done this way, but do you really think it'd be an 
> improvement over my original proposal?

My main interest is to keep the shdma specifics out of the generic dmaengine
binding document, where it just complicates the common case.

	Arnd
