From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 03 Jun 2009 08:34:46 +0000
Subject: [PATCH] sh: intc compile warning fix
Message-Id: <20090603083446.28534.27711.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch fixes a compile warning in the intc code
for the CONFIG_SPARSE_IRQ=n case.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/sh/intc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- 0001/drivers/sh/intc.c
+++ work/drivers/sh/intc.c	2009-06-03 12:55:05.000000000 +0900
@@ -671,7 +671,7 @@ unsigned int intc_evt2irq(unsigned int v
 
 void __init register_intc_controller(struct intc_desc *desc)
 {
-	unsigned int i, k, smp, cpu = smp_processor_id();
+	unsigned int i, k, smp;
 	struct intc_desc_int *d;
 
 	d = alloc_bootmem(sizeof(*d));
@@ -778,7 +778,7 @@ void __init register_intc_controller(str
 			continue;
 
 #ifdef CONFIG_SPARSE_IRQ
-		irq_desc = irq_to_desc_alloc_cpu(irq, cpu);
+		irq_desc = irq_to_desc_alloc_cpu(irq, smp_processor_id());
 		if (unlikely(!irq_desc)) {
 			printk(KERN_INFO "can not get irq_desc for %d\n", irq);
 			continue;
