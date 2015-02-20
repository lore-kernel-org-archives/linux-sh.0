From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 20 Feb 2015 10:21:10 +0000
Subject: [PATCH 0/24 v2] ASoC: rsnd: move 2nd DMAC in rsnd driver and subnode dma-name support
Message-Id: <87fva0opax.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Liam Girdwood <lgirdwood@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, dmaengine@vger.kernel.org


Hi Mark, Arnd, Vinod
Cc: Laurent, SH-ML

These patches add Audio DMAC peri peri implementation in rsnd driver.
I will remove current DMAEngine side Audio DMAC peri peri implement
if these are accepted.
http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusC829

Arnd, Vinod

This series adds subnode DT support for 1st DMAC, and it is based
on 1) patch. can you please check it ?

Mark

Actually, 1) patch has no relationship until 20).
I guess this patch-set has merge issue.
Can you check 2) - 19) as 1st step ?

  1)       : export of_dma_request_slave_channel() for 20)
  2) -  6) : cleanup / tidyup
  7) - 12) : Audio DMAC peri peri implementation
 13) - 14) : cleanup. these are no longer needed now
 15) - 19) : prepare for 1st DMAC dma-names subnode support
 20)       : 1st DMAC dma-names subnode subnode
 21) - 24) : DT bindings text update


Kuninori Morimoto (24):
       1) dmaengine: export symbol of of_dma_request_slave_channel()
       2) ASoC: rsnd: remove SH-DMA-BASE specific implementation
       3) ASoC: rsnd: remove un-needed parameter from rsnd_dma_init()
       4) ASoC: rsnd: remove unused rsnd_dma_available()
       5) ASoC: rsnd: remove un-needed parameter from rsnd_dma_quit()
       6) ASoC: rsnd: tidyup rsnd_dma_to_mod() macro declaration position
       7) ASoC: rsnd: enable to get resource by name
       8) ASoC: rsnd: add rsnd_gen_get_phy_addr() to get physical address
       9) ASoC: rsnd: add dma.c for Audio DMAC / Audio DMAC peri peri
      10) ASoC: rsnd: move rsnd_gen_dma_addr() from gen.c to dma.c
      11) ASoC: rsnd: enable to care 1st / 2nd DMAC on rsnd_dma_xxx()
      12) ASoC: rsnd: add Audio DMAC peri peri support rework
      13) ASoC: rsnd: remove rsnd_dma::addr
      14) ASoC: rsnd: remove rsnd_dma::dir
      15) ASoC: rsnd: use union with rsnd_dmaen / rsnd_dmapp
      16) ASoC: rsnd: enable rsnd_ssi_use_busif() for DMA
      17) ASoC: rsnd: ssi: add rsnd_ssi_of_node()
      18) ASoC: rsnd: src: add rsnd_src_of_node()
      19) ASoC: rsnd: dvc: add rsnd_dvc_of_node()
      20) ASoC: rsnd: 1st DMAC dma-names cares subnode
      21) ASoC: rsnd: add sample code of rcar_sound,src irq
      22) ASoC: rsnd: add sample code of missing clocks
      23) ASoC: rsnd: add sample code of dma entry
      24) ASoC: rsnd: add sample code of reg-names

 .../devicetree/bindings/sound/renesas,rsnd.txt     |  125 +++-
 drivers/dma/of-dma.c                               |    1 +
 include/linux/of_dma.h                             |    4 +-
 sound/soc/sh/rcar/Makefile                         |    2 +-
 sound/soc/sh/rcar/core.c                           |  235 +-------
 sound/soc/sh/rcar/dma.c                            |  603 ++++++++++++++++++++
 sound/soc/sh/rcar/dvc.c                            |   12 +
 sound/soc/sh/rcar/gen.c                            |  145 +----
 sound/soc/sh/rcar/rsnd.h                           |   72 ++-
 sound/soc/sh/rcar/src.c                            |   23 +-
 sound/soc/sh/rcar/ssi.c                            |   28 +-
 11 files changed, 838 insertions(+), 412 deletions(-)


Best regards
---
Kuninori Morimoto
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
