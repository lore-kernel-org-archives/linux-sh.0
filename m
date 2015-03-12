From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 12 Mar 2015 00:39:01 +0000
Subject: [PATCH 0/2 v2] dmaengine: remove Renesas Audio DMAC peri peri
Message-Id: <87pp8ff3sb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Vinod, Arnd

These patches remove Renesas Audio DMAC peri peri driver,
and related Document/defconfigs.
I separated "driver" part and "defconfigs" part, because these
are independent.

Kuninori Morimoto (2):
      dmaengine: remove Renesas Audio DMAC peri peri
      ARM: configs: remove all CONFIG_RCAR_AUDMAC_PP from ARM defconfigs

 Documentation/devicetree/bindings/dma/rcar-audmapp.txt |  29 ---------
 arch/arm/configs/multi_v7_defconfig                    |   1 -
 drivers/dma/sh/Kconfig                                 |   6 --
 drivers/dma/sh/Makefile                                |   1 -
 drivers/dma/sh/rcar-audmapp.c                          | 376 ---------------------------------------------------------------------------------------------------------
 5 files changed, 413 deletions(-)


Best regards
---
Kuninori Morimoto
