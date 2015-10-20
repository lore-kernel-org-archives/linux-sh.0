From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 20 Oct 2015 19:26:33 +0000
Subject: [PATCH/RFC 2/4] pinctrl: sh-pfc: r8a7790: Use PINMUX_SINGLE() instead of raw PINMUX_DATA()
Message-Id: <1445369195-25117-3-git-send-email-geert+renesas@glider.be>
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
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index d9924b0d53b789c3..1acad99d646618cb 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -806,15 +806,15 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(), /* PINMUX_DATA(GP_M_N_DATA, GP_M_N_FN...), */
 
-	PINMUX_DATA(VI1_DATA7_VI1_B7_MARK, FN_VI1_DATA7_VI1_B7),
-	PINMUX_DATA(USB0_PWEN_MARK, FN_USB0_PWEN),
-	PINMUX_DATA(USB0_OVC_VBUS_MARK, FN_USB0_OVC_VBUS),
-	PINMUX_DATA(USB2_PWEN_MARK, FN_USB2_PWEN),
-	PINMUX_DATA(USB2_OVC_MARK, FN_USB2_OVC),
-	PINMUX_DATA(AVS1_MARK, FN_AVS1),
-	PINMUX_DATA(AVS2_MARK, FN_AVS2),
-	PINMUX_DATA(DU_DOTCLKIN0_MARK, FN_DU_DOTCLKIN0),
-	PINMUX_DATA(DU_DOTCLKIN2_MARK, FN_DU_DOTCLKIN2),
+	PINMUX_SINGLE(VI1_DATA7_VI1_B7),
+	PINMUX_SINGLE(USB0_PWEN),
+	PINMUX_SINGLE(USB0_OVC_VBUS),
+	PINMUX_SINGLE(USB2_PWEN),
+	PINMUX_SINGLE(USB2_OVC),
+	PINMUX_SINGLE(AVS1),
+	PINMUX_SINGLE(AVS2),
+	PINMUX_SINGLE(DU_DOTCLKIN0),
+	PINMUX_SINGLE(DU_DOTCLKIN2),
 
 	PINMUX_IPSR_DATA(IP0_2_0, D0),
 	PINMUX_IPSR_MSEL(IP0_2_0, MSIOF3_SCK_B, SEL_SOF3_1),
-- 
1.9.1

