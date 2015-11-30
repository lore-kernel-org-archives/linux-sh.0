From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:41:03 +0000
Subject: [PATCH 2/4] pinctrl: sh-pfc: r8a7778: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
Message-Id: <1448890865-1856-3-git-send-email-geert+renesas@glider.be>
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
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
index 6b6e5aa2db0d7d10..411d0887ba19bae6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7778.c
@@ -548,17 +548,17 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
-	PINMUX_DATA(PENC0_MARK,		FN_PENC0),
-	PINMUX_DATA(PENC1_MARK,		FN_PENC1),
-	PINMUX_DATA(A1_MARK,		FN_A1),
-	PINMUX_DATA(A2_MARK,		FN_A2),
-	PINMUX_DATA(A3_MARK,		FN_A3),
-	PINMUX_DATA(WE0_MARK,		FN_WE0),
-	PINMUX_DATA(AUDIO_CLKA_MARK,	FN_AUDIO_CLKA),
-	PINMUX_DATA(AUDIO_CLKB_MARK,	FN_AUDIO_CLKB),
-	PINMUX_DATA(SSI_SCK34_MARK,	FN_SSI_SCK34),
-	PINMUX_DATA(AVS1_MARK,		FN_AVS1),
-	PINMUX_DATA(AVS2_MARK,		FN_AVS2),
+	PINMUX_SINGLE(PENC0),
+	PINMUX_SINGLE(PENC1),
+	PINMUX_SINGLE(A1),
+	PINMUX_SINGLE(A2),
+	PINMUX_SINGLE(A3),
+	PINMUX_SINGLE(WE0),
+	PINMUX_SINGLE(AUDIO_CLKA),
+	PINMUX_SINGLE(AUDIO_CLKB),
+	PINMUX_SINGLE(SSI_SCK34),
+	PINMUX_SINGLE(AVS1),
+	PINMUX_SINGLE(AVS2),
 
 	/* IPSR0 */
 	PINMUX_IPSR_GPSR(IP0_1_0,	PRESETOUT),
-- 
1.9.1

