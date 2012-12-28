From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:53:43 +0000
Subject: [PATCH v4 01/81] sh: sh7264: Rename CRX0CRX1 mark to match GPIO names
Message-Id: <1356735303-29474-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Rename CRX0CRX1_MARK to CRX0_CRX1_MARK to match the GPIO_FN_CRX0_CRX1
name.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
index b055b55..79a0d60 100644
--- a/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
+++ b/arch/sh/kernel/cpu/sh2a/pinmux-sh7264.c
@@ -505,7 +505,7 @@ enum {
 	PWM2A_MARK, PWM2B_MARK, PWM2C_MARK, PWM2D_MARK,
 	PWM2E_MARK, PWM2F_MARK, PWM2G_MARK, PWM2H_MARK,
 	IERXD_MARK, IETXD_MARK,
-	CRX0CRX1_MARK,
+	CRX0_CRX1_MARK,
 	WDTOVF_MARK,
 
 	CRX0X1_MARK,
@@ -1003,7 +1003,7 @@ static pinmux_enum_t pinmux_data[] = {
 
 	PINMUX_DATA(PJ2_DATA, PJ2MD_000),
 	PINMUX_DATA(CTX1_MARK, PJ2MD_001),
-	PINMUX_DATA(CRX0CRX1_MARK, PJ2MD_010),
+	PINMUX_DATA(CRX0_CRX1_MARK, PJ2MD_010),
 	PINMUX_DATA(CS2_MARK, PJ2MD_011),
 	PINMUX_DATA(SCK0_MARK, PJ2MD_100),
 	PINMUX_DATA(LCD_M_DISP_MARK, PJ2MD_101),
@@ -1246,7 +1246,7 @@ static struct pinmux_gpio pinmux_gpios[] = {
 	PINMUX_GPIO(GPIO_FN_CRX1, CRX1_MARK),
 	PINMUX_GPIO(GPIO_FN_CTX0, CTX0_MARK),
 	PINMUX_GPIO(GPIO_FN_CRX0, CRX0_MARK),
-	PINMUX_GPIO(GPIO_FN_CRX0_CRX1, CRX0CRX1_MARK),
+	PINMUX_GPIO(GPIO_FN_CRX0_CRX1, CRX0_CRX1_MARK),
 
 	/* DMAC */
 	PINMUX_GPIO(GPIO_FN_TEND0, TEND0_MARK),
-- 
1.7.8.6

