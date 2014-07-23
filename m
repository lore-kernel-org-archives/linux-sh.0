From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 23 Jul 2014 08:47:11 +0000
Subject: Re: [PATCH v2 0/8] R-Car Gen2 DMA Controller driver
Message-Id: <11077814.mPNUCEf1hO@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1405727425-6237-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405727425-6237-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wednesday 23 July 2014 09:35:33 Simon Horman wrote:
> On Sat, Jul 19, 2014 at 01:50:17AM +0200, Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch sets adds a new driver for the DMA controller found in the
> > R-Car Gen2 SoCs under the name "Direct Memory Access Controller for System
> > (SYS-DMAC)". Support for the "Realtime Direct Memory Access Controller
> > (RT-DMAC)" and "Direct Memory Access Controller for Audio (Audio-DMAC)"
> > will be added later.
> > 
> > For the rationale of why a new driver is needed, and performance figures,
> > please see the cover letter of v1 ("[PATCH 0/7] R-Car Gen2 DMA Controller
> > driver") [1].
> > 
> > Support for hardware descriptors lists is under development and will be
> > posted in the near future. No change to the DT bindings will be needed.
> > 
> > The first five patches should go through the DMA engine tree, while the
> > last three patches should go through the Renesas tree. If the driver can
> > make it to v3.17 merging the platform changes will be easier.
> > 
> > Morimoto-san, could you please test if this version fixes the channel
> > filter issue you've experienced with the R-Car audio driver ? I would
> > also appreciate if you could tell me how to test cyclic DMA transfers
> > using the audio driver.
> > 
> > Changes since v1:
> > 
> > - Allocate IRQ name strings dynamically
> > - Only call the callback function if one is supplied
> > - Don't overallocate sg list entries
> > - Allocate sg list entries with GFP_KERNEL
> > - Don't manage function clock manually
> > - Make channel filter ignore unrelated devices
> > - Document why the cyclic sg list is kcalloc'ed
> > - Remove ch15 from interrupt names in DT
> > - Replace CONFIG_OF with OF in Kconfig
> > 
> > [1] http://www.spinics.net/lists/linux-sh/msg33768.html
> > 
> > Laurent Pinchart (8):
> >   dmaengine: sh: Rework Kconfig and Makefile
> >   dmaengine: shdma: Make channel filter ignore unrelated devices
> >   dmaengine: shdma: Allocate cyclic sg list dynamically
> >   dmaengine: rcar-dmac: Add device tree bindings documentation
> >   dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)
> >     driver
> 
> I have queued up the above three patches in the shdma-for-v3.17 branch
> of the renesas tree.

I suppose you meant five, not three.

> I intend to send a pull-request for them once they have sat in next.

I was waiting for acks before sending the pull request, but that's fine. Who 
will you send the pull request to, the dmaengine maintainer ?

> >   ARM: shmobile: r8a7790: Add DMAC clocks to DT
> >   ARM: shmobile: r8a7790: Add DMAC devices to DT
> >   ARM: shmobile: r8a7791: Add DMAC devices to DT
> 
> I am holding off on the above patches as there is still some chance
> the dmaengine subsystem maintainer may reject the new binding introduced
> by the 4th patch of this series.
> 
> Could you repost them once he has accepted my as-yet-unsent pull-request.

Sure. You could already apply "ARM: shmobile: r8a7790: Add DMAC clocks to DT" 
as that's independent from the DMAC DT bindings, but that's up to you.

> >  .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   98 ++
> >  arch/arm/boot/dts/r8a7790.dtsi                     |   66 +-
> >  arch/arm/boot/dts/r8a7791.dtsi                     |   60 +
> >  drivers/dma/sh/Kconfig                             |   30 +-
> >  drivers/dma/sh/Makefile                            |   15 +-
> >  drivers/dma/sh/rcar-dmac.c                         | 1525 +++++++++++++++
> >  drivers/dma/sh/shdma-base.c                        |  101 +-
> >  7 files changed, 1845 insertions(+), 50 deletions(-)
> >  create mode 100644
> >  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt create mode
> >  100644 drivers/dma/sh/rcar-dmac.c

-- 
Regards,

Laurent Pinchart

