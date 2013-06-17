From: Vinod Koul <vinod.koul@intel.com>
Date: Mon, 17 Jun 2013 13:52:22 +0000
Subject: Re: [PATCH 0/3] dma: add support for DMA multiplexer DT nodes
Message-Id: <20130617134022.GC10671@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
 <20130612092349.GR4107@intel.com>
 <20130612092500.GS4107@intel.com>
 <Pine.LNX.4.64.1306121235460.23454@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306121235460.23454@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On Wed, Jun 12, 2013 at 12:38:44PM +0200, Guennadi Liakhovetski wrote:
> On Wed, 12 Jun 2013, Vinod Koul wrote:
> 
> > On Wed, Jun 12, 2013 at 02:53:49PM +0530, Vinod Koul wrote:
> > > On Thu, Jun 06, 2013 at 05:47:22PM +0200, Guennadi Liakhovetski wrote:
> > > > Next re-send of an earlier work. This series adds support for multiple 
> > > > compatible DMAC instances, capable of serving the same DMA slaves. 
> > > > Currently to specify such a configuration in DT, slaves would have to add 
> > > > DMA tuples for each requested channel for each suitable DMAC. This 
> > > > needlessly clutters the Device Tree. Instead we group such DMAC DT nodes 
> > > > together under a common parent. Then slaves can just reference that parent 
> > > > in their DMA bindings.
> > > > 
> > > > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > + arnd now..
> > 
> > > wasnt this series Acked by Anrd previosuly.
> 
> Well, he requested documentation, which I first posted as a separate 
> patch, but integrated in the actual DT-adding patch in this version. Back 
> then Arnd wrote "With a binding document added, the patch seems ok." which 
> kinda is an Ack... :)
I would prefer an explict ACK from Arnd before applying the DT changes

Arnd, can you pls do the needful

--
~Vinod
> 
> Thanks
> Guennadi
> 
> > > 
> > > Neverthless, Anrd do you mind reviwing this
> > > 
> > > --
> > > ~Vinod
> > > > 
> > > > Guennadi Liakhovetski (3):
> > > >   OF: add a new phandle parsing function for grouped nodes
> > > >   dmaengine: add support for DMA multiplexer DT nodes
> > > >   DMA: shdma: add DT support
> > > > 
> > > >  Documentation/devicetree/bindings/dma/dma.txt |   44 +++++++++++++++++++++
> > > >  drivers/dma/of-dma.c                          |   31 +++++++++++----
> > > >  drivers/dma/sh/shdma-base.c                   |   51 ++++++++++++++++++++++---
> > > >  drivers/dma/sh/shdma.c                        |   44 ++++++++++++++++++---
> > > >  drivers/of/base.c                             |   28 ++++++++++++-
> > > >  include/linux/of.h                            |   16 ++++++++
> > > >  include/linux/shdma-base.h                    |    5 ++
> > > >  7 files changed, 196 insertions(+), 23 deletions(-)
> > > > 
> > > > -- 
> > > > 1.7.2.5
> > > > 
> > > > Thanks
> > > > Guennadi
> > > > ---
> > > > Guennadi Liakhovetski, Ph.D.
> > > > Freelance Open-Source Software Developer
> > > > http://www.open-technology.de/
> > > 
> > > -- 
> > 
> > -- 
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/

-- 
