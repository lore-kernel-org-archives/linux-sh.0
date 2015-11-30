From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:41:05 +0000
Subject: [PATCH 4/4] pinctrl: sh-pfc: sh7734: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
Message-Id: <1448890865-1856-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448890865-1856-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448890865-1856-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-sh7734.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7734.c b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
index 5243da3564c84a1a..9e5212fb49fa516c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7734.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7734.c
@@ -585,15 +585,18 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
-	PINMUX_DATA(CLKOUT_MARK, FN_CLKOUT),
-	PINMUX_DATA(BS_MARK, FN_BS), PINMUX_DATA(CS0_MARK, FN_CS0),
-	PINMUX_DATA(EX_CS0_MARK, FN_EX_CS0),
-	PINMUX_DATA(RD_MARK, FN_RD), PINMUX_DATA(WE0_MARK, FN_WE0),
-	PINMUX_DATA(WE1_MARK, FN_WE1),
-	PINMUX_DATA(SCL0_MARK, FN_SCL0), PINMUX_DATA(PENC0_MARK, FN_PENC0),
-	PINMUX_DATA(USB_OVC0_MARK, FN_USB_OVC0),
-	PINMUX_DATA(IRQ2_B_MARK, FN_IRQ2_B),
-		PINMUX_DATA(IRQ3_B_MARK, FN_IRQ3_B),
+	PINMUX_SINGLE(CLKOUT),
+	PINMUX_SINGLE(BS),
+	PINMUX_SINGLE(CS0),
+	PINMUX_SINGLE(EX_CS0),
+	PINMUX_SINGLE(RD),
+	PINMUX_SINGLE(WE0),
+	PINMUX_SINGLE(WE1),
+	PINMUX_SINGLE(SCL0),
+	PINMUX_SINGLE(PENC0),
+	PINMUX_SINGLE(USB_OVC0),
+	PINMUX_SINGLE(IRQ2_B),
+	PINMUX_SINGLE(IRQ3_B),
 
 	/* IPSR0 */
 	PINMUX_IPSR_GPSR(IP0_1_0, A0),
-- 
1.9.1

