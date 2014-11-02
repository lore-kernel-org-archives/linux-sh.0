From: Kevin Cernekee <cernekee@gmail.com>
Date: Sun, 02 Nov 2014 01:03:51 +0000
Subject: [PATCH V3 04/14] genirq: Generic chip: Add big endian I/O accessors
Message-Id: <1414890241-9938-5-git-send-email-cernekee@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
In-Reply-To: <1414890241-9938-1-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net, ralf@linux-mips.org
Cc: linux-sh@vger.kernel.org, sergei.shtylyov@cogentembedded.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org

Use io{read,write}32be if the caller specified IRQ_GC_BE_IO when creating
the irqchip.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 include/linux/irq.h       |  1 +
 kernel/irq/generic-chip.c | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a514ef7..48b364e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -742,6 +742,7 @@ enum irq_gc_flags {
 	IRQ_GC_INIT_NESTED_LOCK		= 1 << 1,
 	IRQ_GC_MASK_CACHE_PER_TYPE	= 1 << 2,
 	IRQ_GC_NO_MASK			= 1 << 3,
+	IRQ_GC_BE_IO			= 1 << 4,
 };
 
 /*
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index db458c6..61024e8 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -191,6 +191,16 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
+static u32 irq_readl_be(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void irq_writel_be(u32 val, void __iomem *addr)
+{
+	iowrite32be(val, addr);
+}
+
 static void
 irq_init_generic_chip(struct irq_chip_generic *gc, const char *name,
 		      int num_ct, unsigned int irq_base,
@@ -300,7 +310,13 @@ int irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 		dgc->gc[i] = gc = tmp;
 		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
 				      NULL, handler);
+
 		gc->domain = d;
+		if (gcflags & IRQ_GC_BE_IO) {
+			gc->reg_readl = &irq_readl_be;
+			gc->reg_writel = &irq_writel_be;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
-- 
2.1.1

