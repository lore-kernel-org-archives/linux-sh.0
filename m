From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 07 May 2014 23:17:58 +0000
Subject: [PATCH 01/03] pinctrl: sh-pfc: r8a7740: Allow Multiplatform Build
Message-Id: <20140507231758.29661.57103.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add #ifdefs to allow r8a7740 Multiplatform build. Needed
to enable r8a7740 Multiplatform support.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- 0001/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a7740.c	2014-04-24 19:13:59.000000000 +0900
@@ -22,7 +22,9 @@
 #include <linux/kernel.h>
 #include <linux/pinctrl/pinconf-generic.h>
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 #include <mach/irqs.h>
+#endif
 
 #include "core.h"
 #include "sh_pfc.h"
@@ -3652,6 +3654,7 @@ static const struct pinmux_data_reg pinm
 	{ },
 };
 
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 static const struct pinmux_irq pinmux_irqs[] = {
 	PINMUX_IRQ(irq_pin(0), 2,   13),	/* IRQ0A */
 	PINMUX_IRQ(irq_pin(1), 20),		/* IRQ1A */
@@ -3686,6 +3689,7 @@ static const struct pinmux_irq pinmux_ir
 	PINMUX_IRQ(irq_pin(30), 49,  171),	/* IRQ30A */
 	PINMUX_IRQ(irq_pin(31), 41,  167),	/* IRQ31A */
 };
+#endif /* CONFIG_ARCH_MULTIPLATFORM */
 
 #define PORTnCR_PULMD_OFF	(0 << 6)
 #define PORTnCR_PULMD_DOWN	(2 << 6)
@@ -3778,7 +3782,8 @@ const struct sh_pfc_soc_info r8a7740_pin
 
 	.gpio_data	= pinmux_data,
 	.gpio_data_size	= ARRAY_SIZE(pinmux_data),
-
+#ifndef CONFIG_ARCH_MULTIPLATFORM
 	.gpio_irq	= pinmux_irqs,
 	.gpio_irq_size	= ARRAY_SIZE(pinmux_irqs),
+#endif
 };
