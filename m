From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 17 Feb 2015 01:46:17 +0000
Subject: [PATCH 0/9 v5] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <873865tiks.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

These are v5 of shdma-base fixup patches.
Original patch came from Arnd.
I added Arnd/Ulf/Mark's Acked-by if it got it in pervious patch-set.

These are based on latest linus/master + vinod/next

This v5 removed rsnd driver's fixup to avoid conflict.
Because Audio DMAC peri peri driver will be moved from current
drivers/dma/sh/rcar-audmapp.c to sound/soc/sh/rcar/.
Then, sound/soc/sh/rcar/ side will have many patches for DMA.
Same fixup will be done in sound driver side.

Arnd Bergmann (4):
      dmaengine: shdma: use normal interface for passing slave id
      mtd: sh_flctl: remove slave_id settings for DMAEngine
      spi: rspi: remove slave_id settings for DMAEngine
      spi: sh-msiof: remove slave_id settings for DMAEngine

Kuninori Morimoto (4):
      mmc: sh_mmcif: remove slave_id settings for DMAEngine
      mmc: tmio_mmc: remove slave_id settings for DMAEngine
      ASoC: fsi: remove slave_id settings for DMAEngine
      ASoC: fsi: Configure DMA slave settings

 drivers/dma/sh/shdma-base.c       |   73 +++++++++++++++++++++++++++----------
 drivers/mmc/host/sh_mmcif.c       |   13 +++----
 drivers/mmc/host/sh_mobile_sdhi.c |    2 -
 drivers/mmc/host/tmio_mmc.h       |    2 -
 drivers/mmc/host/tmio_mmc_dma.c   |    4 --
 drivers/mtd/nand/sh_flctl.c       |    2 -
 drivers/spi/spi-rspi.c            |    1 -
 drivers/spi/spi-sh-msiof.c        |    1 -
 include/linux/shdma-base.h        |    1 +
 sound/soc/sh/fsi.c                |   18 ++++++---
 10 files changed, 72 insertions(+), 45 deletions(-)

Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
