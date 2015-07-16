From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:31 +0000
Subject: [PATCH/RFC v2 00/29] serial: sh-sci: Miscellaneous and DMA Improvements
Message-Id: <1437070920-28069-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi all,

This patch series contains various updates for the Renesas
(H)SCI(F{,A,B}) driver, incl. DMA support for SCIF on R-Car Gen2.
Some of these patches have been sent before. (Few) Changes are indicated
in the individual patches.

This is definitely not a final series, that's why it's marked as RFC and
sent to a limited audience:
  - There are still some race conditions between e.g. RX DMA
    completion(s) and the worker function,
  - Under high load RX DMA breaks,
  - The patch to add DT DMA support should be last, after all DMA fixes,
    to avoid regressions,
  - Unlike the old shdmac DMA engine driver, the new rcar-dmac DMA
    engine driver does not support resubmitting a DMA descriptor, so I
    added a workaround to the sh-sci driver,
  - This won't work with the old shdmac DMA engine driver anymore, due
    to the lack of residue handling in shdmac (preliminary untested
    patch sent, but it will need more work),
  - There are issues with residual handling in general,
  - ...

However, DMA is now usable for the serial console on r8a7791/koelsch.
This also received light testing with scif3 and scifa5 on r8a7791/koelsch.

For your convenience, I've also pushed this to
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git#scif-dma-v2

Thanks for your comments!

Geert Uytterhoeven (27):
  serial: sh-sci: Replace buggy big #ifdef by runtime logic
  serial: sh-sci: Correct SCIF_ERROR_CLEAR for plain SCIF
  serial: sh-sci: Correct FIFO stages on sh7705/sh7720/sh7721
  serial: sh-sci: Use correct device for DMA mapping with IOMMU
  serial: sh-sci: Fix scatterlist mapping leak
  serial: sh-sci: Use min_t()/max_t() instead of casts
  serial: sh-sci: Use SCIF_DR instead of hardcoded 1
  serial: sh-sci: Use offset_in_page() helper instead of open coding
  serial: sh-sci: Use sg_init_one() helper instead of open coding
  serial: sh-sci: Improve DMA error messages
  serial: sh-sci: Add DT support to DMA setup
  serial: sh-sci: Use SCSMR_CKS instead of hardcoded value 3
  serial: sh-sci: Drop path in reference to serial_core.c
  serial: sh-sci: Improve comments for DMA timeout calculation
  serial: sh-sci: Improve sampling rate readability
  serial: sh-sci: Make sci_irq_desc[] const
  serial: sh-sci: Make sci_regmap[] const
  serial: sh-sci: Remove useless memory allocation failure printks
  serial: sh-sci: Use DMA submission helpers instead of open-coding
  serial: sh-sci: Switch to generic DMA residue handling
  serial: sh-sci: Stop acknowledging DMA transmit completions
  serial: sh-sci: Fix race condition between RX work_struct and cleanup
  serial: sh-sci: Stop TX and RX on shutdown
  serial: sh-sci: Simplify sci_submit_rx() error handling
  serial: sh-sci: Do not resubmit DMA descriptors
  serial: sh-sci: Pass scatterlist to sci_dma_rx_push()
  serial: sh-sci: Add (H)SCIF DMA support

Kazuya Mizuguchi (2):
  serial: sh-sci: Fix exclusion of work_fn_rx and sci_dma_rx_complete
  serial: sh-sci: Remove schedule_work in sci_dma_rx_complete

 drivers/tty/serial/Kconfig  |   2 +-
 drivers/tty/serial/sh-sci.c | 492 +++++++++++++++++++++++++++-----------------
 drivers/tty/serial/sh-sci.h |  35 +---
 3 files changed, 308 insertions(+), 221 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
