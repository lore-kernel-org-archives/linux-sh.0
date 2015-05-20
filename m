From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 May 2015 18:06:06 +0000
Subject: [PATCH/RFC 0/8] serial: sh-sci: Add DT DMA support
Message-Id: <1432145174-11534-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi all,

This patch series contains various updates for the Renesas
(H)SCI(F{,A,B}) driver:
  - Patches 1 and 2 fix two DMA-related bugs,
  - Patches 3-6 perform some cleanups,
  - Patch 7 improves error messages,
  - Patch 8 adds DT support to the DMA setup.

This series is marked "RFC" and sent to a limited audience because DMA
isn't working well yet, at least not on r8a7791/koelsch.
Especially the last patch should not be applied before all critical
issues are fixed.

With a modified version of "[PATCH/RFC] serial: sh-sci: Add R-Car SCIF
DMA receive support" applied on top, TX DMA seems to work fine on SCIF,
SCIFA, SCIFB, and HSCIF, but RX DMA is still broken.

This series is against next-20150520, and depends on "[PATCH 0/4]
serial: sh-sci: Add DMA support to the DT binding" to enable DMA on
R-Car Gen2.

Thanks for your comments!

Geert Uytterhoeven (8):
  serial: sh-sci: Use correct device for DMA mapping with IOMMU
  [RFC] serial: sh-sci: Fix scatterlist mapping leak
  serial: sh-sci: Use min_t()/max_t() instead of casts
  serial: sh-sci: Use SCIF_DR instead of hardcoded 1
  serial: sh-sci: Use offset_in_page() helper instead of open coding
  serial: sh-sci: Use sg_init_one() helper instead of open coding
  serial: sh-sci: Improve DMA error messages
  [RFC] serial: sh-sci: Add DT support to DMA setup

 drivers/tty/serial/sh-sci.c | 137 +++++++++++++++++++++++++++-----------------
 1 file changed, 85 insertions(+), 52 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
