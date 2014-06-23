From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 23 Jun 2014 00:54:19 +0000
Subject: Re: [PATCH 0/10 v2] ASoC: rsnd: fixup and DT support patches
Message-Id: <8761jstphc.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org


Hi Mark

These are v2 patches of R-Car sound fixup and DMA DT support patches.
These are based on 

      mark/fix/rcar + mark/topic/rcar

Kuninori Morimoto (10):
      ASoC: fsi: use SNDRV_DMA_TYPE_DEV for sound buffer
      ASoC: fsi: add fsi_pointer_update() for common pointer method
      ASoC: fsi: use dmaengine_prep_dma_cyclic() for DMA transfer
      ASoC: rsnd: SSI + DMA can select BUSIF
      ASoC: rsnd: use dmaengine_prep_dma_cyclic() instead of original method
      ASoC: rsnd: enable DVC when capture
      ASoC: rsnd: enable SRC setting via DT
      ASoC: rsnd: DMA cleanup for flexible SSI/SRC selection
      ASoC: rsnd: DMA start address is properly used for each DMAC
      ASoC: rsnd: add DT support to DVC

 .../devicetree/bindings/sound/renesas,rsnd.txt     |   11 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    4 +
 arch/arm/mach-shmobile/board-kzm9g.c               |    2 +
 arch/arm/mach-shmobile/board-mackerel.c            |    4 +
 arch/sh/boards/mach-ecovec24/setup.c               |    2 +
 include/sound/rcar_snd.h                           |    1 +
 sound/soc/sh/fsi.c                                 |  189 ++++++--------------
 sound/soc/sh/rcar/core.c                           |  154 ++++++++--------
 sound/soc/sh/rcar/dvc.c                            |   50 +++++-
 sound/soc/sh/rcar/gen.c                            |  109 +++++------
 sound/soc/sh/rcar/rsnd.h                           |   22 +--
 sound/soc/sh/rcar/src.c                            |   51 ++++--
 sound/soc/sh/rcar/ssi.c                            |   33 +++-
 13 files changed, 331 insertions(+), 301 deletions(-)
