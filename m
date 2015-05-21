From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 May 2015 03:47:33 +0000
Subject: [PATCH 0/4 v2] ASoC: rsnd: fixup interrupt / spin lock issue
Message-Id: <878ucitwyh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: Simon <horms@verge.net.au>, Nguyen Viet Dung <nv-dung@jinso.co.jp>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Laurent <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, sakato <ryusuke.sakato.bx@renesas.com>, dmaengine@vger.kernel.org


Hi Mark, Vinod
Cc Laurent, Hiep-san

These are v2 of fixup unknown interrupt issue patch which was reported by
Hiep-san in v4.1-rcX kernel. It was not happened in v4.0 because ARM
platform side couldn't use DMA transfer.

We tested these same as v1 patches, and confirmed these solved problem

Hiep-san, can you please re-test these patches ?

Kuninori Morimoto (4):
      1) dmaengine: rcar-dmac: fixup spinlock in rcar-dmac
      2) ASoC: rsnd: indicate unknown HW start
      3) ASoC: rsnd: add rsnd_dai_stream_quit()
      4) ASoC: rsnd: spin lock for interrupt handler

 drivers/dma/sh/rcar-dmac.c | 55 +++++++++++++++++++++++++++++++------------------------
 sound/soc/sh/rcar/core.c   | 25 ++++++++++++++++++-------
 sound/soc/sh/rcar/rsnd.h   |  3 +--
 sound/soc/sh/rcar/src.c    | 11 ++++++++---
 sound/soc/sh/rcar/ssi.c    | 18 ++++++++++++++----
 5 files changed, 72 insertions(+), 40 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
