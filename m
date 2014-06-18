From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 18 Jun 2014 08:53:48 +0000
Subject: [PATCH 0/12] ASoC: rsnd: fixup and DT support patches
Message-Id: <87d2e6zjhf.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Simon <horms@verge.net.au>, linux-sh@vger.kernel.org


Hi Mark

These are R-Car sound fixup and DMA DT support patches.
#1 #2 are bug fix patches.
other patches adds DMA DT support to sound driver.

I already posted some of these patches,
but, merged into this patch-set

Kuninori Morimoto (12):
      ASoC: rsnd: fixup rsnd_gen_dma_addr() for Gen1
      ASoC: rsnd: fixup loop exit timing of dma name search
      ASoC: rsnd: SSI + DMA can select BUSIF
      ASoC: fsi: use SNDRV_DMA_TYPE_DEV for sound buffer
      ASoC: fsi: add fsi_pointer_update() for common pointer method
      ASoC: fsi: use dmaengine_prep_dma_cyclic() for DMA transfer
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
 sound/soc/sh/rcar/core.c                           |  158 ++++++++--------
 sound/soc/sh/rcar/dvc.c                            |   50 +++++-
 sound/soc/sh/rcar/gen.c                            |  110 +++++++-----
 sound/soc/sh/rcar/rsnd.h                           |   22 +--
 sound/soc/sh/rcar/src.c                            |   51 ++++--
 sound/soc/sh/rcar/ssi.c                            |   33 +++-
 13 files changed, 339 insertions(+), 298 deletions(-)


Best regards
---
Kuninori Morimoto
