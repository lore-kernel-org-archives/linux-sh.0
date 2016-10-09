From: Rich Felker <dalias@libc.org>
Date: Sun, 09 Oct 2016 05:59:42 +0000
Subject: [PATCH] irqchip/jcore: fix lost per-cpu interrupts
Message-Id: <41fc74d0bdea4c0efc269150b78d72b2b26cb38c.1475992312.git.dalias@libc.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

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

Ideas for improvement are welcome -- for example the
irq_is_percpu(irq_desc_get_irq(desc)) thing looks rather silly but I
didn't see a better way without poking through abstractions -- but
overall I think this both solves the timer stall issue that I wasted
other people's time on, and addresses the concerns about the J-Core
AIC driver being oblivious to whether an irq is per-cpu.

---
 drivers/irqchip/irq-jcore-aic.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-jcore-aic.c b/drivers/irqchip/irq-jcore-aic.c
index 5e5e3bb..b53a8a5 100644
--- a/drivers/irqchip/irq-jcore-aic.c
+++ b/drivers/irqchip/irq-jcore-aic.c
@@ -25,12 +25,20 @@
 
 static struct irq_chip jcore_aic;
 
+static void handle_jcore_irq(struct irq_desc *desc)
+{
+	if (irq_is_percpu(irq_desc_get_irq(desc)))
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

