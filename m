From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 May 2014 23:18:08 +0000
Subject: [PATCH 02/03] pinctrl: sh-pfc: sh73a0: Allow Multiplatform Build
Message-Id: <20140507231808.29661.31944.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add #ifdefs to allow sh73a0 Multiplatform build. Needed
to enable sh73a0 Multiplatform support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-sh73a0.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ work/drivers/pinctrl/sh-pfc/pfc-sh73a0.c	2014-04-24 19:27:57.000000000 +0900
@@ -26,7 +26,9 @@
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 #include <mach/irqs.h>
+#endif
 
 #include "core.h"
 #include "sh_pfc.h"
@@ -3650,6 +3652,7 @@ static const struct pinmux_data_reg pinm
 	{ },
 };
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 static const struct pinmux_irq pinmux_irqs[] = {
 	PINMUX_IRQ(irq_pin(0), 11),
 	PINMUX_IRQ(irq_pin(1), 10),
@@ -3684,6 +3687,7 @@ static const struct pinmux_irq pinmux_ir
 	PINMUX_IRQ(irq_pin(30), 27),
 	PINMUX_IRQ(irq_pin(31), 26),
 };
+#endif /* CONFIG_ARCH_MULTIPLATFORM */
 
 /* -----------------------------------------------------------------------------
  * VCCQ MC0 regulator
@@ -3888,6 +3892,8 @@ const struct sh_pfc_soc_info sh73a0_pinm
 	.gpio_data = pinmux_data,
 	.gpio_data_size = ARRAY_SIZE(pinmux_data),
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 	.gpio_irq = pinmux_irqs,
 	.gpio_irq_size = ARRAY_SIZE(pinmux_irqs),
+#endif
 };
