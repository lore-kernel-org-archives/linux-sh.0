From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 20 Oct 2015 19:26:34 +0000
Subject: [PATCH/RFC 3/4] pinctrl: sh-pfc: r8a7791: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
Message-Id: <1445369195-25117-4-git-send-email-geert+renesas@glider.be>
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
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 87a4f44147c1d5bc..ebadd2816b7b5dcf 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -787,23 +787,23 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
-	PINMUX_DATA(EX_CS0_N_MARK, FN_EX_CS0_N),
-	PINMUX_DATA(RD_N_MARK, FN_RD_N),
-	PINMUX_DATA(AUDIO_CLKA_MARK, FN_AUDIO_CLKA),
-	PINMUX_DATA(VI0_CLK_MARK, FN_VI0_CLK),
-	PINMUX_DATA(VI0_DATA0_VI0_B0_MARK, FN_VI0_DATA0_VI0_B0),
-	PINMUX_DATA(VI0_DATA1_VI0_B1_MARK, FN_VI0_DATA1_VI0_B1),
-	PINMUX_DATA(VI0_DATA2_VI0_B2_MARK, FN_VI0_DATA2_VI0_B2),
-	PINMUX_DATA(VI0_DATA4_VI0_B4_MARK, FN_VI0_DATA4_VI0_B4),
-	PINMUX_DATA(VI0_DATA5_VI0_B5_MARK, FN_VI0_DATA5_VI0_B5),
-	PINMUX_DATA(VI0_DATA6_VI0_B6_MARK, FN_VI0_DATA6_VI0_B6),
-	PINMUX_DATA(VI0_DATA7_VI0_B7_MARK, FN_VI0_DATA7_VI0_B7),
-	PINMUX_DATA(USB0_PWEN_MARK, FN_USB0_PWEN),
-	PINMUX_DATA(USB0_OVC_MARK, FN_USB0_OVC),
-	PINMUX_DATA(USB1_PWEN_MARK, FN_USB1_PWEN),
-	PINMUX_DATA(USB1_OVC_MARK, FN_USB1_OVC),
-	PINMUX_DATA(DU0_DOTCLKIN_MARK, FN_DU0_DOTCLKIN),
-	PINMUX_DATA(SD1_CLK_MARK, FN_SD1_CLK),
+	PINMUX_SINGLE(EX_CS0_N),
+	PINMUX_SINGLE(RD_N),
+	PINMUX_SINGLE(AUDIO_CLKA),
+	PINMUX_SINGLE(VI0_CLK),
+	PINMUX_SINGLE(VI0_DATA0_VI0_B0),
+	PINMUX_SINGLE(VI0_DATA1_VI0_B1),
+	PINMUX_SINGLE(VI0_DATA2_VI0_B2),
+	PINMUX_SINGLE(VI0_DATA4_VI0_B4),
+	PINMUX_SINGLE(VI0_DATA5_VI0_B5),
+	PINMUX_SINGLE(VI0_DATA6_VI0_B6),
+	PINMUX_SINGLE(VI0_DATA7_VI0_B7),
+	PINMUX_SINGLE(USB0_PWEN),
+	PINMUX_SINGLE(USB0_OVC),
+	PINMUX_SINGLE(USB1_PWEN),
+	PINMUX_SINGLE(USB1_OVC),
+	PINMUX_SINGLE(DU0_DOTCLKIN),
+	PINMUX_SINGLE(SD1_CLK),
 
 	/* IPSR0 */
 	PINMUX_IPSR_DATA(IP0_0, D0),
-- 
1.9.1

