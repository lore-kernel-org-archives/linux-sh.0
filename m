From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 19 Feb 2010 07:52:12 +0000
Subject: [PATCH] ARM: mach-shmobile: pfc-sh7377: modify KEYIN settings
Message-Id: <ur5ohpsh7.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/arm/mach-shmobile/pfc-sh7377.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/pfc-sh7377.c b/arch/arm/mach-shmobile/pfc-sh7377.c
index 79b53d8..613e684 100644
--- a/arch/arm/mach-shmobile/pfc-sh7377.c
+++ b/arch/arm/mach-shmobile/pfc-sh7377.c
@@ -102,6 +102,7 @@ enum {
 	PORT_265(FN7), /* PORT0_FN7 -> PORT264_FN7 */
 
 	MSELBCR_MSEL17_1, MSELBCR_MSEL17_0,
+	MSELBCR_MSEL16_1, MSELBCR_MSEL16_0,
 	PINMUX_FUNCTION_END,
 
 	PINMUX_MARK_BEGIN,
@@ -528,19 +529,19 @@ static pinmux_enum_t pinmux_data[] = {
 	PORT_DATA_IO_PU_PD(263),
 
 	/* Special Pull-up / Pull-down Functions */
-	PINMUX_DATA(PORT66_KEYIN0_PU_MARK, MSELBCR_MSEL17_0,
+	PINMUX_DATA(PORT66_KEYIN0_PU_MARK, MSELBCR_MSEL17_0, MSELBCR_MSEL16_0,
 				PORT66_FN2, PORT66_IN_PU),
-	PINMUX_DATA(PORT67_KEYIN1_PU_MARK, MSELBCR_MSEL17_0,
+	PINMUX_DATA(PORT67_KEYIN1_PU_MARK, MSELBCR_MSEL17_0, MSELBCR_MSEL16_0,
 				PORT67_FN2, PORT67_IN_PU),
-	PINMUX_DATA(PORT68_KEYIN2_PU_MARK, MSELBCR_MSEL17_0,
+	PINMUX_DATA(PORT68_KEYIN2_PU_MARK, MSELBCR_MSEL17_0, MSELBCR_MSEL16_0,
 				PORT68_FN2, PORT68_IN_PU),
-	PINMUX_DATA(PORT69_KEYIN3_PU_MARK, MSELBCR_MSEL17_0,
+	PINMUX_DATA(PORT69_KEYIN3_PU_MARK, MSELBCR_MSEL17_0, MSELBCR_MSEL16_0,
 				PORT69_FN2, PORT69_IN_PU),
-	PINMUX_DATA(PORT70_KEYIN4_PU_MARK, MSELBCR_MSEL17_0,
+	PINMUX_DATA(PORT70_KEYIN4_PU_MARK, MSELBCR_MSEL17_0, MSELBCR_MSEL16_0,
 				PORT70_FN2, PORT70_IN_PU),
-	PINMUX_DATA(PORT71_KEYIN5_PU_MARK, MSELBCR_MSEL17_0,
+	PINMUX_DATA(PORT71_KEYIN5_PU_MARK, MSELBCR_MSEL17_0, MSELBCR_MSEL16_0,
 				PORT71_FN2, PORT71_IN_PU),
-	PINMUX_DATA(PORT72_KEYIN6_PU_MARK, MSELBCR_MSEL17_0,
+	PINMUX_DATA(PORT72_KEYIN6_PU_MARK, MSELBCR_MSEL17_0, MSELBCR_MSEL16_0,
 				PORT72_FN2, PORT72_IN_PU),
 
 
@@ -1637,7 +1638,7 @@ static struct pinmux_cfg_reg pinmux_config_regs[] = {
 			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 			MSELBCR_MSEL17_0, MSELBCR_MSEL17_1,
-			0, 0,
+			MSELBCR_MSEL16_0, MSELBCR_MSEL16_1,
 			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
 			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
 	},
-- 
1.6.3.3

