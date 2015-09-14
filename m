From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 14 Sep 2015 12:14:36 +0000
Subject: [PATCH 14/14] serial: sh-sci: Drop the sci_fck clock fallback
Message-Id: <1442232876-27629-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All platforms that used to define an sci_fck clock have now switched to
the fck name. Remove the fallback code.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 56e4b2639d99..0d270c93d705 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2192,11 +2192,6 @@ static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
 	if (!IS_ERR(sci_port->fclk))
 		return 0;
 
-	/* SH has historically named the clock "sci_fck". */
-	sci_port->fclk = clk_get(dev, "sci_fck");
-	if (!IS_ERR(sci_port->fclk))
-		return 0;
-
 	/*
 	 * Not all SH platforms declare a clock lookup entry for SCI devices, in
 	 * which case we need to get the global "peripheral_clk" clock.
-- 
2.4.6

