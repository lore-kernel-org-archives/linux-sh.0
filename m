From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 20 Oct 2015 19:26:35 +0000
Subject: [PATCH/RFC 4/4] pinctrl: sh-pfc: r8a7794: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
Message-Id: <1445369195-25117-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445369195-25117-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 44 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
index 086f6798b1294564..3324ee75e71c69b5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7794.c
@@ -618,28 +618,28 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
-	PINMUX_DATA(A2_MARK, FN_A2),
-	PINMUX_DATA(WE0_N_MARK, FN_WE0_N),
-	PINMUX_DATA(WE1_N_MARK, FN_WE1_N),
-	PINMUX_DATA(DACK0_MARK, FN_DACK0),
-	PINMUX_DATA(USB0_PWEN_MARK, FN_USB0_PWEN),
-	PINMUX_DATA(USB0_OVC_MARK, FN_USB0_OVC),
-	PINMUX_DATA(USB1_PWEN_MARK, FN_USB1_PWEN),
-	PINMUX_DATA(USB1_OVC_MARK, FN_USB1_OVC),
-	PINMUX_DATA(SD0_CLK_MARK, FN_SD0_CLK),
-	PINMUX_DATA(SD0_CMD_MARK, FN_SD0_CMD),
-	PINMUX_DATA(SD0_DATA0_MARK, FN_SD0_DATA0),
-	PINMUX_DATA(SD0_DATA1_MARK, FN_SD0_DATA1),
-	PINMUX_DATA(SD0_DATA2_MARK, FN_SD0_DATA2),
-	PINMUX_DATA(SD0_DATA3_MARK, FN_SD0_DATA3),
-	PINMUX_DATA(SD0_CD_MARK, FN_SD0_CD),
-	PINMUX_DATA(SD0_WP_MARK, FN_SD0_WP),
-	PINMUX_DATA(SD1_CLK_MARK, FN_SD1_CLK),
-	PINMUX_DATA(SD1_CMD_MARK, FN_SD1_CMD),
-	PINMUX_DATA(SD1_DATA0_MARK, FN_SD1_DATA0),
-	PINMUX_DATA(SD1_DATA1_MARK, FN_SD1_DATA1),
-	PINMUX_DATA(SD1_DATA2_MARK, FN_SD1_DATA2),
-	PINMUX_DATA(SD1_DATA3_MARK, FN_SD1_DATA3),
+	PINMUX_SINGLE(A2),
+	PINMUX_SINGLE(WE0_N),
+	PINMUX_SINGLE(WE1_N),
+	PINMUX_SINGLE(DACK0),
+	PINMUX_SINGLE(USB0_PWEN),
+	PINMUX_SINGLE(USB0_OVC),
+	PINMUX_SINGLE(USB1_PWEN),
+	PINMUX_SINGLE(USB1_OVC),
+	PINMUX_SINGLE(SD0_CLK),
+	PINMUX_SINGLE(SD0_CMD),
+	PINMUX_SINGLE(SD0_DATA0),
+	PINMUX_SINGLE(SD0_DATA1),
+	PINMUX_SINGLE(SD0_DATA2),
+	PINMUX_SINGLE(SD0_DATA3),
+	PINMUX_SINGLE(SD0_CD),
+	PINMUX_SINGLE(SD0_WP),
+	PINMUX_SINGLE(SD1_CLK),
+	PINMUX_SINGLE(SD1_CMD),
+	PINMUX_SINGLE(SD1_DATA0),
+	PINMUX_SINGLE(SD1_DATA1),
+	PINMUX_SINGLE(SD1_DATA2),
+	PINMUX_SINGLE(SD1_DATA3),
 
 	/* IPSR0 */
 	PINMUX_IPSR_DATA(IP0_0, SD1_CD),
-- 
1.9.1

