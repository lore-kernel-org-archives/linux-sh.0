From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Aug 2014 14:49:32 +0000
Subject: [PATCH] irqchip: renesas-intc-irqpin: Add suspend-to-RAM wake up support
Message-Id: <1408546172-22484-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Set the ->irq_enable() and ->irq_disable() methods to NULL to enable
lazy disable of interrupts, and set IRQCHIP_MASK_ON_SUSPEND to tell the
core that only IRQs marked as wake-ups need to stay enabled during
suspend-to-RAM.

This makes wake-up by gpio-keys from suspend-to-RAM work on
r8a7740/Armadillo.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not tested on sh73a0/kzm9g, r8a7778/bock-w, r8a7779/marzen

Similar changes for gpio-rcar and renesas-irqc went in before, but
split in two parts:
  - commit 272012d0f748de2e ("irqchip: renesas-irqc: Use lazy disable")
  - commit 6a7e3b3007b5396a ("irqchip: renesas-irqc: Enable mask on suspend")
  - commit fba968a1e6b84be0 ("gpio: rcar: Use lazy disable")
  - commit 403961120667bed7 ("gpio: rcar: Enable mask on suspend")

However, I believe it doesn't make much sense to split this:
  - Enabling lazy disable on its own introduces a regression, as it
    causes the system to wake-up on IRQs not marked as wake-ups,
  - Adding IRQCHIP_MASK_ON_SUSPEND on its own doesn't have any impact.
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 3ee78f02e5d7..a9efceb0c4a0 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -454,10 +454,8 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	irq_chip->name = name;
 	irq_chip->irq_mask = disable_fn;
 	irq_chip->irq_unmask = enable_fn;
-	irq_chip->irq_enable = enable_fn;
-	irq_chip->irq_disable = disable_fn;
 	irq_chip->irq_set_type = intc_irqpin_irq_set_type;
-	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE;
+	irq_chip->flags	= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MASK_ON_SUSPEND;
 
 	p->irq_domain = irq_domain_add_simple(pdev->dev.of_node,
 					      p->number_of_irqs,
-- 
1.9.1

