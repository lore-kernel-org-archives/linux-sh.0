From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 29 Jan 2015 00:59:56 +0000
Subject: [PATCH 0/9 v4] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <87lhkmtn7c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874mrjmq76.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874mrjmq76.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod, Mark

These are v4 of shdma-base fixup patches.
Original patch came from Arnd.
I added Arnd/Ulf's Acked-by if it got it in pervious patch-set.

Mark
	Can you please check these patces ?
          3) 4)		: for SPI
          7) 8) 9)	: for ASoC

Vinod

5) 6) patches are based on Vinod's next branch + Ulf's
	git.linaro.org/people/ulf.hansson/mmc.git tmio

Easy way to merge these are maybe...
 Pattern 1) Vinod merges Ulf's tmio branch, and apply all these pathces
 Pattern 2) Vinod apply these patches except 5) 6), and Ulf merge Vinod's branch
            and apply 5) 6) patches

Arnd Bergmann (4):
      1) dmaengine: shdma: use normal interface for passing slave id
      2) mtd: sh_flctl: remove slave_id settings for DMAEngine
      3) spi: rspi: remove slave_id settings for DMAEngine
      4) spi: sh-msiof: remove slave_id settings for DMAEngine

Kuninori Morimoto (5):
      5) mmc: sh_mmcif: remove slave_id settings for DMAEngine
      6) mmc: tmio_mmc: remove slave_id settings for DMAEngine
      7) ASoC: rsnd: remove slave_id settings for DMAEngine
      8) ASoC: fsi: remove slave_id settings for DMAEngine
      9) ASoC: fsi: Configure DMA slave settings

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
 sound/soc/sh/rcar/core.c          |    3 +-
 11 files changed, 73 insertions(+), 47 deletions(-)

Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
