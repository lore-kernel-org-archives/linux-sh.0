From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:01:59 +0000
Subject: [PATCH v3 39/64] sh-pfc: sh73a0: Remove I2C function GPIOS
Message-Id: <1362740544-19164-40-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All sh73a0 platforms now use the pinctrl API to control the I2C pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 1bba1d8..db65ae1 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2684,13 +2684,9 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VINT),
 	GPIO_FN(TCKON),
 	GPIO_FN(XDVFS1), \
-	GPIO_FN(PORT27_I2C_SCL2), \
-	GPIO_FN(PORT27_I2C_SCL3), \
 	GPIO_FN(MFG0_OUT1), \
 	GPIO_FN(PORT27_IROUT),
 	GPIO_FN(XDVFS2), \
-	GPIO_FN(PORT28_I2C_SDA2), \
-	GPIO_FN(PORT28_I2C_SDA3), \
 	GPIO_FN(PORT28_TPU1TO1),
 	GPIO_FN(SIM_RST), \
 	GPIO_FN(PORT29_TPU1TO1),
@@ -2847,12 +2843,8 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(BBIF1_TXD),
 	GPIO_FN(HSI_RX_READY), \
 	GPIO_FN(BBIF1_RSCK), \
-	GPIO_FN(PORT115_I2C_SCL2), \
-	GPIO_FN(PORT115_I2C_SCL3),
 	GPIO_FN(HSI_RX_WAKE), \
 	GPIO_FN(BBIF1_RSYNC), \
-	GPIO_FN(PORT116_I2C_SDA2), \
-	GPIO_FN(PORT116_I2C_SDA3),
 	GPIO_FN(HSI_RX_FLAG), \
 	GPIO_FN(BBIF1_SS1), \
 	GPIO_FN(BBIF1_FLOW),
@@ -3000,9 +2992,7 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(MFG1_IN2), \
 	GPIO_FN(VIO2_VD2), \
 	GPIO_FN(MSIOF1_MCK0), \
-	GPIO_FN(PORT236_I2C_SDA2),
 	GPIO_FN(MSIOF1_MCK1), \
-	GPIO_FN(PORT237_I2C_SCL2),
 	GPIO_FN(MSIOF1_SS1), \
 	GPIO_FN(VIO2_FIELD2), \
 	GPIO_FN(MSIOF1_SS2), \
@@ -3025,11 +3015,9 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(TPU3TO1),
 	GPIO_FN(MFG2_OUT1), \
 	GPIO_FN(TPU2TO0), \
-	GPIO_FN(PORT248_I2C_SCL3), \
 	GPIO_FN(MSIOF2R_TSCK),
 	GPIO_FN(PORT249_IROUT), \
 	GPIO_FN(MFG4_IN1), \
-	GPIO_FN(PORT249_I2C_SDA3), \
 	GPIO_FN(MSIOF2R_TSYNC),
 	GPIO_FN(SDHICLK0),
 	GPIO_FN(SDHICD0),
-- 
1.8.1.5

