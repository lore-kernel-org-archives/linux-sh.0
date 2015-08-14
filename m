From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 14 Aug 2015 13:53:07 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7778: enable IRLM setup via DT
Message-Id: <1439560388-5061-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Works the same as on r8a7779.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778.dtsi            | 3 ++-
 drivers/irqchip/irq-renesas-intc-irqpin.c | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4b1fa9f..4b0acae23 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -78,7 +78,8 @@
 			<0xfe780010 4>,
 			<0xfe780024 4>,
 			<0xfe780044 4>,
-			<0xfe780064 4>;
+			<0xfe780064 4>,
+			<0xfe780000 4>;
 		interrupts =   <0 27 IRQ_TYPE_LEVEL_HIGH
 				0 28 IRQ_TYPE_LEVEL_HIGH
 				0 29 IRQ_TYPE_LEVEL_HIGH
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

