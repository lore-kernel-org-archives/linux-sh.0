From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 22 Jan 2015 08:33:09 +0000
Subject: [PATCH 0/5 v6] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87bnlrkydd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod, Arnd, Simon

There is no response from Vinod,
and, I might have misunderstanding about this sound DMAC.
But, I send latest patch-set.
We don't need to replace rcar-audmapp if we can have Arnd's
short term bugfix patch.

Arnd Bergmann (1):
      dmaengine: shdma-base: enable to be non multiplexed DMAEngine driver

Kuninori Morimoto (4):
      ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC peri peri entry on DTSI

 arch/arm/boot/dts/r8a7790.dtsi |  154 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7791.dtsi |  154 ++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sh/rcar-hpbdma.c   |    1 +
 drivers/dma/sh/shdma-base.c    |   11 +++
 drivers/dma/sh/shdmac.c        |    1 +
 include/linux/shdma-base.h     |    1 +
 6 files changed, 322 insertions(+)


Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
