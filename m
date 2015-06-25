From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 25 Jun 2015 22:42:04 +0000
Subject: [PATCH v3 2/3] sh-pfc: r8a7790: remove non-existing GPIO pins
Message-Id: <14360647.s1qTxSuam8@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
In-Reply-To: <1460630.GxHT4lRd7u@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org
Cc: linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

GPIO banks 1 and 2 are missing pins 30 and 31. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- renamed the patch.

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -27,10 +27,27 @@
 #include "core.h"
 #include "sh_pfc.h"
 
+#define PORT_GP_30(bank, fn, sfx)					\
+	PORT_GP_1(bank, 0,  fn, sfx), PORT_GP_1(bank, 1,  fn, sfx),	\
+	PORT_GP_1(bank, 2,  fn, sfx), PORT_GP_1(bank, 3,  fn, sfx),	\
+	PORT_GP_1(bank, 4,  fn, sfx), PORT_GP_1(bank, 5,  fn, sfx),	\
+	PORT_GP_1(bank, 6,  fn, sfx), PORT_GP_1(bank, 7,  fn, sfx),	\
+	PORT_GP_1(bank, 8,  fn, sfx), PORT_GP_1(bank, 9,  fn, sfx),	\
+	PORT_GP_1(bank, 10, fn, sfx), PORT_GP_1(bank, 11, fn, sfx),	\
+	PORT_GP_1(bank, 12, fn, sfx), PORT_GP_1(bank, 13, fn, sfx),	\
+	PORT_GP_1(bank, 14, fn, sfx), PORT_GP_1(bank, 15, fn, sfx),	\
+	PORT_GP_1(bank, 16, fn, sfx), PORT_GP_1(bank, 17, fn, sfx),	\
+	PORT_GP_1(bank, 18, fn, sfx), PORT_GP_1(bank, 19, fn, sfx),	\
+	PORT_GP_1(bank, 20, fn, sfx), PORT_GP_1(bank, 21, fn, sfx),	\
+	PORT_GP_1(bank, 22, fn, sfx), PORT_GP_1(bank, 23, fn, sfx),	\
+	PORT_GP_1(bank, 24, fn, sfx), PORT_GP_1(bank, 25, fn, sfx),	\
+	PORT_GP_1(bank, 26, fn, sfx), PORT_GP_1(bank, 27, fn, sfx),	\
+	PORT_GP_1(bank, 28, fn, sfx), PORT_GP_1(bank, 29, fn, sfx)
+
 #define CPU_ALL_PORT(fn, sfx)						\
 	PORT_GP_32(0, fn, sfx),						\
-	PORT_GP_32(1, fn, sfx),						\
-	PORT_GP_32(2, fn, sfx),						\
+	PORT_GP_30(1, fn, sfx),						\
+	PORT_GP_30(2, fn, sfx),						\
 	PORT_GP_32(3, fn, sfx),						\
 	PORT_GP_32(4, fn, sfx),						\
 	PORT_GP_32(5, fn, sfx)

