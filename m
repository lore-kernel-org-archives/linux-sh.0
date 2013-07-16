From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 00:11:05 +0000
Subject: [PATCH v2 13/27] sh-pfc: Remove unused GPIO_PORT_ALL macro
Message-Id: <1373933479-17727-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The macro isn't used, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 7 -------
 drivers/pinctrl/sh-pfc/pfc-sh7372.c  | 7 -------
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 2 --
 3 files changed, 16 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index f6ea47c..3fb1e0b 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -34,13 +34,6 @@
 	PORT_10(fn, pfx##20, sfx),					\
 	PORT_1(fn, pfx##210, sfx),	PORT_1(fn, pfx##211, sfx)
 
-#undef _GPIO_PORT
-#define _GPIO_PORT(gpio, sfx)						\
-	[gpio] = {							\
-		.name = __stringify(PORT##gpio),			\
-		.enum_id = PORT##gpio##_DATA,				\
-	}
-
 #define IRQC_PIN_MUX(irq, pin)						\
 static const unsigned int intc_irq##irq##_pins[] = {			\
 	pin,								\
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 6dfb187..cd431e4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -38,13 +38,6 @@
 	PORT_10(fn, pfx##16, sfx),	PORT_10(fn, pfx##17, sfx), \
 	PORT_10(fn, pfx##18, sfx),	PORT_1(fn, pfx##190, sfx)
 
-#undef _GPIO_PORT
-#define _GPIO_PORT(gpio, sfx)						\
-	[gpio] = {							\
-		.name = __stringify(PORT##gpio),			\
-		.enum_id = PORT##gpio##_DATA,				\
-	}
-
 #define IRQC_PIN_MUX(irq, pin)						\
 static const unsigned int intc_irq##irq##_pins[] = {			\
 	pin,								\
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 2105487..363ea8c 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -196,9 +196,7 @@ struct sh_pfc_soc_info {
 	PORT_10(fn, pfx##9, sfx)
 
 #define _PORT_ALL(pfx, sfx) pfx##_##sfx
-#define _GPIO_PORT(pfx, sfx) PINMUX_GPIO(GPIO_PORT##pfx, PORT##pfx##_DATA)
 #define PORT_ALL(str)	CPU_ALL_PORT(_PORT_ALL, PORT, str)
-#define GPIO_PORT_ALL()	CPU_ALL_PORT(_GPIO_PORT, , unused)
 #define GPIO_FN(str) PINMUX_GPIO_FN(GPIO_FN_##str, PINMUX_FN_BASE, str##_MARK)
 
 /* helper macro for pinmux_enum_t */
-- 
1.8.1.5

