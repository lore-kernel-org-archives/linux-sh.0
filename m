From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 01:57:53 +0000
Subject: [PATCH 0/1 v3] dmaengine: fixup DMA OF issue
Message-Id: <87io781oim.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

This patch is already posted to ML, and maintainer will merge it.
but, not yet happened
http://thread.gmane.org/gmane.linux.kernel/2023889

H3 Salvator-X might have compile issue if try sound

Kuninori Morimoto (1):
      dmaengine: OF DMAEngine API based on CONFIG_DMA_OF instead of CONFIG_OF

 include/linux/of_dma.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Best regards
---
Kuninori Morimoto
