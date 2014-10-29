From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 29 Oct 2014 09:49:33 +0000
Subject: Re: [PATCH v3 0/9] R-Car Gen2 DMA Controller driver
Message-Id: <1774775.b7qCaJMkr4@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414345216-14486-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus, Morimoto-san,

On Wednesday 29 October 2014 11:36:03 Magnus Damm wrote:
> On Wed, Oct 29, 2014 at 6:02 AM, Laurent Pinchart wrote:
> > On Monday 27 October 2014 20:03:56 Kuninori Morimoto wrote:
> >> Hi
> >> Cc Simon
> >> 
> >> > Laurent Pinchart (9):
> >> >   dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
> >> >   dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
> >> >   dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)
> >> >   
> >> >     driver
> >> >   
> >> >   ARM: shmobile: r8a7790: Rename mmcif node to mmc
> >> >   ARM: shmobile: r8a7791: Add MMCIF0 DT node
> >> >   ARM: shmobile: r8a7790: Reference DMA channels in MMCIF DT nodes
> >> >   ARM: shmobile: r8a7791: Reference DMA channels in MMCIF DT node
> >> >   ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
> >> >   ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
> >> >  
> >> >  .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |    3 -
> >> >  arch/arm/boot/dts/r8a7790.dtsi                     |   14 +-
> >> >  arch/arm/boot/dts/r8a7791.dtsi                     |   17 +
> >> >  drivers/dma/sh/Kconfig                             |    8 +
> >> >  drivers/dma/sh/Makefile                            |    1 +
> >> >  drivers/dma/sh/rcar-dmac.c                         | 1533 ++++++++++++
> >> >  include/linux/dmaengine.h                          |    3 +
> >> >  7 files changed, 1575 insertions(+), 4 deletions(-)
> >> >  create mode 100644 drivers/dma/sh/rcar-dmac.c
> >> 
> >> On Lager board + SDHI
> >> 
> >> Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > 
> > Thank you.
> > 
> >> Current SDHI driver + DMAC is working, but super slow,
> >> especially, write case....
> > 
> > *sigh* I'll test that.
> 
> If you have energy to deal with this then that is of course greatly
> appreciated.

I've performed quick SDHI performance tests yesterday. Read performance were 
around 7.5% lower with DMA support. Write performances varied but seemed 
similar on average.

- PIO

# time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
262144+0 records in
262144+0 records out
real    0m 6.89s
user    0m 0.19s
sys     0m 2.71s

# time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
262144+0 records in
262144+0 records out
real    0m 6.95s
user    0m 0.05s
sys     0m 2.82s

# time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
32+0 records in
32+0 records out
real    1m 55.37s
user    0m 0.00s
sys     0m 0.72s

# time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
32+0 records in
32+0 records out
real    1m 53.44s
user    0m 0.00s
sys     0m 0.71s

- DMA

# time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
32+0 records in
32+0 records out
real    0m 7.39s
user    0m 0.00s
sys     0m 0.60s

# time dd if=/dev/mmcblk1 of=/mnt/ram/mmc.bin count2768 bs@96
32+0 records in
32+0 records out
real    0m 7.46s
user    0m 0.00s
sys     0m 0.63s

# time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
32768+0 records in
32768+0 records out
real    1m 54.45s
user    0m 0.00s
sys     0m 0.71s

# time dd of=/dev/mmcblk1 if=/mnt/ram/mmc.bin count2768 bs@96
32768+0 records in
32768+0 records out
real    1m 55.61s
user    0m 0.02s
sys     0m 0.64s

This is without using hardware descriptors. I'll test that next.

> From my point of view it is however easier to simply ignore SDHI for
> now and remove those patches from this patch series. Once all the
> dependencies are sorted out for the new DMAC driver and all code is
> upstream then perhaps the SDHI driver is in a better shape and allows
> for more easy DMA enablement.

-- 
Regards,

Laurent Pinchart

