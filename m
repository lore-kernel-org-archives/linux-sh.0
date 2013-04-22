From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:00:07 +0000
Subject: [PATCH 26/37] sh-pfc: r8a7740: Remove FSI function GPIOS
Message-Id: <1366671618-8796-27-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All r8a7740 platforms now use the pinctrl API to control the FSI pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 7ab4ff2..a93fd84 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3207,18 +3207,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(DBGMD10),	GPIO_FN(DBGMD11),	GPIO_FN(DBGMD20),
 	GPIO_FN(DBGMD21),
 
-	/* FSI-A */
-	GPIO_FN(FSIAISLD_PORT0),	/* FSIAISLD Port 0/5 */
-	GPIO_FN(FSIAISLD_PORT5),
-	GPIO_FN(FSIASPDIF_PORT9),	/* FSIASPDIF Port 9/18 */
-	GPIO_FN(FSIASPDIF_PORT18),
-	GPIO_FN(FSIAOSLD1),	GPIO_FN(FSIAOSLD2),	GPIO_FN(FSIAOLR),
-	GPIO_FN(FSIAOBT),	GPIO_FN(FSIAOSLD),	GPIO_FN(FSIAOMC),
-	GPIO_FN(FSIACK),	GPIO_FN(FSIAILR),	GPIO_FN(FSIAIBT),
-
-	/* FSI-B */
-	GPIO_FN(FSIBCK),
-
 	/* FMSI */
 	GPIO_FN(FMSISLD_PORT1), /* FMSISLD Port 1/6 */
 	GPIO_FN(FMSISLD_PORT6),
-- 
1.8.1.5

