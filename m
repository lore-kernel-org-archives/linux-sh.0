From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 08 Sep 2015 17:00:35 +0000
Subject: [PATCH 1/2] irqchip: renesas-intc-irqpin: Propagate wake-up settings to parent
Message-Id: <1441731636-17610-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The renesas-intc-irqpin interrupt controller is cascaded to the GIC, but
its driver doesn't propagate wake-up settings to the parent interrupt
controller.

Since commit aec89ef72ba6c944 ("irqchip/gic: Enable SKIP_SET_WAKE and
MASK_ON_SUSPEND"), the GIC driver masks interrupts during suspend, and
wake-up through gpio-keys now fails on r8a7740/armadillo and
sh73a0/kzm9g.

Fix this by propagating wake-up settings to the parent interrupt
controller. There's no need to handle irq_set_irq_wake() failures, as
the renesas-intc-irqpin interrupt controller is always cascaded to a
GIC, and the GIC driver always sets SKIP_SET_WAKE since the
aforementioned commit.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 0670ab4e3897bf61..457d22c09e352d56 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -283,6 +283,9 @@ static int intc_irqpin_irq_set_type(struct irq_data *d, unsigned int type)
 static int intc_irqpin_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct intc_irqpin_priv *p = irq_data_get_irq_chip_data(d);
+	int hw_irq = irqd_to_hwirq(d);
+
+	irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
 
 	if (!p->clk)
 		return 0;
-- 
1.9.1

