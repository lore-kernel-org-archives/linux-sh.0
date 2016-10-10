From: Rich Felker <dalias@libc.org>
Date: Mon, 10 Oct 2016 16:05:50 +0000
Subject: [PATCH v2] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <03e26780321c28c7d6e72bdd72d8e7066f9b1779.1476115269.git.dalias@libc.org>
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

One possible solution would be to use a wrapper handler function which
determines at irq time whether the irq being handled was registered as
percpu or not, and dispatches it to either handle_simple_irq or
handle_percpu_irq. However handle_simple_irq is unnecessarily
expensive for hardware that always delivers interrupts on a fixed cpu,
and the runtime branch also has a small but nonzero cost. Instead, use
handle_percpu_irq for all irqs.

Signed-off-by: Rich Felker <dalias@libc.org>
---

Updated based on discussions with Thomas Gleixner about the v1 patch,
and confirmation from Jeff Dionne (J-Core project) that it's
reasonable to treat the current interrupt behavior (delivery on a
fixed cpu) as a guarantee of the jcore,aic1 and jcore,aic2 DT
compatible tags.

---
 drivers/irqchip/irq-jcore-aic.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5e5e3bb..055fb6f 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -30,7 +30,16 @@ static int jcore_aic_irqdomain_map(struct irq_domain *d, unsigned int irq,
 {
 	struct irq_chip *aic = d->host_data;
 
-	irq_set_chip_and_handler(irq, aic, handle_simple_irq);
+	/*
+	 * For the J-Core AIC1 and AIC2, all irqs behave as percpu. Some
+	 * (timer and IPI) can be generated specifically for individual
+	 * CPUs; the rest are directly connected to a particular CPU. None
+	 * are dynamically routable. Use handle_percpu_irq for all cases,
+	 * since it's necessary for the former and safe (and faster) for
+	 * the latter, and there's no way to distinguish them with the
+	 * information available at mapping time.
+	 */
+	irq_set_chip_and_handler(irq, aic, handle_percpu_irq);
 
 	return 0;
 }
-- 
2.10.0

