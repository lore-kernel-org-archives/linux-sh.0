From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 19 Feb 2015 03:50:14 +0000
Subject: [PATCH 0/19] ASoC: rsnd: move 2nd DMAC from DMAEngine to rsnd driver
Message-Id: <87vbiy1rul.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>


Hi Mark, Arnd, Vinod
Cc: Laurent, SH-ML

Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
But, in result of DMA ML long term discussion, 2nd DMAC was concluded
that it is not a general purpose DMAC (2nd DMAC is for Device to Device
inside sound system). Additionally, current DMAEngine can't support Device
to Device, and we don't have correct DT bindings for it at this point.
So the easiest solution for it is that move it from DMAEngine to rsnd
driver.
http://thread.gmane.org/gmane.linux.ports.sh.devel/41063/focusC829

These patches add Audio DMAC peri peri implementation in rsnd driver.
I will remove current DMAEngine side Audio DMAC peri peri implement
if these are accepted.

Arnd, Vinod

I'm happy if you can send Ack for these patches


  1) -  5) are cleanup / tidyup rsnd driver
  6) - 11) adds Audio DMAC peri peri implementation in rsnd driver
 12)       change dma-names for 1st DMAC on DT
 13) - 14) cleanup. these are no longer needed now
 15) - 19) DT bindings text update

12) changes dma-names for 1st DMAC. It was assumed that 1st / 2nd
DMAC are used as DMAEngine. dma-names had same naming rule for
both DMAC to avoid complex DT mapping issue,
But now, 2nd DMAC is no longer DMAEngine, we don't need to use
this naming rule anymore.
Now, no SoC/platform is using DMA for rsnd driver yet in upstream.
I believe 12) is no problem for DT.

Kuninori Morimoto (19):
       1) ASoC: rsnd: remove SH-DMA-BASE specific implementation
       2) ASoC: rsnd: remove un-needed parameter from rsnd_dma_init()
       3) ASoC: rsnd: remove unused rsnd_dma_available()
       4) ASoC: rsnd: remove un-needed parameter from rsnd_dma_quit()
       5) ASoC: rsnd: tidyup rsnd_dma_to_mod() macro declaration position
       6) ASoC: rsnd: enable to get resource by name
       7) ASoC: rsnd: add rsnd_gen_get_phy_addr() to get physical address
       8) ASoC: rsnd: add dma.c for Audio DMAC / Audio DMAC peri peri
       9) ASoC: rsnd: move rsnd_gen_dma_addr() from gen.c to dma.c
      10) ASoC: rsnd: enable to care 1st / 2nd DMAC on rsnd_dma_xxx()
      11) ASoC: rsnd: add Audio DMAC peri peri support rework
      12) ASoC: rsnd: dma-names cares 1st DMAC only
      13) ASoC: rsnd: remove rsnd_dma::addr
      14) ASoC: rsnd: remove rsnd_dma::dir
      15) ASoC: rsnd: tidyup rcar_sound,ssi sample code
      16) ASoC: rsnd: add sample code of rcar_sound,src irq
      17) ASoC: rsnd: add sample code of reg-names
      18) ASoC: rsnd: add sample code of missing clocks
      19) ASoC: rsnd: add sample code of dma entry

 .../devicetree/bindings/sound/renesas,rsnd.txt     |  131 +++--
 sound/soc/sh/rcar/Makefile                         |    2 +-
 sound/soc/sh/rcar/core.c                           |  224 +-------
 sound/soc/sh/rcar/dma.c                            |  583 ++++++++++++++++++++
 sound/soc/sh/rcar/gen.c                            |  145 +----
 sound/soc/sh/rcar/rsnd.h                           |   50 +-
 sound/soc/sh/rcar/src.c                            |    5 +-
 sound/soc/sh/rcar/ssi.c                            |    5 +-
 8 files changed, 725 insertions(+), 420 deletions(-)



Best regards
---
Kuninori Morimoto
