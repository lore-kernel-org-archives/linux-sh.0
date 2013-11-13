From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Nov 2013 13:01:42 +0000
Subject: [PATCH] ARM: shmobile: r8a7791: Add DU and LVDS clocks
Message-Id: <1384347702-18852-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The ZX parent clock isn't implemented yet, add it as well.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index c9ad3a3..c28f336 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -103,6 +103,7 @@ SH_FIXED_RATIO_CLK_SET(hp_clk,			pll1_clk,	1, 12);
 SH_FIXED_RATIO_CLK_SET(p_clk,			pll1_clk,	1, 24);
 SH_FIXED_RATIO_CLK_SET(rclk_clk,		pll1_clk,	1, (48 * 1024));
 SH_FIXED_RATIO_CLK_SET(mp_clk,			pll1_div2_clk,	1, 15);
+SH_FIXED_RATIO_CLK_SET(zx_clk,			pll1_clk,	1, 3);
 
 static struct clk *main_clks[] = {
 	&extal_clk,
@@ -116,12 +117,13 @@ static struct clk *main_clks[] = {
 	&rclk_clk,
 	&mp_clk,
 	&cp_clk,
+	&zx_clk,
 };
 
 /* MSTP */
 enum {
 	MSTP813,
-	MSTP721, MSTP720,
+	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
 	MSTP216, MSTP207, MSTP206,
 	MSTP204, MSTP203, MSTP202, MSTP1105, MSTP1106, MSTP1107,
@@ -131,6 +133,9 @@ enum {
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
+	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
+	[MSTP724] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 24, 0), /* DU0 */
+	[MSTP723] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 23, 0), /* DU1 */
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
 	[MSTP719] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 19, 0), /* SCIF2 */
@@ -166,6 +171,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk", &hp_clk),
 
 	/* MSTP */
+	CLKDEV_ICK_ID("lvds.0", "rcar-du-r8a7791", &mstp_clks[MSTP726]),
+	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7791", &mstp_clks[MSTP724]),
+	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7791", &mstp_clks[MSTP723]),
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]), /* SCIFB0 */
-- 
Regards,

Laurent Pinchart

