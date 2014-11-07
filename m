From: Kevin Cernekee <cernekee@gmail.com>
Date: Fri, 07 Nov 2014 06:44:18 +0000
Subject: [PATCH V4 03/14] genirq: Generic chip: Allow irqchip drivers to override irq_reg_{readl,writel}
Message-Id: <1415342669-30640-4-git-send-email-cernekee@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de, jason@lakedaemon.net, linux-sh@vger.kernel.org
Cc: arnd@arndb.de, f.fainelli@gmail.com, ralf@linux-mips.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org

Currently, these I/O accessors always assume little endian 32-bit
registers (readl/writel).  On some systems the IRQ registers need to be
accessed in BE mode or using 16-bit loads/stores, so we will provide a
way to override the default behavior.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/irq.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index ed1135d..0fecd95 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -686,6 +686,8 @@ struct irq_chip_type {
  * struct irq_chip_generic - Generic irq chip data structure
  * @lock:		Lock to protect register and cache data access
  * @reg_base:		Register base address (virtual)
+ * @reg_readl:		Alternate I/O accessor (defaults to readl if NULL)
+ * @reg_writel:		Alternate I/O accessor (defaults to writel if NULL)
  * @irq_base:		Interrupt base nr for this chip
  * @irq_cnt:		Number of interrupts handled by this chip
  * @mask_cache:		Cached mask register shared between all chip types
@@ -710,6 +712,8 @@ struct irq_chip_type {
 struct irq_chip_generic {
 	raw_spinlock_t		lock;
 	void __iomem		*reg_base;
+	u32			(*reg_readl)(void __iomem *addr);
+	void			(*reg_writel)(u32 val, void __iomem *addr);
 	unsigned int		irq_base;
 	unsigned int		irq_cnt;
 	u32			mask_cache;
@@ -818,13 +822,19 @@ static inline void irq_gc_unlock(struct irq_chip_generic *gc) { }
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

