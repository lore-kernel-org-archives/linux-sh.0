From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:02:09 +0000
Subject: [PATCH v3 49/64] sh-pfc: r8a7779: Remove INTC function GPIOS
Message-Id: <1362740544-19164-50-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All r8a7779 platforms now use the pinctrl API to control the INTC pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 14a247d..4d928c5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2848,12 +2848,11 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(SSI_WS6), GPIO_FN(ADICHS1), GPIO_FN(CAN0_RX), GPIO_FN(IETX_B),
 	GPIO_FN(SSI_SDATA6), GPIO_FN(ADICHS2), GPIO_FN(CAN_CLK),
 	GPIO_FN(IECLK_B), GPIO_FN(SSI_SCK78), GPIO_FN(CAN_DEBUGOUT13),
-	GPIO_FN(IRQ0_B), GPIO_FN(SSI_SCK9_B),
-	GPIO_FN(SSI_WS78), GPIO_FN(CAN_DEBUGOUT14), GPIO_FN(IRQ1_B),
+	GPIO_FN(SSI_SCK9_B),
+	GPIO_FN(SSI_WS78), GPIO_FN(CAN_DEBUGOUT14),
 	GPIO_FN(SSI_WS9_B), GPIO_FN(SSI_SDATA7),
-	GPIO_FN(CAN_DEBUGOUT15), GPIO_FN(IRQ2_B), GPIO_FN(TCLK1_C),
+	GPIO_FN(CAN_DEBUGOUT15), GPIO_FN(TCLK1_C),
 	GPIO_FN(SSI_SDATA8), GPIO_FN(VSP),
-	GPIO_FN(IRQ3_B),
 	GPIO_FN(ATACS01), GPIO_FN(ATACS11),
 	GPIO_FN(CC5_TDO), GPIO_FN(ATADIR1),
 	GPIO_FN(CC5_TRST), GPIO_FN(ATAG1),
@@ -2892,8 +2891,8 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(VI0_DATA5_VI0_B5), GPIO_FN(VI0_DATA6_VI0_B6),
 	GPIO_FN(ARM_TRACEDATA_0), GPIO_FN(VI0_DATA7_VI0_B7),
 	GPIO_FN(ARM_TRACEDATA_1), GPIO_FN(VI0_G0),
-	GPIO_FN(SSI_SCK78_C), GPIO_FN(IRQ0), GPIO_FN(ARM_TRACEDATA_2),
-	GPIO_FN(VI0_G1), GPIO_FN(SSI_WS78_C), GPIO_FN(IRQ1),
+	GPIO_FN(SSI_SCK78_C), GPIO_FN(ARM_TRACEDATA_2),
+	GPIO_FN(VI0_G1), GPIO_FN(SSI_WS78_C),
 	GPIO_FN(ARM_TRACEDATA_3), GPIO_FN(VI0_G2), GPIO_FN(ETH_TXD1),
 	GPIO_FN(ARM_TRACEDATA_4), GPIO_FN(TS_SPSYNC0),
 	GPIO_FN(VI0_G3), GPIO_FN(ETH_CRS_DV),
@@ -2909,9 +2908,9 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(DREQ1_B), GPIO_FN(ARM_TRACEDATA_10), GPIO_FN(DREQ0_C),
 	GPIO_FN(VI0_R1), GPIO_FN(SSI_SDATA8_C), GPIO_FN(DACK1_B),
 	GPIO_FN(ARM_TRACEDATA_11), GPIO_FN(DACK0_C), GPIO_FN(DRACK0_C),
-	GPIO_FN(VI0_R2), GPIO_FN(ETH_LINK), GPIO_FN(IRQ2),
+	GPIO_FN(VI0_R2), GPIO_FN(ETH_LINK),
 	GPIO_FN(ARM_TRACEDATA_12), GPIO_FN(VI0_R3), GPIO_FN(ETH_MAGIC),
-	GPIO_FN(IRQ3), GPIO_FN(ARM_TRACEDATA_13),
+	GPIO_FN(ARM_TRACEDATA_13),
 	GPIO_FN(VI0_R4), GPIO_FN(ETH_REFCLK),
 	GPIO_FN(ARM_TRACEDATA_14), GPIO_FN(MT1_CLK),
 	GPIO_FN(TS_SCK0), GPIO_FN(VI0_R5), GPIO_FN(ETH_TXD0),
-- 
1.8.1.5

