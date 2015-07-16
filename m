From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:49 +0000
Subject: [PATCH/RFC v2 18/29] serial: sh-sci: Remove useless memory allocation failure printks
Message-Id: <1437070920-28069-19-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Printing an error on memory allocation failures is unnecessary.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7589e9b33ce346f0..6eb24f72e89906bb 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1170,11 +1170,8 @@ static int sci_request_irq(struct sci_port *port)
 		desc = sci_irq_desc + i;
 		port->irqstr[j] = kasprintf(GFP_KERNEL, "%s:%s",
 					    dev_name(up->dev), desc->desc);
-		if (!port->irqstr[j]) {
-			dev_err(up->dev, "Failed to allocate %s IRQ string\n",
-				desc->desc);
+		if (!port->irqstr[j])
 			goto out_nomem;
-		}
 
 		ret = request_irq(irq, desc->handler, up->irqflags,
 				  port->irqstr[j], port);
@@ -2621,10 +2618,8 @@ sci_parse_dt(struct platform_device *pdev, unsigned int *dev_id)
 	info = match->data;
 
 	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
-	if (!p) {
-		dev_err(&pdev->dev, "failed to allocate DT config data\n");
+	if (!p)
 		return NULL;
-	}
 
 	/* Get the line number for the aliases node. */
 	id = of_alias_get_id(np, "serial");
-- 
1.9.1

