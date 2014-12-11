From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Dec 2014 01:22:34 +0000
Subject: [PATCH 0/2 v3] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87ppbr9dzq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

These are v3 of rcar-audmapp rework patches.
rcar-audmapp is very simple DMAC.
 - usage is very limited
 - no interrupt
rcar-audmapp works with rcar-dma, and almost all settings
are done under rcar-dma side.
These are based on topic/slave_caps_device_control_fix

Kuninori Morimoto (2):
      dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
      dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2

 drivers/dma/sh/Kconfig                         |    3 +-
 drivers/dma/sh/rcar-audmapp.c                  |  416 +++++++++++-------------
 include/linux/platform_data/dma-rcar-audmapp.h |   34 --
 3 files changed, 196 insertions(+), 257 deletions(-)
