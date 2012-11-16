From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Nov 2012 10:34:57 +0000
Subject: [PATCH 03/04] ARM: mach-shmobile: sh7372 INTC DT init cleanup
Message-Id: <20121116103457.4231.83000.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Rework the sh7372 DT INTC init code to reduce the number of #ifdefs.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the devel/of branch of
 git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

 arch/arm/mach-shmobile/intc-sh7372.c |   54 ++++++++++++----------------------
 1 file changed, 20 insertions(+), 34 deletions(-)

--- 0005/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2012-11-15 21:20:43.000000000 +0900
@@ -608,47 +608,29 @@ static void __iomem *intcs_ffd5;
 static void __iomem *intca_e694;
 static void __iomem *intca_e695;
 
-static void __init sh7372_init_irq__(bool of)
+static void __init sh7372_init_intc(resource_size_t intca0_start,
+				    resource_size_t intca1_start,
+				    resource_size_t intcs0_start,
+				    resource_size_t intcs1_start,
+				    unsigned short vect)
 {
 	void __iomem *intevtsa;
 	int n;
 
-#ifdef CONFIG_OF
-	if (of)
-		of_irq_init(irq_of_match);
-#endif
-
 	register_intc_controller(&intca_desc);
 	register_intc_controller(&intca_irq_pins_lo_desc);
 	register_intc_controller(&intca_irq_pins_hi_desc);
 	register_intc_controller(&intcs_desc);
 
-#ifdef CONFIG_OF
-	if (of) {
-		intca_e694 = IOMEM(intca_resources[0].start);
-		intca_e695 = IOMEM(intca_resources[1].start);
-
-		intcs_ffd2 = ioremap_nocache(intcs_resources[0].start,
-					     PAGE_SIZE);
-		intevtsa = intcs_ffd2 + 0x100;
-		intcs_ffd5 = ioremap_nocache(intcs_resources[1].start,
-					     PAGE_SIZE);
-
-		/* setup dummy cascade chip for INTCS */
-		n = evt2irq(intevtsa_vect);
-	} else
-#endif
-	{
-		intca_e694 = IOMEM(0xe6940000);
-		intca_e695 = IOMEM(0xe6950000);
-
-		intcs_ffd2 = ioremap_nocache(0xffd20000, PAGE_SIZE);
-		intevtsa = intcs_ffd2 + 0x100;
-		intcs_ffd5 = ioremap_nocache(0xffd50000, PAGE_SIZE);
-
-		/* setup dummy cascade chip for INTCS */
-		n = evt2irq(0xf80);
-	}
+	intca_e694 = IOMEM(intca0_start);
+	intca_e695 = IOMEM(intca1_start);
+
+	intcs_ffd2 = ioremap_nocache(intcs0_start, PAGE_SIZE);
+	intevtsa = intcs_ffd2 + 0x100;
+	intcs_ffd5 = ioremap_nocache(intcs1_start, PAGE_SIZE);
+
+	/* setup dummy cascade chip for INTCS */
+	n = evt2irq(vect);
 
 	irq_alloc_desc_at(n, numa_node_id());
 	irq_set_chip_and_handler_name(n, &dummy_irq_chip,
@@ -666,13 +648,17 @@ static void __init sh7372_init_irq__(boo
 #ifdef CONFIG_OF
 void __init sh7372_init_irq_of(void)
 {
-	sh7372_init_irq__(true);
+	of_irq_init(irq_of_match);
+
+	sh7372_init_intc(intca_resources[0].start, intca_resources[1].start,
+			  intcs_resources[0].start, intcs_resources[1].start,
+			  intevtsa_vect);
 }
 #endif
 
 void __init sh7372_init_irq(void)
 {
-	sh7372_init_irq__(false);
+	sh7372_init_intc(0xe6940000, 0xe6950000, 0xffd20000, 0xffd50000, 0xf80);
 }
 
 static unsigned short ffd2[0x200];
