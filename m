From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Sep 2011 07:55:45 +0000
Subject: [PATCH] ARM: mach-shmobile: sh73a0 GPIO IRQ support
Message-Id: <20110928075545.17632.66011.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds support for sh73a0 GPIO IRQs by making use
of the PFC GPIO IRQ feature. Only IRQ pins are  supported
at this time. In the future when PINT interrupts also are
supported properly we can easily extend the table with such
information. Also, the sh73a0 is currently making use of
the GIC for external interrupt which is rather unflexible
when it comes to triggering configuration at this point.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/pfc-sh73a0.c |   41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

--- 0006/arch/arm/mach-shmobile/pfc-sh73a0.c
+++ work/arch/arm/mach-shmobile/pfc-sh73a0.c	2011-09-28 16:31:42.000000000 +0900
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/gpio.h>
 #include <mach/sh73a0.h>
+#include <mach/irqs.h>
 
 #define _1(fn, pfx, sfx) fn(pfx, sfx)
 
@@ -2765,6 +2766,43 @@ static struct pinmux_data_reg pinmux_dat
 	{ },
 };
 
+#define EXT_IRQ(n) gic_spi((n) + 1) /* GIC SPI starting from 1 for IRQ0 */
+
+static struct pinmux_irq pinmux_irqs[] = {
+	PINMUX_IRQ(EXT_IRQ(19), PORT9_FN0),
+	PINMUX_IRQ(EXT_IRQ(1), PORT10_FN0),
+	PINMUX_IRQ(EXT_IRQ(0), PORT11_FN0),
+	PINMUX_IRQ(EXT_IRQ(18), PORT13_FN0),
+	PINMUX_IRQ(EXT_IRQ(20), PORT14_FN0),
+	PINMUX_IRQ(EXT_IRQ(21), PORT15_FN0),
+	PINMUX_IRQ(EXT_IRQ(31), PORT26_FN0),
+	PINMUX_IRQ(EXT_IRQ(30), PORT27_FN0),
+	PINMUX_IRQ(EXT_IRQ(29), PORT28_FN0),
+	PINMUX_IRQ(EXT_IRQ(22), PORT40_FN0),
+	PINMUX_IRQ(EXT_IRQ(23), PORT53_FN0),
+	PINMUX_IRQ(EXT_IRQ(10), PORT54_FN0),
+	PINMUX_IRQ(EXT_IRQ(9), PORT56_FN0),
+	PINMUX_IRQ(EXT_IRQ(26), PORT115_FN0),
+	PINMUX_IRQ(EXT_IRQ(27), PORT116_FN0),
+	PINMUX_IRQ(EXT_IRQ(28), PORT117_FN0),
+	PINMUX_IRQ(EXT_IRQ(24), PORT118_FN0),
+	PINMUX_IRQ(EXT_IRQ(6), PORT147_FN0),
+	PINMUX_IRQ(EXT_IRQ(2), PORT149_FN0),
+	PINMUX_IRQ(EXT_IRQ(7), PORT150_FN0),
+	PINMUX_IRQ(EXT_IRQ(12), PORT156_FN0),
+	PINMUX_IRQ(EXT_IRQ(4), PORT159_FN0),
+	PINMUX_IRQ(EXT_IRQ(25), PORT164_FN0),
+	PINMUX_IRQ(EXT_IRQ(8), PORT223_FN0),
+	PINMUX_IRQ(EXT_IRQ(3), PORT224_FN0),
+	PINMUX_IRQ(EXT_IRQ(5), PORT227_FN0),
+	PINMUX_IRQ(EXT_IRQ(17), PORT234_FN0),
+	PINMUX_IRQ(EXT_IRQ(11), PORT238_FN0),
+	PINMUX_IRQ(EXT_IRQ(13), PORT239_FN0),
+	PINMUX_IRQ(EXT_IRQ(16), PORT249_FN0),
+	PINMUX_IRQ(EXT_IRQ(14), PORT251_FN0),
+	PINMUX_IRQ(EXT_IRQ(9), PORT308_FN0),
+};
+
 static struct pinmux_info sh73a0_pinmux_info = {
 	.name = "sh73a0_pfc",
 	.reserved_id = PINMUX_RESERVED,
@@ -2785,6 +2823,9 @@ static struct pinmux_info sh73a0_pinmux_
 
 	.gpio_data = pinmux_data,
 	.gpio_data_size = ARRAY_SIZE(pinmux_data),
+
+	.gpio_irq = pinmux_irqs,
+	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
 
 void sh73a0_pinmux_init(void)
