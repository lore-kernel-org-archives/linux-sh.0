From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 13:49:38 +0000
Subject: [PATCH v2 1/2] pinctrl: sh-pfc: r8a7795: Add pinmux data for single-function pins
Message-Id: <1448891379-2457-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448891379-2457-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448891379-2457-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Pins that (1) can be configured as either GPIO or a single peripheral
function, and (2) that don't need configuration in an IPSRx register,
should still be listed in the pinmux_data[] array.

Else selecting the peripheral function fails with e.g.:

    sh-pfc e6060000.pfc: cannot locate data/mark enum_id for mark 1281

(mark 1281 is MSIOF0_SCK_MARK).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This depends on "pinctrl: sh-pfc: Add PINMUX_SINGLE()".

v2:
  - Use PINMUX_SINGLE() instead of raw PINMUX_DATA().
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 678c3801e999453c..e9dafe3d3320eb9f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -580,6 +580,25 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(),
 
+	PINMUX_SINGLE(AVS1),
+	PINMUX_SINGLE(AVS2),
+	PINMUX_SINGLE(HDMI0_CEC),
+	PINMUX_SINGLE(HDMI1_CEC),
+	PINMUX_SINGLE(MSIOF0_RXD),
+	PINMUX_SINGLE(MSIOF0_SCK),
+	PINMUX_SINGLE(MSIOF0_TXD),
+	PINMUX_SINGLE(SD2_CMD),
+	PINMUX_SINGLE(SD3_CLK),
+	PINMUX_SINGLE(SD3_CMD),
+	PINMUX_SINGLE(SD3_DAT0),
+	PINMUX_SINGLE(SD3_DAT1),
+	PINMUX_SINGLE(SD3_DAT2),
+	PINMUX_SINGLE(SD3_DAT3),
+	PINMUX_SINGLE(SD3_DS),
+	PINMUX_SINGLE(SSI_SCK5),
+	PINMUX_SINGLE(SSI_SDATA5),
+	PINMUX_SINGLE(SSI_WS5),
+
 	/* IPSR0 */
 	PINMUX_IPSR_GPSR(IP0_3_0,	AVB_MDC),
 	PINMUX_IPSR_MSEL(IP0_3_0,	MSIOF2_SS2_C,		SEL_MSIOF2_2),
-- 
1.9.1

