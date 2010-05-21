From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 21 May 2010 15:22:40 +0000
Subject: [PATCH] sh: fix Oops in the serial SCI driver
Message-Id: <Pine.LNX.4.64.1005211721030.8450@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>
Cc: linux-serial@vger.kernel.org

Fix an Oops, triggering, if the DMA buffer allocation for the Rx channel in
sh-sci.c fails.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/serial/sh-sci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 304a877..7b273c9 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -1007,8 +1007,9 @@ static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
 	s->chan_rx = NULL;
 	s->cookie_rx[0] = s->cookie_rx[1] = -EINVAL;
 	dma_release_channel(chan);
-	dma_free_coherent(port->dev, s->buf_len_rx * 2,
-			  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
+	if (sg_dma_address(&s->sg_rx[0]))
+		dma_free_coherent(port->dev, s->buf_len_rx * 2,
+				  sg_virt(&s->sg_rx[0]), sg_dma_address(&s->sg_rx[0]));
 	if (enable_pio)
 		sci_start_rx(port);
 }
-- 
1.6.2.4

