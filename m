From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 20 Aug 2015 15:45:54 +0000
Subject: [PATCH v2 1/3] irqchip: renesas-intc-irqpin: r8a7778 IRLM setup support
Message-Id: <1440085556-4340-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409212800-4957-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409212800-4957-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Works the same as on r8a7779.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 0670ab4..7f172a0 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -352,14 +352,16 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
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
2.4.6

