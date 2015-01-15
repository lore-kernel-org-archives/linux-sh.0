From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 15 Jan 2015 08:10:51 +0000
Subject: Re: [PATCH 0/2 v4] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <87mw5ktqdl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oaqat5b9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oaqat5b9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod

ping ?

> These are Audio DMAC peri peri v4 patches.
> 1) removes old drivers, and 2) replaces it.
> These are based on vinod/topic/rcar
> 
> Kuninori Morimoto (2):
> 	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
> 	dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
> 
> drivers/dma/sh/Kconfig                         |   13 +-
> drivers/dma/sh/Makefile                        |    2 +-
> drivers/dma/sh/rcar-audmapp.c                  |  420 +++++++++++-------------
> include/linux/platform_data/dma-rcar-audmapp.h |   34 --
> 4 files changed, 206 insertions(+), 263 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
