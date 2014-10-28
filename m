From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 28 Oct 2014 21:02:51 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <2420971.jSGW0iP7me@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Monday 27 October 2014 20:03:56 Kuninori Morimoto wrote:
> Hi
> Cc Simon
> 
> > Laurent Pinchart (9):
> >   dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
> >   dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
> >   dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)
> >   
> >     driver
> >   
> >   ARM: shmobile: r8a7790: Rename mmcif node to mmc
> >   ARM: shmobile: r8a7791: Add MMCIF0 DT node
> >   ARM: shmobile: r8a7790: Reference DMA channels in MMCIF DT nodes
> >   ARM: shmobile: r8a7791: Reference DMA channels in MMCIF DT node
> >   ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
> >   ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
> >  
> >  .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |    3 -
> >  arch/arm/boot/dts/r8a7790.dtsi                     |   14 +-
> >  arch/arm/boot/dts/r8a7791.dtsi                     |   17 +
> >  drivers/dma/sh/Kconfig                             |    8 +
> >  drivers/dma/sh/Makefile                            |    1 +
> >  drivers/dma/sh/rcar-dmac.c                         | 1533 +++++++++++++++
> >  include/linux/dmaengine.h                          |    3 +
> >  7 files changed, 1575 insertions(+), 4 deletions(-)
> >  create mode 100644 drivers/dma/sh/rcar-dmac.c
> 
> On Lager board + SDHI
> 
> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thank you.

> Current SDHI driver + DMAC is working, but super slow,
> especially, write case....

*sigh* I'll test that.

-- 
Regards,

Laurent Pinchart

