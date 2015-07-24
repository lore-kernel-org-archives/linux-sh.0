From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 24 Jul 2015 15:21:55 +0000
Subject: [PATCH v2 1/3] pinctrl: sh-pfc: add macros defining GP ports with config flags
Message-Id: <1437751317-12235-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

PORT_GP_CFG_1 and PORT_GP_CFG_32 work like their non-CFG counterparts
but accept an extra argument with config flags.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 47 ++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index c7508d5..6c68858 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -180,25 +180,27 @@ struct sh_pfc_soc_info {
  * GP port style (32 ports banks)
  */
 
-#define PORT_GP_1(bank, pin, fn, sfx) fn(bank, pin, GP_##bank##_##pin, sfx)
-
-#define PORT_GP_32(bank, fn, sfx)					\
-	PORT_GP_1(bank, 0,  fn, sfx), PORT_GP_1(bank, 1,  fn, sfx),	\
-	PORT_GP_1(bank, 2,  fn, sfx), PORT_GP_1(bank, 3,  fn, sfx),	\
-	PORT_GP_1(bank, 4,  fn, sfx), PORT_GP_1(bank, 5,  fn, sfx),	\
-	PORT_GP_1(bank, 6,  fn, sfx), PORT_GP_1(bank, 7,  fn, sfx),	\
-	PORT_GP_1(bank, 8,  fn, sfx), PORT_GP_1(bank, 9,  fn, sfx),	\
-	PORT_GP_1(bank, 10, fn, sfx), PORT_GP_1(bank, 11, fn, sfx),	\
-	PORT_GP_1(bank, 12, fn, sfx), PORT_GP_1(bank, 13, fn, sfx),	\
-	PORT_GP_1(bank, 14, fn, sfx), PORT_GP_1(bank, 15, fn, sfx),	\
-	PORT_GP_1(bank, 16, fn, sfx), PORT_GP_1(bank, 17, fn, sfx),	\
-	PORT_GP_1(bank, 18, fn, sfx), PORT_GP_1(bank, 19, fn, sfx),	\
-	PORT_GP_1(bank, 20, fn, sfx), PORT_GP_1(bank, 21, fn, sfx),	\
-	PORT_GP_1(bank, 22, fn, sfx), PORT_GP_1(bank, 23, fn, sfx),	\
-	PORT_GP_1(bank, 24, fn, sfx), PORT_GP_1(bank, 25, fn, sfx),	\
-	PORT_GP_1(bank, 26, fn, sfx), PORT_GP_1(bank, 27, fn, sfx),	\
-	PORT_GP_1(bank, 28, fn, sfx), PORT_GP_1(bank, 29, fn, sfx),	\
-	PORT_GP_1(bank, 30, fn, sfx), PORT_GP_1(bank, 31, fn, sfx)
+#define PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin, GP_##bank##_##pin, sfx, cfg)
+#define PORT_GP_1(bank, pin, fn, sfx)	PORT_GP_CFG_1(bank, pin, fn, sfx, 0)
+
+#define PORT_GP_CFG_32(bank, fn, sfx, cfg)				\
+	PORT_GP_CFG_1(bank, 0,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 1,  fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 2,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 3,  fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 4,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 5,  fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 6,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 7,  fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 8,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 9,  fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 10, fn, sfx, cfg), PORT_GP_CFG_1(bank, 11, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 12, fn, sfx, cfg), PORT_GP_CFG_1(bank, 13, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 14, fn, sfx, cfg), PORT_GP_CFG_1(bank, 15, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 16, fn, sfx, cfg), PORT_GP_CFG_1(bank, 17, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 18, fn, sfx, cfg), PORT_GP_CFG_1(bank, 19, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 20, fn, sfx, cfg), PORT_GP_CFG_1(bank, 21, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 22, fn, sfx, cfg), PORT_GP_CFG_1(bank, 23, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 24, fn, sfx, cfg), PORT_GP_CFG_1(bank, 25, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 26, fn, sfx, cfg), PORT_GP_CFG_1(bank, 27, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 28, fn, sfx, cfg), PORT_GP_CFG_1(bank, 29, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 30, fn, sfx, cfg), PORT_GP_CFG_1(bank, 31, fn, sfx, cfg)
+#define PORT_GP_32(bank, fn, sfx)	PORT_GP_CFG_32(bank, fn, sfx, 0)
 
 #define PORT_GP_32_REV(bank, fn, sfx)					\
 	PORT_GP_1(bank, 31, fn, sfx), PORT_GP_1(bank, 30, fn, sfx),	\
@@ -219,20 +221,21 @@ struct sh_pfc_soc_info {
 	PORT_GP_1(bank, 1,  fn, sfx), PORT_GP_1(bank, 0,  fn, sfx)
 
 /* GP_ALL(suffix) - Expand to a list of GP_#_#_suffix */
-#define _GP_ALL(bank, pin, name, sfx)	name##_##sfx
+#define _GP_ALL(bank, pin, name, sfx, cfg)	name##_##sfx
 #define GP_ALL(str)			CPU_ALL_PORT(_GP_ALL, str)
 
 /* PINMUX_GPIO_GP_ALL - Expand to a list of sh_pfc_pin entries */
-#define _GP_GPIO(bank, _pin, _name, sfx)				\
+#define _GP_GPIO(bank, _pin, _name, sfx, cfg)				\
 	[(bank * 32) + _pin] = {					\
 		.pin = (bank * 32) + _pin,				\
 		.name = __stringify(_name),				\
 		.enum_id = _name##_DATA,				\
+		.configs = cfg,						\
 	}
 #define PINMUX_GPIO_GP_ALL()		CPU_ALL_PORT(_GP_GPIO, unused)
 
 /* PINMUX_DATA_GP_ALL -  Expand to a list of name_DATA, name_FN marks */
-#define _GP_DATA(bank, pin, name, sfx)	PINMUX_DATA(name##_DATA, name##_FN)
+#define _GP_DATA(bank, pin, name, sfx, cfg)	PINMUX_DATA(name##_DATA, name##_FN)
 #define PINMUX_DATA_GP_ALL()		CPU_ALL_PORT(_GP_DATA, unused)
 
 /*
-- 
2.4.6

