From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 08 Jan 2015 01:43:16 +0000
Subject: [PATCH 0/2 v4] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87oaqat5b9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

These are Audio DMAC peri peri v4 patches.
1) removes old drivers, and 2) replaces it.
These are based on vinod/topic/rcar

Kuninori Morimoto (2):
	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2

drivers/dma/sh/Kconfig                         |   13 +-
drivers/dma/sh/Makefile                        |    2 +-
drivers/dma/sh/rcar-audmapp.c                  |  420 +++++++++++-------------
include/linux/platform_data/dma-rcar-audmapp.h |   34 --
4 files changed, 206 insertions(+), 263 deletions(-)
