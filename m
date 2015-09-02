From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 02 Sep 2015 18:51:49 +0000
Subject: [PATCH 1/2] [RFC] pinctrl: sh-pfc: r8a7795: Add pinmux data for single-function pins
Message-Id: <1441219910-28964-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Pins that (1) can be configured as either GPIO or a single peripheral
function, and (2) that don't need configuration in an IPSRx register,
should still be listed in the pinmux_data[] array.

Else selecting the peripheral function fails with e.g.:

    sh-pfc e6060000.pfc: cannot locate data/mark enum_id for mark 1281

(mark 1281 is MSIOF0_SCK_MARK).

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Mechanism derived from looking at pfc-r8a7791.c
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 5a709fc82a9fac5a..61e6faf9bf1a4316 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -581,6 +581,25 @@ enum {
 static const u16 pinmux_data[] = {
 	PINMUX_DATA_GP_ALL(),
 
+	PINMUX_DATA(AVS1_MARK, FN_AVS1),
+	PINMUX_DATA(AVS2_MARK, FN_AVS2),
+	PINMUX_DATA(HDMI0_CEC_MARK, FN_HDMI0_CEC),
+	PINMUX_DATA(HDMI1_CEC_MARK, FN_HDMI1_CEC),
+	PINMUX_DATA(MSIOF0_RXD_MARK, FN_MSIOF0_RXD),
+	PINMUX_DATA(MSIOF0_SCK_MARK, FN_MSIOF0_SCK),
+	PINMUX_DATA(MSIOF0_TXD_MARK, FN_MSIOF0_TXD),
+	PINMUX_DATA(SD2_CMD_MARK, FN_SD2_CMD),
+	PINMUX_DATA(SD3_CLK_MARK, FN_SD3_CLK),
+	PINMUX_DATA(SD3_CMD_MARK, FN_SD3_CMD),
+	PINMUX_DATA(SD3_DAT0_MARK, FN_SD3_DAT0),
+	PINMUX_DATA(SD3_DAT1_MARK, FN_SD3_DAT1),
+	PINMUX_DATA(SD3_DAT2_MARK, FN_SD3_DAT2),
+	PINMUX_DATA(SD3_DAT3_MARK, FN_SD3_DAT3),
+	PINMUX_DATA(SD3_DS_MARK, FN_SD3_DS),
+	PINMUX_DATA(SSI_SCK5_MARK, FN_SSI_SCK5),
+	PINMUX_DATA(SSI_SDATA5_MARK, FN_SSI_SDATA5),
+	PINMUX_DATA(SSI_WS5_MARK, FN_SSI_WS5),
+
 	/* IPSR0 */
 	PINMUX_IPSR_DATA(IP0_3_0,	AVB_MDC),
 	PINMUX_IPSR_MSEL(IP0_3_0,	MSIOF2_SS2_C,		SEL_MSIOF2_2),
-- 
1.9.1

