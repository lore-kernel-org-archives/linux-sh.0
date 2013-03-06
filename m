From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 06 Mar 2013 13:47:02 +0000
Subject: [PATCH v2 23/39] sh-pfc: sh7372: Remove SDHI and MMCIF function GPIOS
Message-Id: <1362577638-15493-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All sh7372 platforms now use the pinctrl API to control the SDHI and
MMCIF pins, the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index b4b54a0..78d0b77 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -1276,18 +1276,6 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(D11_NAF11),	GPIO_FN(D12_NAF12),	GPIO_FN(D13_NAF13),
 	GPIO_FN(D14_NAF14),	GPIO_FN(D15_NAF15),
 
-	/* MMCIF(1) */
-	GPIO_FN(MMCD0_0),	GPIO_FN(MMCD0_1),	GPIO_FN(MMCD0_2),
-	GPIO_FN(MMCD0_3),	GPIO_FN(MMCD0_4),	GPIO_FN(MMCD0_5),
-	GPIO_FN(MMCD0_6),	GPIO_FN(MMCD0_7),	GPIO_FN(MMCCMD0),
-	GPIO_FN(MMCCLK0),
-
-	/* MMCIF(2) */
-	GPIO_FN(MMCD1_0),	GPIO_FN(MMCD1_1),	GPIO_FN(MMCD1_2),
-	GPIO_FN(MMCD1_3),	GPIO_FN(MMCD1_4),	GPIO_FN(MMCD1_5),
-	GPIO_FN(MMCD1_6),	GPIO_FN(MMCD1_7),	GPIO_FN(MMCCLK1),
-	GPIO_FN(MMCCMD1),
-
 	/* SPU2 */
 	GPIO_FN(VINT_I),
 
@@ -1384,19 +1372,6 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	/* HDMI */
 	GPIO_FN(HDMI_HPD),	GPIO_FN(HDMI_CEC),
 
-	/* SDHI0 */
-	GPIO_FN(SDHICLK0),	GPIO_FN(SDHICD0),	GPIO_FN(SDHICMD0),
-	GPIO_FN(SDHIWP0),	GPIO_FN(SDHID0_0),	GPIO_FN(SDHID0_1),
-	GPIO_FN(SDHID0_2),	GPIO_FN(SDHID0_3),
-
-	/* SDHI1 */
-	GPIO_FN(SDHICLK1),	GPIO_FN(SDHICMD1),	GPIO_FN(SDHID1_0),
-	GPIO_FN(SDHID1_1),	GPIO_FN(SDHID1_2),	GPIO_FN(SDHID1_3),
-
-	/* SDHI2 */
-	GPIO_FN(SDHICLK2),	GPIO_FN(SDHICMD2),	GPIO_FN(SDHID2_0),
-	GPIO_FN(SDHID2_1),	GPIO_FN(SDHID2_2),	GPIO_FN(SDHID2_3),
-
 	/* SDENC */
 	GPIO_FN(SDENC_CPG),
 	GPIO_FN(SDENC_DV_CLKI),
-- 
1.8.1.5

