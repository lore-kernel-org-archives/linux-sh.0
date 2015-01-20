From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Jan 2015 04:14:42 +0000
Subject: Re: [PATCH 0/8 v2] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <87lhkyaxzs.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod
Cc Arnd, Ulf, Brian, Mark

These are v2 of shdma-base fixup patches.
Original patch came from Arnd, and, I tidyuped/tested on real board.

Arnd
	can you please check these patches ?

Brian
	can you please check 2) these patches ?

Ulf
	can you please check 5) 6) patches ?

Mark
	can you please check 3) 4) 7) 8) patches ?

I don't know who/how to merge these patches, but,
5) 6) patches needs Vinod's next branch and Ulf's next branch.

Arnd Bergmann (4):
      1) dmaengine: shdma: use normal interface for passing slave id
      2) mtd: sh_flctl: remove slave_id settings for DMAEngine
      3) spi: rspi: remove slave_id settings for DMAEngine
      4) spi: sh-msiof: remove slave_id settings for DMAEngine

Kuninori Morimoto (4):
      5) mmc: sh_mmcif: remove slave_id settings for DMAEngine
      6) mmc: tmio_mmc: remove slave_id settings for DMAEngine
      7) ASoC: fsi: remove slave_id settings for DMAEngine
      8) ASoC: rsnd: remove slave_id settings for DMAEngine

 drivers/dma/sh/shdma-base.c       |   73 +++++++++++++++++++++++++++----------
 drivers/mmc/host/sh_mmcif.c       |   12 +++---
 drivers/mmc/host/sh_mobile_sdhi.c |    2 -
 drivers/mmc/host/tmio_mmc.h       |    2 -
 drivers/mmc/host/tmio_mmc_dma.c   |    4 --
 drivers/mtd/nand/sh_flctl.c       |    2 -
 drivers/spi/spi-rspi.c            |    1 -
 drivers/spi/spi-sh-msiof.c        |    1 -
 include/linux/shdma-base.h        |    1 +
 sound/soc/sh/fsi.c                |    3 +-
 sound/soc/sh/rcar/core.c          |    3 +-
 11 files changed, 61 insertions(+), 43 deletions(-)


Best regards
---
Kuninori Morimoto
