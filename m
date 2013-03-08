From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 08 Mar 2013 11:02:08 +0000
Subject: [PATCH v3 48/64] sh-pfc: r8a7779: Remove LBSC function GPIOS
Message-Id: <1362740544-19164-49-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All r8a7779 platforms now use the pinctrl API to control the LBSC pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
index 085256c..14a247d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
@@ -2712,22 +2712,20 @@ static struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(SSI_WS78_B), GPIO_FN(A25),
 	GPIO_FN(FD5), GPIO_FN(VI1_R3),
 	GPIO_FN(SSI_SDATA7_B), GPIO_FN(CLKOUT),
-	GPIO_FN(PWM0_B), GPIO_FN(CS0),
-	GPIO_FN(CS1_A26),
+	GPIO_FN(PWM0_B),
 	GPIO_FN(SDSELF_B), GPIO_FN(RD_WR), GPIO_FN(FWE), GPIO_FN(ATAG0),
 	GPIO_FN(VI1_R7), GPIO_FN(HRTS1),
 
 	/* IPSR1 */
-	GPIO_FN(EX_CS0),
-	GPIO_FN(FD6), GPIO_FN(EX_CS1), GPIO_FN(FD7),
-	GPIO_FN(EX_CS2), GPIO_FN(FALE),
-	GPIO_FN(ATACS00), GPIO_FN(EX_CS3),
+	GPIO_FN(FD6), GPIO_FN(FD7),
+	GPIO_FN(FALE),
+	GPIO_FN(ATACS00),
 	GPIO_FN(FRE), GPIO_FN(ATACS10), GPIO_FN(VI1_R4),
 	GPIO_FN(HSCK1), GPIO_FN(SSI_SDATA8_B),
-	GPIO_FN(SSI_SDATA9), GPIO_FN(EX_CS4),
+	GPIO_FN(SSI_SDATA9),
 	GPIO_FN(FD0), GPIO_FN(ATARD0), GPIO_FN(VI1_R5),
 	GPIO_FN(HTX1),
-	GPIO_FN(SSI_SCK9), GPIO_FN(EX_CS5),
+	GPIO_FN(SSI_SCK9),
 	GPIO_FN(FD1),	GPIO_FN(ATAWR0), GPIO_FN(VI1_R6),
 	GPIO_FN(HRX1), GPIO_FN(SSI_WS9),
 	GPIO_FN(MLB_CLK), GPIO_FN(PWM2), GPIO_FN(MLB_SIG),
-- 
1.8.1.5

