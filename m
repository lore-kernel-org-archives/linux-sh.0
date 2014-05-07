From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 May 2014 23:18:17 +0000
Subject: [PATCH 03/03] pinctrl: sh-pfc: r8a73a4: Allow Multiplatform Build
Message-Id: <20140507231817.29661.71080.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add #ifdefs to allow r8a73a4 Multiplatform build. Needed
to enable r8a73a4 Multiplatform support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- 0001/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c	2014-04-24 19:25:28.000000000 +0900
@@ -20,7 +20,10 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
+
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 #include <mach/irqs.h>
+#endif
 
 #include "core.h"
 #include "sh_pfc.h"
@@ -2603,6 +2606,7 @@ static const struct pinmux_data_reg pinm
 	{ },
 };
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 static const struct pinmux_irq pinmux_irqs[] = {
 	PINMUX_IRQ(irq_pin(0), 0),
 	PINMUX_IRQ(irq_pin(1), 1),
@@ -2663,6 +2667,7 @@ static const struct pinmux_irq pinmux_ir
 	PINMUX_IRQ(irq_pin(56), 328),
 	PINMUX_IRQ(irq_pin(57), 329),
 };
+#endif /* CONFIG_ARCH_MULTIPLATFORM */
 
 #define PORTCR_PULMD_OFF (0 << 6)
 #define PORTCR_PULMD_DOWN (2 << 6)
@@ -2741,6 +2746,8 @@ const struct sh_pfc_soc_info r8a73a4_pin
 	.gpio_data	= pinmux_data,
 	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 	.gpio_irq = pinmux_irqs,
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
+#endif
 };
