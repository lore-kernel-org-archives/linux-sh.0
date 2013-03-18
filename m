From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 18 Mar 2013 14:50:49 +0000
Subject: [PATCH 02/02] sh-pfc: Add r8a73a4 GPIO IRQ support
Message-Id: <20130318145049.26761.35712.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add GPIO -> IRQ mappings to the PFC table for
the r8a73a4 SoC. Requires the IRQs to be mapped
at a fixed location. The actual IRQs are not
handled by the PFC, instead IRQC is used.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |   63 ++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

--- 0008/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c	2013-03-18 20:37:22.000000000 +0900
@@ -2793,6 +2793,66 @@ static const struct pinmux_data_reg pinm
 	{ },
 };
 
+static const struct pinmux_irq pinmux_irqs[] = {
+	PINMUX_IRQ(irq_pin(0), GPIO_PORT0),
+	PINMUX_IRQ(irq_pin(1), GPIO_PORT1),
+	PINMUX_IRQ(irq_pin(2), GPIO_PORT2),
+	PINMUX_IRQ(irq_pin(3), GPIO_PORT3),
+	PINMUX_IRQ(irq_pin(4), GPIO_PORT4),
+	PINMUX_IRQ(irq_pin(5), GPIO_PORT5),
+	PINMUX_IRQ(irq_pin(6), GPIO_PORT6),
+	PINMUX_IRQ(irq_pin(7), GPIO_PORT7),
+	PINMUX_IRQ(irq_pin(8), GPIO_PORT8),
+	PINMUX_IRQ(irq_pin(9), GPIO_PORT9),
+	PINMUX_IRQ(irq_pin(10), GPIO_PORT10),
+	PINMUX_IRQ(irq_pin(11), GPIO_PORT11),
+	PINMUX_IRQ(irq_pin(12), GPIO_PORT12),
+	PINMUX_IRQ(irq_pin(13), GPIO_PORT13),
+	PINMUX_IRQ(irq_pin(14), GPIO_PORT14),
+	PINMUX_IRQ(irq_pin(15), GPIO_PORT15),
+	PINMUX_IRQ(irq_pin(16), GPIO_PORT320),
+	PINMUX_IRQ(irq_pin(17), GPIO_PORT321),
+	PINMUX_IRQ(irq_pin(18), GPIO_PORT85),
+	PINMUX_IRQ(irq_pin(19), GPIO_PORT84),
+	PINMUX_IRQ(irq_pin(20), GPIO_PORT160),
+	PINMUX_IRQ(irq_pin(21), GPIO_PORT161),
+	PINMUX_IRQ(irq_pin(22), GPIO_PORT162),
+	PINMUX_IRQ(irq_pin(23), GPIO_PORT163),
+	PINMUX_IRQ(irq_pin(24), GPIO_PORT175),
+	PINMUX_IRQ(irq_pin(25), GPIO_PORT176),
+	PINMUX_IRQ(irq_pin(26), GPIO_PORT177),
+	PINMUX_IRQ(irq_pin(27), GPIO_PORT178),
+	PINMUX_IRQ(irq_pin(28), GPIO_PORT322),
+	PINMUX_IRQ(irq_pin(29), GPIO_PORT323),
+	PINMUX_IRQ(irq_pin(30), GPIO_PORT324),
+	PINMUX_IRQ(irq_pin(31), GPIO_PORT192),
+	PINMUX_IRQ(irq_pin(32), GPIO_PORT193),
+	PINMUX_IRQ(irq_pin(33), GPIO_PORT194),
+	PINMUX_IRQ(irq_pin(34), GPIO_PORT195),
+	PINMUX_IRQ(irq_pin(35), GPIO_PORT196),
+	PINMUX_IRQ(irq_pin(36), GPIO_PORT197),
+	PINMUX_IRQ(irq_pin(37), GPIO_PORT198),
+	PINMUX_IRQ(irq_pin(38), GPIO_PORT199),
+	PINMUX_IRQ(irq_pin(39), GPIO_PORT200),
+	PINMUX_IRQ(irq_pin(40), GPIO_PORT66),
+	PINMUX_IRQ(irq_pin(41), GPIO_PORT102),
+	PINMUX_IRQ(irq_pin(42), GPIO_PORT103),
+	PINMUX_IRQ(irq_pin(43), GPIO_PORT109),
+	PINMUX_IRQ(irq_pin(44), GPIO_PORT110),
+	PINMUX_IRQ(irq_pin(45), GPIO_PORT111),
+	PINMUX_IRQ(irq_pin(46), GPIO_PORT112),
+	PINMUX_IRQ(irq_pin(47), GPIO_PORT113),
+	PINMUX_IRQ(irq_pin(48), GPIO_PORT114),
+	PINMUX_IRQ(irq_pin(49), GPIO_PORT115),
+	PINMUX_IRQ(irq_pin(50), GPIO_PORT301),
+	PINMUX_IRQ(irq_pin(51), GPIO_PORT290),
+	PINMUX_IRQ(irq_pin(52), GPIO_PORT296),
+	PINMUX_IRQ(irq_pin(53), GPIO_PORT325),
+	PINMUX_IRQ(irq_pin(54), GPIO_PORT326),
+	PINMUX_IRQ(irq_pin(55), GPIO_PORT327),
+	PINMUX_IRQ(irq_pin(56), GPIO_PORT328),
+	PINMUX_IRQ(irq_pin(57), GPIO_PORT329),
+};
 const struct sh_pfc_soc_info r8a73a4_pinmux_info = {
 	.name		= "r8a73a4_pfc",
 
@@ -2812,4 +2872,7 @@ const struct sh_pfc_soc_info r8a73a4_pin
 
 	.gpio_data	= pinmux_data,
 	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
+
+	.gpio_irq = pinmux_irqs,
+	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
 };
