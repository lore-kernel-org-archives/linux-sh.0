From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Nov 2015 05:29:59 +0000
Subject: [PATCH v2][RFC] pinctrl: sh-pfc: share/reuse same PORT_GP_x() macros
Message-Id: <87ziyldrxk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87io5ajkz9.wl%kuninori.morimoto.gx@renesas.com>
	<8737wdfcd0.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8737wdfcd0.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Many SoC needs each PORT_GP_x() macros, but we can share/reuse
same one.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - based on PORT_GP_CFG_xx()

This patch is based on Geert's
	Date: Thu, 29 Oct 2015 20:39:47 +0100
	Subject: [PATCH] pinctrl: sh-pfc: r8a7795: Make PORT_GP_x() macros consistent

 drivers/pinctrl/sh-pfc/pfc-r8a7779.c |  7 ----
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 17 ----------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 15 --------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 19 -----------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 31 -----------------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  8 -----
 drivers/pinctrl/sh-pfc/sh_pfc.h      | 66 ++++++++++++++++++++++++++++++------
 7 files changed, 56 insertions(+), 107 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index ed4e078..7293e37 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -23,13 +23,6 @@
 
 #include "sh_pfc.h"
 
-#define PORT_GP_9(bank, fn, sfx)					\
-	PORT_GP_1(bank, 0, fn, sfx), PORT_GP_1(bank, 1, fn, sfx),	\
-	PORT_GP_1(bank, 2, fn, sfx), PORT_GP_1(bank, 3, fn, sfx),	\
-	PORT_GP_1(bank, 4, fn, sfx), PORT_GP_1(bank, 5, fn, sfx),	\
-	PORT_GP_1(bank, 6, fn, sfx), PORT_GP_1(bank, 7, fn, sfx),	\
-	PORT_GP_1(bank, 8, fn, sfx)
-
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_32(1, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index d9924b0..bc8e400 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -26,23 +26,6 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define PORT_GP_30(bank, fn, sfx)					\
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
-	PORT_GP_1(bank, 28, fn, sfx), PORT_GP_1(bank, 29, fn, sfx)
-
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_30(1, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 87a4f44..119e1aa 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -13,21 +13,6 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define PORT_GP_26(bank, fn, sfx)					\
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
-	PORT_GP_1(bank, 24, fn, sfx), PORT_GP_1(bank, 25, fn, sfx)
-
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_26(1, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 086f679..533cb8a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -15,25 +15,6 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define PORT_GP_26(bank, fn, sfx)					\
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
-	PORT_GP_1(bank, 24, fn, sfx), PORT_GP_1(bank, 25, fn, sfx)
-
-#define PORT_GP_28(bank, fn, sfx)					\
-	PORT_GP_26(bank, fn, sfx),					\
-	PORT_GP_1(bank, 26, fn, sfx), PORT_GP_1(bank, 27, fn, sfx)
-
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_26(1, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 29d001b..d977e21 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -13,37 +13,6 @@
 #include "core.h"
 #include "sh_pfc.h"
 
-#define PORT_GP_4(bank, fn, sfx)					\
-	PORT_GP_1(bank, 0,  fn, sfx), PORT_GP_1(bank, 1,  fn, sfx),	\
-	PORT_GP_1(bank, 2,  fn, sfx), PORT_GP_1(bank, 3,  fn, sfx)
-
-#define PORT_GP_15(bank, fn, sfx)					\
-	PORT_GP_4(bank, fn, sfx),					\
-	PORT_GP_1(bank, 4,  fn, sfx), PORT_GP_1(bank, 5,  fn, sfx),	\
-	PORT_GP_1(bank, 6,  fn, sfx), PORT_GP_1(bank, 7,  fn, sfx),	\
-	PORT_GP_1(bank, 8,  fn, sfx), PORT_GP_1(bank, 9,  fn, sfx),	\
-	PORT_GP_1(bank, 10, fn, sfx), PORT_GP_1(bank, 11, fn, sfx),	\
-	PORT_GP_1(bank, 12, fn, sfx), PORT_GP_1(bank, 13, fn, sfx),	\
-	PORT_GP_1(bank, 14, fn, sfx)
-
-#define PORT_GP_16(bank, fn, sfx)					\
-	PORT_GP_15(bank, fn, sfx),   PORT_GP_1(bank, 15, fn, sfx)
-
-#define PORT_GP_18(bank, fn, sfx)					\
-	PORT_GP_16(bank, fn, sfx),					\
-	PORT_GP_1(bank, 16, fn, sfx), PORT_GP_1(bank, 17, fn, sfx)
-
-#define PORT_GP_26(bank, fn, sfx)					\
-	PORT_GP_18(bank, fn, sfx),					\
-	PORT_GP_1(bank, 18, fn, sfx), PORT_GP_1(bank, 19, fn, sfx),	\
-	PORT_GP_1(bank, 20, fn, sfx), PORT_GP_1(bank, 21, fn, sfx),	\
-	PORT_GP_1(bank, 22, fn, sfx), PORT_GP_1(bank, 23, fn, sfx),	\
-	PORT_GP_1(bank, 24, fn, sfx), PORT_GP_1(bank, 25, fn, sfx)
-
-#define PORT_GP_28(bank, fn, sfx)					\
-	PORT_GP_26(bank, fn, sfx),					\
-	PORT_GP_1(bank, 26, fn, sfx), PORT_GP_1(bank, 27, fn, sfx)
-
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_16(0, fn, sfx),						\
 	PORT_GP_28(1, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index e7deb51..9d66865 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -14,14 +14,6 @@
 
 #include "sh_pfc.h"
 
-#define PORT_GP_12(bank, fn, sfx)					\
-	PORT_GP_1(bank, 0, fn, sfx),  PORT_GP_1(bank, 1, fn, sfx),	\
-	PORT_GP_1(bank, 2, fn, sfx),  PORT_GP_1(bank, 3, fn, sfx),	\
-	PORT_GP_1(bank, 4, fn, sfx),  PORT_GP_1(bank, 5, fn, sfx),	\
-	PORT_GP_1(bank, 6, fn, sfx),  PORT_GP_1(bank, 7, fn, sfx),	\
-	PORT_GP_1(bank, 8, fn, sfx),  PORT_GP_1(bank, 9, fn, sfx),	\
-	PORT_GP_1(bank, 10, fn, sfx), PORT_GP_1(bank, 11, fn, sfx)
-
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
 	PORT_GP_32(1, fn, sfx),						\
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 7b373d4..df16af6 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -205,22 +205,68 @@ struct sh_pfc_soc_info {
 #define PORT_GP_CFG_1(bank, pin, fn, sfx, cfg) fn(bank, pin, GP_##bank##_##pin, sfx, cfg)
 #define PORT_GP_1(bank, pin, fn, sfx)	PORT_GP_CFG_1(bank, pin, fn, sfx, 0)
 
-#define PORT_GP_CFG_32(bank, fn, sfx, cfg)				\
+#define PORT_GP_CFG_4(bank, fn, sfx, cfg)						\
 	PORT_GP_CFG_1(bank, 0,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 1,  fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 2,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 3,  fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 2,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 3,  fn, sfx, cfg)
+#define PORT_GP_4(bank, fn, sfx)	PORT_GP_CFG_4(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_8(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_4(bank, fn, sfx, cfg),						\
 	PORT_GP_CFG_1(bank, 4,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 5,  fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 6,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 7,  fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 6,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 7,  fn, sfx, cfg)
+#define PORT_GP_8(bank, fn, sfx)	PORT_GP_CFG_8(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_9(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_8(bank, fn, sfx, cfg),						\
+	PORT_GP_CFG_1(bank, 8,  fn, sfx, cfg)
+#define PORT_GP_9(bank, fn, sfx)	PORT_GP_CFG_9(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_12(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_8(bank, fn, sfx, cfg),						\
 	PORT_GP_CFG_1(bank, 8,  fn, sfx, cfg), PORT_GP_CFG_1(bank, 9,  fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 10, fn, sfx, cfg), PORT_GP_CFG_1(bank, 11, fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 12, fn, sfx, cfg), PORT_GP_CFG_1(bank, 13, fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 14, fn, sfx, cfg), PORT_GP_CFG_1(bank, 15, fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 16, fn, sfx, cfg), PORT_GP_CFG_1(bank, 17, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 10, fn, sfx, cfg), PORT_GP_CFG_1(bank, 11, fn, sfx, cfg)
+#define PORT_GP_12(bank, fn, sfx)	PORT_GP_CFG_12(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_14(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_12(bank, fn, sfx, cfg),						\
+	PORT_GP_CFG_1(bank, 12, fn, sfx, cfg), PORT_GP_CFG_1(bank, 13, fn, sfx, cfg)
+#define PORT_GP_14(bank, fn, sfx)	PORT_GP_CFG_14(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_15(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_14(bank, fn, sfx, cfg),						\
+	PORT_GP_CFG_1(bank, 14, fn, sfx, cfg)
+#define PORT_GP_15(bank, fn, sfx)	PORT_GP_CFG_15(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_16(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_14(bank, fn, sfx, cfg),						\
+	PORT_GP_CFG_1(bank, 14, fn, sfx, cfg), PORT_GP_CFG_1(bank, 15, fn, sfx, cfg)
+#define PORT_GP_16(bank, fn, sfx)	PORT_GP_CFG_16(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_18(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_16(bank, fn, sfx, cfg),						\
+	PORT_GP_CFG_1(bank, 16, fn, sfx, cfg), PORT_GP_CFG_1(bank, 17, fn, sfx, cfg)
+#define PORT_GP_18(bank, fn, sfx)	PORT_GP_CFG_18(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_26(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_18(bank, fn, sfx, cfg),						\
 	PORT_GP_CFG_1(bank, 18, fn, sfx, cfg), PORT_GP_CFG_1(bank, 19, fn, sfx, cfg),	\
 	PORT_GP_CFG_1(bank, 20, fn, sfx, cfg), PORT_GP_CFG_1(bank, 21, fn, sfx, cfg),	\
 	PORT_GP_CFG_1(bank, 22, fn, sfx, cfg), PORT_GP_CFG_1(bank, 23, fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 24, fn, sfx, cfg), PORT_GP_CFG_1(bank, 25, fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 26, fn, sfx, cfg), PORT_GP_CFG_1(bank, 27, fn, sfx, cfg),	\
-	PORT_GP_CFG_1(bank, 28, fn, sfx, cfg), PORT_GP_CFG_1(bank, 29, fn, sfx, cfg),	\
+	PORT_GP_CFG_1(bank, 24, fn, sfx, cfg), PORT_GP_CFG_1(bank, 25, fn, sfx, cfg)
+#define PORT_GP_26(bank, fn, sfx)	PORT_GP_CFG_26(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_28(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_26(bank, fn, sfx, cfg),						\
+	PORT_GP_CFG_1(bank, 26, fn, sfx, cfg), PORT_GP_CFG_1(bank, 27, fn, sfx, cfg)
+#define PORT_GP_28(bank, fn, sfx)	PORT_GP_CFG_28(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_30(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_28(bank, fn, sfx, cfg),						\
+	PORT_GP_CFG_1(bank, 28, fn, sfx, cfg), PORT_GP_CFG_1(bank, 29, fn, sfx, cfg)
+#define PORT_GP_30(bank, fn, sfx)	PORT_GP_CFG_30(bank, fn, sfx, 0)
+
+#define PORT_GP_CFG_32(bank, fn, sfx, cfg)						\
+	PORT_GP_CFG_30(bank, fn, sfx, cfg),						\
 	PORT_GP_CFG_1(bank, 30, fn, sfx, cfg), PORT_GP_CFG_1(bank, 31, fn, sfx, cfg)
 #define PORT_GP_32(bank, fn, sfx)	PORT_GP_CFG_32(bank, fn, sfx, 0)
 
-- 
1.9.1

