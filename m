From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 12 Nov 2015 14:12:12 +0000
Subject: [PATCH] pinctrl: sh-pfc: r8a7795: Rename SEL_SCIF to SEL_SATA
Message-Id: <1447337532-18258-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Cfr. Manual Errata for Rev 0.50 of the R-Car Gen3 datasheet.

This has no user-visible impact.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 29d001b8a727e154..bb5f37cbb9502d5f 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -495,7 +495,7 @@ FM(IP16_31_28)	IP16_31_28
 #define MOD_SEL1_13		FM(SEL_SCIF3_0)		FM(SEL_SCIF3_1)
 #define MOD_SEL1_12		FM(SEL_SCIF2_0)		FM(SEL_SCIF2_1)
 #define MOD_SEL1_11		FM(SEL_SCIF1_0)		FM(SEL_SCIF1_1)
-#define MOD_SEL1_10		FM(SEL_SCIF_0)		FM(SEL_SCIF_1)
+#define MOD_SEL1_10		FM(SEL_SATA_0)		FM(SEL_SATA_1)
 #define MOD_SEL1_9		FM(SEL_REMOCON_0)	FM(SEL_REMOCON_1)
 #define MOD_SEL1_6		FM(SEL_RCAN0_0)		FM(SEL_RCAN0_1)
 #define MOD_SEL1_5		FM(SEL_PWM6_0)		FM(SEL_PWM6_1)
@@ -1033,7 +1033,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_IPSR_DATA(IP9_19_16,	SD2_DAT3),
 
 	PINMUX_IPSR_DATA(IP9_23_20,	SD2_DS),
-	PINMUX_IPSR_MSEL(IP9_23_20,	SATA_DEVSLP_B,		SEL_SCIF_1),
+	PINMUX_IPSR_MSEL(IP9_23_20,	SATA_DEVSLP_B,		SEL_SATA_1),
 
 	PINMUX_IPSR_DATA(IP9_27_24,	SD3_DAT4),
 	PINMUX_IPSR_MSEL(IP9_27_24,	SD2_CD_A,		SEL_SDHI2_0),
@@ -1293,7 +1293,7 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_DATA(IP15_11_8,	SSI_SDATA6),
 	PINMUX_IPSR_MSEL(IP15_11_8,	SIM0_CLK_D,		SEL_SIMCARD_3),
-	PINMUX_IPSR_MSEL(IP15_11_8,	SATA_DEVSLP_A,		SEL_SCIF_0),
+	PINMUX_IPSR_MSEL(IP15_11_8,	SATA_DEVSLP_A,		SEL_SATA_0),
 
 	PINMUX_IPSR_DATA(IP15_15_12,	SSI_SCK78),
 	PINMUX_IPSR_MSEL(IP15_15_12,	HRX2_B,			SEL_HSCIF2_1),
-- 
1.9.1

