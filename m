From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Dec 2014 04:33:26 +0000
Subject: Re: [PATCH 0/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87y4qgnmxm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

These patches are for new R-Car Audio DMAC peri peri driver.
Upstream kernel already has this driver which is based on
SH-DMA-BASE. but it has DMAEngine handling issue if multi DMAEngines
are probed from DT boot.
If we modify SH-DMA-BASE driver, it is very difficult to keeping compatibility
for non-DT / DT.

Thus, 1st patch simply removed current driver, and 2nd patch adds new driver.

Kuninori Morimoto (2):
      dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
      dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2

 drivers/dma/sh/Kconfig                         |    3 +-
 drivers/dma/sh/rcar-audmapp.c                  |  406 +++++++++++-------------
 include/linux/platform_data/dma-rcar-audmapp.h |   34 --
 3 files changed, 186 insertions(+), 257 deletions(-)

