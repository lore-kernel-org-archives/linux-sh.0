From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 20 Jan 2015 01:43:29 +0000
Subject: Re: [PATCH 0/2 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87y4oyb4zu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod, Arnd, Simon

# I added Arnd

> These are Audio DMAC peri peri v4 patches.
> 1) removes old drivers, and 2) replaces it.
> These are based on vinod/topic/rcar
> 
> Kuninori Morimoto (2):
> 	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
> 	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2

There is no response from Vinod about these patches.
So, I re-send these again.

This time I added SoC/platform side setting patches too (= 3) - 6)).
SoC/platform side setting needs many entries for this rcar-audmapp,
because it has many combinations.
But, I believe this is very normal DMAEngine style, not special.

Kuninori Morimoto (6):
      1) dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
      2) dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
      3) ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
      4) ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI
      5) ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
      6) ARM: shmobile: r8a7791: sound enables Audio DMAC peri peri entry on DTSI

 arch/arm/boot/dts/r8a7790.dtsi                 |  154 +++++++++
 arch/arm/boot/dts/r8a7791.dtsi                 |  154 +++++++++
 drivers/dma/sh/Kconfig                         |   13 +-
 drivers/dma/sh/Makefile                        |    2 +-
 drivers/dma/sh/rcar-audmapp.c                  |  420 +++++++++++-------------
 include/linux/platform_data/dma-rcar-audmapp.h |   34 --
 6 files changed, 514 insertions(+), 263 deletions(-)


Best regards
---
Kuninori Morimoto
