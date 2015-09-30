From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 30 Sep 2015 10:03:07 +0000
Subject: [PATCH] irqchip: renesas-intc-irqpin: r8a7778 IRLM setup support
Message-Id: <1443607387-19147-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20141215050920.533.20169.sendpatchset@w520>
In-Reply-To: <20141215050920.533.20169.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Works the same as on r8a7779.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 1b4e5cc9f7df9a0c..7f6cf19aa6ac00d7 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -359,14 +359,16 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 	.xlate  = irq_domain_xlate_twocell,
 };
 
-static const struct intc_irqpin_irlm_config intc_irqpin_irlm_r8a7779 = {
+static const struct intc_irqpin_irlm_config intc_irqpin_irlm_r8a777x = {
 	.irlm_bit = 23, /* ICR0.IRLM0 */
 };
 
 static const struct of_device_id intc_irqpin_dt_ids[] = {
 	{ .compatible = "renesas,intc-irqpin", },
+	{ .compatible = "renesas,intc-irqpin-r8a7778",
+	  .data = &intc_irqpin_irlm_r8a777x },
 	{ .compatible = "renesas,intc-irqpin-r8a7779",
-	  .data = &intc_irqpin_irlm_r8a7779 },
+	  .data = &intc_irqpin_irlm_r8a777x },
 	{},
 };
 MODULE_DEVICE_TABLE(of, intc_irqpin_dt_ids);
-- 
1.9.1

