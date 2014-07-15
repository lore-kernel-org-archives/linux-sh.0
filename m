From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 15 Jul 2014 20:18:35 +0000
Subject: [PATCH 0/7] R-Car Gen2 DMA Controller driver
Message-Id: <1405455522-20676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello,

This patch sets adds a new driver for the DMA controller found in the R-Car
Gen2 SoCs under the name "Direct Memory Access Controller for System
(SYS-DMAC)". Support for the "Realtime Direct Memory Access Controller
(RT-DMAC)" and "Direct Memory Access Controller for Audio (Audio-DMAC)" will
be added later.

Support for the R-Car Gen2 DMAC could have been added to the existing shdmac
driver. However, the shdmac driver supports older generation hardware, not
aligned with the features set of the R-Car Gen2 DMAC. In particular
implementing support for hardware descriptors lists would have been difficult.
In order to avoid hindering Gen2 (and future) DMAC development a new driver is
preferable.

Preliminary performance tests showed similar numbers for the two drivers, in
the range of 675 to 775 MB/s throughput for the dmatest memcpy test using four
channels and one thread per channel.

modprobe dmatest run=1 iterations000 noverify=1 \
	 max_channels=4 threads_per_chan=1

Performances increase up to a more stable 893 to 895 MB/s with the new driver
when raising the number of threads per channel to 4.

modprobe dmatest run=1 iterations000 noverify=1 \
	 max_channels=4 threads_per_chan=4

However, running the same test with the shdmac driver produces timeouts:

[ 2150.819650] dmatest: dma0chan3-copy0: summary 10000 tests, 0 failures 6468 iops 103499 KB/s (0)
[ 2150.829205] dmatest: dma0chan3-copy1: summary 10000 tests, 0 failures 6430 iops 102892 KB/s (0)
[ 2150.839716] dmatest: dma0chan3-copy2: summary 10000 tests, 0 failures 6387 iops 102193 KB/s (0)
[ 2150.850093] dmatest: dma0chan3-copy3: summary 10000 tests, 0 failures 6376 iops 102028 KB/s (0)
[ 2152.263688] dmatest: dma0chan1-copy0: result #22: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)
[ 2152.273617] dmatest: dma0chan2-copy3: result #4: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)
[ 2152.273644] dmatest: dma0chan2-copy0: result #21: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)
[ 2152.273667] dmatest: dma0chan2-copy1: result #7: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)
[ 2152.284062] dmatest: dma0chan0-copy0: result #90: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)
[ 2152.284085] dmatest: dma0chan2-copy2: result #5: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)
[ 2152.284107] dmatest: dma0chan1-copy3: result #1: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)
[ 2152.284129] dmatest: dma0chan1-copy2: result #7: 'test timed out' with src_off=0x0 dst_off=0x0 len=0x4000 (0)

This is probably due to a runtime PM-related race condition in the shdmac
driver. No performance measurement can thus be performed with the existing
driver.

The rcar-dmac driver has been tested both with memcpy transfers using the
dmatest kernel module on the Lager and Koelsch boards, and with the MMCIF
device on the Lager board. A second patch set will follow to enable DMA
support for MMCIF on the Lager board.

Support for hardware descriptors lists is under development and will be posted
in the near future. No change to the DT bindings will be needed.

The first four patches should go through the DMA engine tree, while the last
three patches should go through the Renesas tree. If the driver can make it to
v3.17 merging the platform changes will be easier.

Laurent Pinchart (7):
  dmaengine: sh: Rework Kconfig and Makefile
  dmaengine: shdma: Make channel filter ignore unrelated devices
  dmaengine: rcar-dmac: Add device tree bindings documentation
  dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)
    driver
  ARM: shmobile: r8a7790: Add DMAC clocks to DT
  ARM: shmobile: r8a7790: Add DMAC devices to DT
  ARM: shmobile: r8a7791: Add DMAC devices to DT

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |   98 ++
 arch/arm/boot/dts/r8a7790.dtsi                     |   66 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |   60 +
 drivers/dma/sh/Kconfig                             |   30 +-
 drivers/dma/sh/Makefile                            |   15 +-
 drivers/dma/sh/rcar-dmac.c                         | 1514 ++++++++++++++++++++
 drivers/dma/sh/shdma-base.c                        |   84 +-
 7 files changed, 1819 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
 create mode 100644 drivers/dma/sh/rcar-dmac.c

-- 
Regards,

Laurent Pinchart

