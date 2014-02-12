From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 12 Feb 2014 04:26:10 +0000
Subject: [PATCH 02/03] pinctrl: sh-pfc: r8a7791: SD1_CLK fix
Message-Id: <20140212042610.10516.36546.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix the SD1_CLK handling for r8a7791. Without this patch
it is impossible to request all pins needed for SDHI1 on
the Koelsch board.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ work/drivers/pinctrl/sh-pfc/pfc-r8a7791.c	2014-02-10 16:17:41.000000000 +0900
@@ -89,7 +89,8 @@ enum {
 
 	/* GPSR6 */
 	FN_IP13_10, FN_IP13_11, FN_IP13_12, FN_IP13_13, FN_IP13_14,
-	FN_IP13_15, FN_IP13_18_16, FN_IP13_21_19, FN_IP13_22, FN_IP13_24_23,
+	FN_IP13_15, FN_IP13_18_16, FN_IP13_21_19,
+	FN_IP13_22, FN_IP13_24_23, FN_SD1_CLK,
 	FN_IP13_25, FN_IP13_26, FN_IP13_27, FN_IP13_30_28, FN_IP14_1_0,
 	FN_IP14_2, FN_IP14_3, FN_IP14_4, FN_IP14_5, FN_IP14_6, FN_IP14_7,
 	FN_IP14_10_8, FN_IP14_13_11, FN_IP14_16_14, FN_IP14_19_17,
@@ -788,6 +789,7 @@ static const u16 pinmux_data[] = {
 	PINMUX_DATA(USB1_PWEN_MARK, FN_USB1_PWEN),
 	PINMUX_DATA(USB1_OVC_MARK, FN_USB1_OVC),
 	PINMUX_DATA(DU0_DOTCLKIN_MARK, FN_DU0_DOTCLKIN),
+	PINMUX_DATA(SD1_CLK_MARK, FN_SD1_CLK),
 
 	/* IPSR0 */
 	PINMUX_IPSR_DATA(IP0_0, D0),
@@ -3825,7 +3827,7 @@ static const struct pinmux_cfg_reg pinmu
 		GP_6_11_FN, FN_IP13_25,
 		GP_6_10_FN, FN_IP13_24_23,
 		GP_6_9_FN, FN_IP13_22,
-		0, 0,
+		GP_6_8_FN, FN_SD1_CLK,
 		GP_6_7_FN, FN_IP13_21_19,
 		GP_6_6_FN, FN_IP13_18_16,
 		GP_6_5_FN, FN_IP13_15,
