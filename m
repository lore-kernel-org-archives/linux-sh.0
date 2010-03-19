From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Mar 2010 13:53:36 +0000
Subject: [PATCH] SH: remove superfluous warning from the serial driver
Message-Id: <Pine.LNX.4.64.1003191453050.5412@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This warning has been introduced during the SCI DMA support developmenr and is
not needed any more.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/serial/sh-sci.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/sh-sci.c b/drivers/serial/sh-sci.c
index 7d6733f..be6bbb8 100644
--- a/drivers/serial/sh-sci.c
+++ b/drivers/serial/sh-sci.c
@@ -781,10 +781,6 @@ static irqreturn_t sci_mpxed_interrupt(int irq, void *ptr)
 	if ((ssr_status & SCxSR_BRK(port)) && err_enabled)
 		ret = sci_br_interrupt(irq, ptr);
 
-	WARN_ONCE(ret = IRQ_NONE,
-		  "%s: %d IRQ %d, status %x, control %x\n", __func__,
-		  irq, port->line, ssr_status, scr_status);
-
 	return ret;
 }
 
-- 
1.6.2.4

