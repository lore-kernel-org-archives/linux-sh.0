From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Dec 2014 03:25:39 +0000
Subject: [PATCH 2/2 v3] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87egrowgtq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw6v9dwc.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw6v9dwc.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

> > Current DMAEngine branch has fixup(?) branch, and we need to rebase to it.
> > And, this 2nd DMA needs 1st DMA which was created by Laurent.
> > So, I will send v3 patch if Laurent's DMA driver was accepted
> I have the PULL request from Laurent, should be able to process todays

Thank you for your help.
These are Audio DMAC peri peri v3 patches.
1) removes old drivers, and 2) replaces it.
These are based on vinod/topic/rcar

Kuninori Morimoto (2):
      1) dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
      2) dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2

 drivers/dma/sh/Kconfig                         |   13 +-
 drivers/dma/sh/Makefile                        |    2 +-
 drivers/dma/sh/rcar-audmapp.c                  |  416 +++++++++++-------------
 include/linux/platform_data/dma-rcar-audmapp.h |   34 --
 4 files changed, 202 insertions(+), 263 deletions(-)


Best regards
---
Kuninori Morimoto
