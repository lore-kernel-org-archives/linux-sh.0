From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 19 Nov 2013 14:02:07 +0000
Subject: [PATCH v3 06/29] serial: sh-sci: Don't check IRQ in verify port operation
Message-Id: <1384869751-9786-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1384869751-9786-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Paul Mundt <lethal@linux-sh.org>

The IRQ number can't be modified by the user as the port is fixed.
There's no need to check the new IRQ number as it will be ignored by the
core.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 47b0ee6..b0c9d24 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2113,10 +2113,6 @@ static void sci_config_port(struct uart_port *port, int flags)
 
 static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
-	struct sci_port *s = to_sci_port(port);
-
-	if (ser->irq != s->cfg->irqs[SCIx_TXI_IRQ])
-		return -EINVAL;
 	if (ser->baud_base < 2400)
 		/* No paper tape reader for Mitch.. */
 		return -EINVAL;
-- 
1.8.3.2

