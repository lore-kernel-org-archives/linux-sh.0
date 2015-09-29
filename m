From: hamzahfrq.sub@gmail.com
Date: Tue, 29 Sep 2015 20:44:48 +0000
Subject: [PATCH v3 6/6] dma: rcar-dma: Fixed active descriptor initializing
Message-Id: <1443559488-2416-7-git-send-email-hamzahfrq.sub@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Muhammad Hamza Farooq <mfarooq@visteon.com>

Running descriptor pointer is set to NULL upon freeing resources. Other-
wise, rcar_dmac_issue_pending might not start new transfers

Signed-off-by: Muhammad Hamza Farooq <mfarooq@visteon.com>
---
 drivers/dma/sh/rcar-dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 6eec878..db97f7b 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -1042,6 +1042,7 @@ static void rcar_dmac_free_chan_resources(struct dma_chan *chan)
 	list_splice_init(&rchan->desc.active, &list);
 	list_splice_init(&rchan->desc.done, &list);
 	list_splice_init(&rchan->desc.wait, &list);
+	rchan->desc.running = NULL;
 
 	list_for_each_entry(desc, &list, node)
 		rcar_dmac_realloc_hwdesc(rchan, desc, 0);
-- 
1.9.1

