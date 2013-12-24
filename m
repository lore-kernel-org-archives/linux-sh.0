From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 24 Dec 2013 14:14:21 +0000
Subject: [PATCH 04/11] serial: sh-sci: Remove duplicate interrupt check in verify port op
Message-Id: <b5e17b71c6b2ff284b4018e272e18876ccfa9b2c.1387887969.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1387887969.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1387887969.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The driver checks if the interrupt number is greater than nr_irqs and
returns an error in that case. The same check is already performed by
the caller, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f2fad4d..8c17d55 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2120,7 +2120,7 @@ static int sci_verify_port(struct uart_port *port, struct serial_struct *ser)
 {
 	struct sci_port *s = to_sci_port(port);
 
-	if (ser->irq != s->cfg->irqs[SCIx_TXI_IRQ] || ser->irq > nr_irqs)
+	if (ser->irq != s->cfg->irqs[SCIx_TXI_IRQ])
 		return -EINVAL;
 	if (ser->baud_base < 2400)
 		/* No paper tape reader for Mitch.. */
-- 
1.8.4

