From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 15 Jan 2016 11:07:04 +0000
Subject: [PATCH 2/2] pinctrl: sh-pfc: r8a7795: Remove bits SEL_VSP_1 and SEL_VSP_0
Message-Id: <1452856024-10793-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1452856024-10793-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452856024-10793-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Cfr. Manual Errata for Rev 0.50 of the R-Car Gen3 datasheet.

This has no user-visible impact, as the definitions were not really
used.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index ca55ec92c7716e88..5091cffbc6128d26 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -478,7 +478,6 @@ FM(IP16_31_28)	IP16_31_28
 #define MOD_SEL2_31		FM(I2C_SEL_5_0)		FM(I2C_SEL_5_1)
 #define MOD_SEL2_30		FM(I2C_SEL_3_0)		FM(I2C_SEL_3_1)
 #define MOD_SEL2_29		FM(I2C_SEL_0_0)		FM(I2C_SEL_0_1)
-#define MOD_SEL2_2_1		FM(SEL_VSP_0)		FM(SEL_VSP_1)		FM(SEL_VSP_2)		FM(SEL_VSP_3)
 #define MOD_SEL2_0		FM(SEL_VIN4_0)		FM(SEL_VIN4_1)
 
 #define PINMUX_MOD_SELS\
@@ -512,7 +511,7 @@ MOD_SEL0_7_6 \
 MOD_SEL0_5_4		MOD_SEL1_5 \
 			MOD_SEL1_4 \
 MOD_SEL0_3		MOD_SEL1_3 \
-MOD_SEL0_2_1		MOD_SEL1_2		MOD_SEL2_2_1 \
+MOD_SEL0_2_1		MOD_SEL1_2 \
 			MOD_SEL1_1 \
 			MOD_SEL1_0		MOD_SEL2_0
 
@@ -4213,7 +4212,8 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 3 */
 		0, 0,
-		MOD_SEL2_2_1
+		/* RESERVED 2, 1 */
+		0, 0, 0, 0,
 		MOD_SEL2_0 }
 	},
 	{ },
-- 
1.9.1

