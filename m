From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 26 Feb 2015 10:43:32 +0000
Subject: [PATCH] irqchip: renesas-irqc: Use u32 to store 32-bit register values
Message-Id: <1424947412-8061-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-irqc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 384e6ed61d7c5e94..2ea3412fdf8cc668 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -94,7 +94,7 @@ static int irqc_irq_set_type(struct irq_data *d, unsigned int type)
 	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
 	int hw_irq = irqd_to_hwirq(d);
 	unsigned char value = irqc_sense[type & IRQ_TYPE_SENSE_MASK];
-	unsigned long tmp;
+	u32 tmp;
 
 	irqc_dbg(&p->irq[hw_irq], "sense");
 
@@ -112,7 +112,7 @@ static irqreturn_t irqc_irq_handler(int irq, void *dev_id)
 {
 	struct irqc_irq *i = dev_id;
 	struct irqc_priv *p = i->p;
-	unsigned long bit = BIT(i->hw_irq);
+	u32 bit = BIT(i->hw_irq);
 
 	irqc_dbg(i, "demux1");
 
-- 
1.9.1

