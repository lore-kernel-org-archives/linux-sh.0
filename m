From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 30 Oct 2014 00:28:09 +0000
Subject: [PATCH v4 0/5] R-Car Gen2 DMA Controller driver
Message-Id: <1414628894-24460-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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

For the rationale of why a new driver is needed, and performance figures,
please see the cover letter of v1 ("[PATCH 0/7] R-Car Gen2 DMA Controller
driver") [1].

The driver is now mostly feature-complete with support for hardware
descriptors lists (included as a separate patch to ease review) and cyclic
transfers. They have been tested with both the SDHI and audio drivers.

I've pushed the patches to

	git://linuxtv.org/pinchartl/fbdev.git dma/next

My audio test branch is available at

	git://linuxtv.org/pinchartl/fbdev.git dma/audio

Known issues are

- Stub system PM implementation. I'm working on this.

- Risk of conflict with Maxime's DMA engine rework series.

I believe the first issue isn't a show stopper. I can rebase the patches if
Maxime's patches get merged first.

Vinod, I would like to get this merged in v3.19 if possible.

Changes since v3:

- Add CONFIG_RENESAS_DMA config entry common to all Renesas DMA engines
- Add support for hardware descriptors lists previously posted as a separate
  patch series, with the following changes:
  - Typo fixes
  - Use GFP_NOWAIT to allocate hardware descriptors
  - Clear descriptor stage end interrupt when halting the channel
  - Program the descriptor interrupt pointer
  - Stop the channel in the IRQ handler only at the end of the transfer
  - Align allocated hwdesc size to page size
  - Ignore allocated hwdesc memory when the transfer doesn't use hwdescs

Changes since v2: 
 
- Replace several occurrences of size_t with unsigned int
- Remove unneeded local variable initialization
- Compute maximum transfer size at runtime
- Typo fixes
- Replace WARN_ON with WARN_ON_ONCE in interrupt handler
- Validate the number of channels
- Reset the device before enabling interrupts
- Use DMA_SLAVE_BUSWIDTH_* constants instead of numerical values
- Use devm_kasprintf
- Update to the new prep_dma_cyclic API
- Filter out channels from unrelated devices
- Fix typo in register definition
- Rename rcar_dmac_hw_desc to rcar_dmac_xfer_chunk
- Ignore the deprecated dma_slave_config direction field
- Allocate memory with GFP_NOWAIT in prep handlers
- Split runtime and system PM
- Move runtime PM to channel alloc/fre

Changes since v1:

- Allocate IRQ name strings dynamically
- Only call the callback function if one is supplied
- Don't overallocate sg list entries
- Allocate sg list entries with GFP_KERNEL
- Don't manage function clock manually
- Make channel filter ignore unrelated devices
- Document why the cyclic sg list is kcalloc'ed
- Remove ch15 from interrupt names in DT
- Replace CONFIG_OF with OF in Kconfig

[1] http://www.spinics.net/lists/linux-sh/msg33768.html

Laurent Pinchart (5):
  dmaengine: Add 16 bytes, 32 bytes and 64 bytes bus widths
  dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
  dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC)
    driver
  dmaengine: rcar-dmac: Implement support for hardware descriptor lists
  dmaengine: rcar-dmac: Cache hardware descriptors memory

 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  |    3 -
 drivers/dma/Makefile                               |    2 +-
 drivers/dma/sh/Kconfig                             |   14 +-
 drivers/dma/sh/Makefile                            |    1 +
 drivers/dma/sh/rcar-dmac.c                         | 1773 ++++++++++++++++++++
 include/linux/dmaengine.h                          |    3 +
 6 files changed, 1791 insertions(+), 5 deletions(-)
 create mode 100644 drivers/dma/sh/rcar-dmac.c

-- 
Regards,

Laurent Pinchart

