From: Kevin Cernekee <cernekee@gmail.com>
Date: Sun, 02 Nov 2014 01:03:50 +0000
Subject: [PATCH V3 03/14] genirq: Generic chip: Allow irqchip drivers to override irq_reg_{readl,writel}
Message-Id: <1414890241-9938-4-git-send-email-cernekee@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, ralf@linux-mips.org
Cc: linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org

Currently, these I/O accessors always assume little endian 32-bit
registers (readl/writel).  On some systems the IRQ registers need to be
accessed in BE mode or using 16-bit loads/stores, so we will provide a
way to override the default behavior.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/irq.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 0743743..a514ef7 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/topology.h>
 #include <linux/wait.h>
+#include <linux/io.h>
 
 #include <asm/irq.h>
 #include <asm/ptrace.h>
@@ -709,6 +710,8 @@ struct irq_chip_type {
 struct irq_chip_generic {
 	raw_spinlock_t		lock;
 	void __iomem		*reg_base;
+	u32			(*reg_readl)(void __iomem *addr);
+	void			(*reg_writel)(u32 val, void __iomem *addr);
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
 	u32			mask_cache;
@@ -817,13 +820,19 @@ static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
 static inline void irq_reg_writel(struct irq_chip_generic *gc,
 				  u32 val, int reg_offset)
 {
-	writel(val, gc->reg_base + reg_offset);
+	if (gc->reg_writel)
+		gc->reg_writel(val, gc->reg_base + reg_offset);
+	else
+		writel(val, gc->reg_base + reg_offset);
 }
 
 static inline u32 irq_reg_readl(struct irq_chip_generic *gc,
 				int reg_offset)
 {
-	return readl(gc->reg_base + reg_offset);
+	if (gc->reg_readl)
+		return gc->reg_readl(gc->reg_base + reg_offset);
+	else
+		return readl(gc->reg_base + reg_offset);
 }
 
 #endif /* _LINUX_IRQ_H */
-- 
2.1.1

