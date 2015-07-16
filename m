From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 16 Jul 2015 18:21:47 +0000
Subject: [PATCH/RFC v2 16/29] serial: sh-sci: Make sci_irq_desc[] const
Message-Id: <1437070920-28069-17-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/sh-sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 3b29489bc0805a7c..1c0d337cbea1ad99 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1108,7 +1108,7 @@ static int sci_notifier(struct notifier_block *self,
 	return NOTIFY_OK;
 }
 
-static struct sci_irq_desc {
+static const struct sci_irq_desc {
 	const char	*desc;
 	irq_handler_t	handler;
 } sci_irq_desc[] = {
@@ -1150,7 +1150,7 @@ static int sci_request_irq(struct sci_port *port)
 	int i, j, ret = 0;
 
 	for (i = j = 0; i < SCIx_NR_IRQS; i++, j++) {
-		struct sci_irq_desc *desc;
+		const struct sci_irq_desc *desc;
 		int irq;
 
 		if (SCIx_IRQ_IS_MUXED(port)) {
-- 
1.9.1

