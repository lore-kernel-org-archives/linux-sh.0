From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 08 Sep 2015 17:00:36 +0000
Subject: [PATCH 2/2] irqchip: renesas-irqc: Propagate wake-up settings to parent
Message-Id: <1441731636-17610-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1441731636-17610-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The renesas-irqc interrupt controller is cascaded to the GIC, but its
driver doesn't propagate wake-up settings to the parent interrupt
controller.

Since commit aec89ef72ba6c944 ("irqchip/gic: Enable SKIP_SET_WAKE and
MASK_ON_SUSPEND"), the GIC driver masks interrupts during suspend, and
wake-up through gpio-keys now fails on r8a73a4/ape6evm.

Fix this by propagating wake-up settings to the parent interrupt
controller. There's no need to handle irq_set_irq_wake() failures, as
the renesas-irqc interrupt controller is always cascaded to a GIC, and
the GIC driver always sets SKIP_SET_WAKE since the aforementioned
commit.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/irqchip/irq-renesas-irqc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-irqc.c b/drivers/irqchip/irq-renesas-irqc.c
index 2aa3add711a6612a..49f6c41d94f91d4d 100644
--- a/drivers/irqchip/irq-renesas-irqc.c
+++ b/drivers/irqchip/irq-renesas-irqc.c
@@ -121,6 +121,9 @@ static int irqc_irq_set_type(struct irq_data *d, unsigned int type)
 static int irqc_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct irqc_priv *p = irq_data_get_irq_chip_data(d);
+	int hw_irq = irqd_to_hwirq(d);
+
+	irq_set_irq_wake(p->irq[hw_irq].requested_irq, on);
 
 	if (!p->clk)
 		return 0;
-- 
1.9.1

