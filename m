From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 16 Jan 2015 02:24:01 +0000
Subject: [PATCH 0/1] dmaengine: shdma: use normal interface for passing slave id
Message-Id: <87ppafxy1f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Vinod
Cc Arnd, Ulf

This patch uses normal interface for passing slave ID on shdma-base
and, its user drivers.
Original patch came from Arnd, and, I tidyuped/tested on real board.
Renesas MMC driver was updated on Ulf's branch today, so, this patch
is based on both
 - Vinod branch
	git://git.infradead.org/users/vkoul/slave-dma.git :: next
 - Ulf branch
	git://git.linaro.org/people/ulf.hansson/mmc.git :: next

I tested this patch on BockW board.

Arnd
  Can you please re-check this patch ?

Ulf
  Please let us know if you have stable (?) base branch

Best regards
---
Kuninori Morimoto
