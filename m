From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 09 Nov 2013 12:18:01 +0000
Subject: [PATCH] irqchip: renesas-intc-irqpin: Fix register bitfield shift calculation
Message-Id: <1383999481-2742-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SENSE register bitfield position is incorrectly computed for SoCs
that use 2-bit IRQ sense fields. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 82cec63..3ee78f0 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -149,8 +149,9 @@ static void intc_irqpin_read_modify_write(struct intc_irqpin_priv *p,
 static void intc_irqpin_mask_unmask_prio(struct intc_irqpin_priv *p,
 					 int irq, int do_mask)
 {
-	int bitfield_width = 4; /* PRIO assumed to have fixed bitfield width */
-	int shift = (7 - irq) * bitfield_width; /* PRIO assumed to be 32-bit */
+	/* The PRIO register is assumed to be 32-bit with fixed 4-bit fields. */
+	int bitfield_width = 4;
+	int shift = 32 - (irq + 1) * bitfield_width;
 
 	intc_irqpin_read_modify_write(p, INTC_IRQPIN_REG_PRIO,
 				      shift, bitfield_width,
@@ -159,8 +160,9 @@ static void intc_irqpin_mask_unmask_prio(struct intc_irqpin_priv *p,
 
 static int intc_irqpin_set_sense(struct intc_irqpin_priv *p, int irq, int value)
 {
+	/* The SENSE register is assumed to be 32-bit. */
 	int bitfield_width = p->config.sense_bitfield_width;
-	int shift = (7 - irq) * bitfield_width; /* SENSE assumed to be 32-bit */
+	int shift = 32 - (irq + 1) * bitfield_width;
 
 	dev_dbg(&p->pdev->dev, "sense irq = %d, mode = %d\n", irq, value);
 
-- 
Regards,

Laurent Pinchart

