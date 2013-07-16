From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 00:11:11 +0000
Subject: [PATCH v2 19/27] sh-pfc: sh7734: Use the common GP port style macros
Message-Id: <1373933479-17727-20-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SoC has a bank-style PFC. Replace the custom-defined macros with
common macros from sh-pfc.h.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 56 +++++++++++++++----------------------
 drivers/pinctrl/sh-pfc/sh_pfc.h     | 17 -----------
 2 files changed, 22 insertions(+), 51 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 537a639..ec0c47c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -14,42 +14,30 @@
 
 #include "sh_pfc.h"
 
-#define CPU_32_PORT5(fn, pfx, sfx)				\
-	PORT_1(fn, pfx##0, sfx), PORT_1(fn, pfx##1, sfx),	\
-	PORT_1(fn, pfx##2, sfx), PORT_1(fn, pfx##3, sfx),	\
-	PORT_1(fn, pfx##4, sfx), PORT_1(fn, pfx##5, sfx),	\
-	PORT_1(fn, pfx##6, sfx), PORT_1(fn, pfx##7, sfx),	\
-	PORT_1(fn, pfx##8, sfx), PORT_1(fn, pfx##9, sfx),	\
-	PORT_1(fn, pfx##10, sfx), PORT_1(fn, pfx##11, sfx)
-
-/* GPSR0 - GPSR5 */
-#define CPU_ALL_PORT(fn, pfx, sfx)				\
-	PORT_32(fn, pfx##_0_, sfx),			\
-	PORT_32(fn, pfx##_1_, sfx),				\
-	PORT_32(fn, pfx##_2_, sfx),				\
-	PORT_32(fn, pfx##_3_, sfx),				\
-	PORT_32(fn, pfx##_4_, sfx),				\
-	CPU_32_PORT5(fn, pfx##_5_, sfx)
-
-#undef _GP_GPIO
-#undef _GP_DATA
-#undef GP_ALL
-#undef PINMUX_GPIO_GP_ALL
-#undef PINMUX_DATA_GP_ALL
-
-#define _GP_GPIO(pfx, sfx) PINMUX_GPIO(GPIO_GP##pfx, GP##pfx##_DATA)
-#define _GP_DATA(pfx, sfx) PINMUX_DATA(GP##pfx##_DATA, GP##pfx##_FN,	\
-				       GP##pfx##_IN, GP##pfx##_OUT)
+#define PORT_GP_12(bank, fn, sfx)					\
+	PORT_GP_1(bank, 0, fn, sfx),  PORT_GP_1(bank, 1, fn, sfx),	\
+	PORT_GP_1(bank, 2, fn, sfx),  PORT_GP_1(bank, 3, fn, sfx),	\
+	PORT_GP_1(bank, 4, fn, sfx),  PORT_GP_1(bank, 5, fn, sfx),	\
+	PORT_GP_1(bank, 6, fn, sfx),  PORT_GP_1(bank, 7, fn, sfx),	\
+	PORT_GP_1(bank, 8, fn, sfx),  PORT_GP_1(bank, 9, fn, sfx),	\
+	PORT_GP_1(bank, 10, fn, sfx), PORT_GP_1(bank, 11, fn, sfx)
+
+#define CPU_ALL_PORT(fn, sfx)						\
+	PORT_GP_32(0, fn, sfx),						\
+	PORT_GP_32(1, fn, sfx),						\
+	PORT_GP_32(2, fn, sfx),						\
+	PORT_GP_32(3, fn, sfx),						\
+	PORT_GP_32(4, fn, sfx),						\
+	PORT_GP_12(5, fn, sfx)
 
-#define _GP_INOUTSEL(pfx, sfx) GP##pfx##_IN, GP##pfx##_OUT
-#define _GP_INDT(pfx, sfx) GP##pfx##_DATA
-
-#define GP_ALL(str)	CPU_ALL_PORT(_PORT_ALL, GP, str)
-#define PINMUX_GPIO_GP_ALL()	CPU_ALL_PORT(_GP_GPIO, , unused)
-#define PINMUX_DATA_GP_ALL()	CPU_ALL_PORT(_GP_DATA, , unused)
+#undef _GP_DATA
+#define _GP_DATA(bank, pin, name, sfx)					\
+	PINMUX_DATA(name##_DATA, name##_FN, name##_IN, name##_OUT)
 
-#define GP_INOUTSEL(bank) PORT_32_REV(_GP_INOUTSEL, _##bank##_, unused)
-#define GP_INDT(bank) PORT_32_REV(_GP_INDT, _##bank##_, unused)
+#define _GP_INOUTSEL(bank, pin, name, sfx)	name##_IN, name##_OUT
+#define _GP_INDT(bank, pin, name, sfx)		name##_DATA
+#define GP_INOUTSEL(bank)	PORT_GP_32_REV(bank, _GP_INOUTSEL, unused)
+#define GP_INDT(bank)		PORT_GP_32_REV(bank, _GP_INDT, unused)
 
 enum {
 	PINMUX_RESERVED = 0,
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index f7c5b80..05b905f 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -238,23 +238,6 @@ struct sh_pfc_soc_info {
 	PORT_1(fn, pfx##6, sfx), PORT_1(fn, pfx##7, sfx),		\
 	PORT_1(fn, pfx##8, sfx), PORT_1(fn, pfx##9, sfx)
 
-#define PORT_10_REV(fn, pfx, sfx)					\
-	PORT_1(fn, pfx##9, sfx), PORT_1(fn, pfx##8, sfx),		\
-	PORT_1(fn, pfx##7, sfx), PORT_1(fn, pfx##6, sfx),		\
-	PORT_1(fn, pfx##5, sfx), PORT_1(fn, pfx##4, sfx),		\
-	PORT_1(fn, pfx##3, sfx), PORT_1(fn, pfx##2, sfx),		\
-	PORT_1(fn, pfx##1, sfx), PORT_1(fn, pfx##0, sfx)
-
-#define PORT_32(fn, pfx, sfx)						\
-	PORT_10(fn, pfx, sfx), PORT_10(fn, pfx##1, sfx),		\
-	PORT_10(fn, pfx##2, sfx), PORT_1(fn, pfx##30, sfx),		\
-	PORT_1(fn, pfx##31, sfx)
-
-#define PORT_32_REV(fn, pfx, sfx)					\
-	PORT_1(fn, pfx##31, sfx), PORT_1(fn, pfx##30, sfx),		\
-	PORT_10_REV(fn, pfx##2, sfx), PORT_10_REV(fn, pfx##1, sfx),	\
-	PORT_10_REV(fn, pfx, sfx)
-
 #define PORT_90(fn, pfx, sfx) \
 	PORT_10(fn, pfx##1, sfx), PORT_10(fn, pfx##2, sfx),		\
 	PORT_10(fn, pfx##3, sfx), PORT_10(fn, pfx##4, sfx),		\
-- 
1.8.1.5

