From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:02:07 +0000
Subject: [PATCH v3 47/64] sh-pfc: r8a7779: Remove USB function GPIOS
Message-Id: <1362740544-19164-48-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All r8a7779 platforms now use the pinctrl API to control the USB pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 8feceb5..085256c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2699,7 +2699,7 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(A19),
 
 	/* IPSR0 */
-	GPIO_FN(USB_PENC2), GPIO_FN(PWM1), GPIO_FN(PWMFSW0),
+	GPIO_FN(PWM1), GPIO_FN(PWMFSW0),
 	GPIO_FN(SCIF_CLK), GPIO_FN(TCLK0_C), GPIO_FN(BS),
 	GPIO_FN(FD2), GPIO_FN(ATADIR0), GPIO_FN(SDSELF),
 	GPIO_FN(HCTS1), GPIO_FN(A0),
@@ -2824,7 +2824,7 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VI1_FIELD),
 	GPIO_FN(VI3_FIELD), GPIO_FN(AUDIO_CLKOUT),
 	GPIO_FN(GPS_CLK_C), GPIO_FN(GPS_CLK_D), GPIO_FN(AUDIO_CLKA),
-	GPIO_FN(CAN_TXCLK), GPIO_FN(AUDIO_CLKB), GPIO_FN(USB_OVC2),
+	GPIO_FN(CAN_TXCLK), GPIO_FN(AUDIO_CLKB),
 	GPIO_FN(CAN_DEBUGOUT0), GPIO_FN(MOUT0),
 
 	/* IPSR6 */
@@ -2865,10 +2865,10 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(DACK2),
 
 	/* IPSR8 */
-	GPIO_FN(USB_OVC0), GPIO_FN(AD_CLK),
+	GPIO_FN(AD_CLK),
 	GPIO_FN(CC5_STATE4), GPIO_FN(CC5_STATE12), GPIO_FN(CC5_STATE20),
 	GPIO_FN(CC5_STATE28), GPIO_FN(CC5_STATE36),
-	GPIO_FN(USB_OVC1), GPIO_FN(AD_DI),
+	GPIO_FN(AD_DI),
 	GPIO_FN(CC5_STATE5), GPIO_FN(CC5_STATE13), GPIO_FN(CC5_STATE21),
 	GPIO_FN(CC5_STATE29), GPIO_FN(CC5_STATE37),
 	GPIO_FN(CAN_DEBUG_HW_TRIGGER), GPIO_FN(AD_DO),
-- 
1.8.1.5

