From: Rich Felker <dalias@libc.org>
Date: Thu, 13 Oct 2016 20:35:30 +0000
Subject: [PATCH v3] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <f18cec30bc17e3f52e478dd9f6714bfab02f227f.1476390724.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>

The J-Core AIC does not have separate interrupt numbers reserved for
cpu-local vs global interrupts. Instead, the driver requesting the irq
is expected to know whether its device uses per-cpu interrupts or not.
Previously it was assumed that handle_simple_irq could work for both
cases, but it intentionally drops interrupts for an irq number that
already has a handler running. This resulted in the timer interrupt
for one cpu being lost when multiple cpus' timers were set for
approximately the same expiration time, leading to stalls. In theory
the same could also happen with IPIs.

To solve the problem, instead of registering handle_simple_irq as the
handler, register a wrapper function which checks whether the irq to
be handled was requested as per-cpu or not, and passes it to
handle_simple_irq or handle_percpu_irq accordingly.

Signed-off-by: Rich Felker <dalias@libc.org>
---

I've reverted to conditionally using handle_percpu_irq or
handle_simple_irq, like the v1 patch, but with Thomas Gleixner's
suggestion to make the check less costly. No failures were observed
with the v2 patch but I'd rather have the fix be safe/future-proof
than save a few cycles.

---
 drivers/irqchip/irq-jcore-aic.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5e5e3bb..ed4d233 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -25,12 +25,30 @@
 
 static struct irq_chip jcore_aic;
 
+/*
+ * The J-Core AIC1 and AIC2 are cpu-local interrupt controllers and do
+ * not distinguish or use distinct irq number ranges for per-cpu event
+ * interrupts (timer, IPI). Since information to determine whether a
+ * particular irq number should be treated as per-cpu is not available
+ * at mapping time, we use a wrapper handler function which chooses
+ * the right handler at runtime based on whether IRQF_PERCPU was used
+ * when requesting the irq.
+ */
+
+static void handle_jcore_irq(struct irq_desc *desc)
+{
+	if (irqd_is_per_cpu(irq_desc_get_irq_data(desc)))
+		handle_percpu_irq(desc);
+	else
+		handle_simple_irq(desc);
+}
+
 static int jcore_aic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 				   irq_hw_number_t hwirq)
 {
 	struct irq_chip *aic = d->host_data;
 
-	irq_set_chip_and_handler(irq, aic, handle_simple_irq);
+	irq_set_chip_and_handler(irq, aic, handle_jcore_irq);
 
 	return 0;
 }
-- 
2.10.0

