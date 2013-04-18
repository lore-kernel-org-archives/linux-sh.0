From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Apr 2013 06:41:30 +0000
Subject: [PATCH 2/3] ARM: shmobile: add GPIO IRQ macro
Message-Id: <87d2tss5m1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R-Car series gpio_rcar driver can control GPIO IRQ today.
It needs base IRQ number for gpio_rcar_config :: .irq_base
This patch adds macro for GPIO IRQ.
This patch was tested on Bock-W board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/irqs.h |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/irqs.h b/arch/arm/mach-shmobile/include/mach/irqs.h
index b2074e2..d241bfd 100644
--- a/arch/arm/mach-shmobile/include/mach/irqs.h
+++ b/arch/arm/mach-shmobile/include/mach/irqs.h
@@ -16,4 +16,9 @@
 #define IRQPIN_BASE		2000
 #define irq_pin(nr)		((nr) + IRQPIN_BASE)
 
+/* GPIO IRQ */
+#define _GPIO_IRQ_BASE		2500
+#define GPIO_IRQ_BASE(x)	(_GPIO_IRQ_BASE + (32 * x))
+#define GPIO_IRQ(x, y)		(_GPIO_IRQ_BASE + (32 * x) + y)
+
 #endif /* __ASM_MACH_IRQS_H */
-- 
1.7.9.5

