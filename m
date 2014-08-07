From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 07 Aug 2014 12:07:43 +0000
Subject: [PATCH 2/2] spi: sh-msiof: Fix transmit-only DMA transfers
Message-Id: <1407413263-20177-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdUd3OKqDwhLSCMW-rEQSnWky+saN5TgC005rkmNPfEL+g@mail.gmail.com>
 <1407413263-20177-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1407413263-20177-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Fix tx/rx mixup, which broke transmit-only transfers.

Introduced by commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
("spi: sh-msiof: Fix leaking of unused DMA descriptors").

Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Feel free to fold into commit 4240305f7cbdc7782aa8bc40cc702775d9ac0839
("spi: sh-msiof: Fix leaking of unused DMA descriptors")
---
 drivers/spi/spi-sh-msiof.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0d9ccd0953de..5ee13a2d93df 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -689,9 +689,9 @@ static int sh_msiof_dma_once(struct sh_msiof_spi_priv *p, const void *tx,
 	reinit_completion(&p->done);
 
 	/* Now start DMA */
-	if (tx)
-		dma_async_issue_pending(p->master->dma_rx);
 	if (rx)
+		dma_async_issue_pending(p->master->dma_rx);
+	if (tx)
 		dma_async_issue_pending(p->master->dma_tx);
 
 	ret = sh_msiof_spi_start(p, rx);
-- 
1.9.1

