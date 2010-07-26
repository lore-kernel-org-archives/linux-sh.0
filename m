From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 26 Jul 2010 16:20:53 +0000
Subject: [PATCH 2/5] ARM: mash-shmobile: add clock definitions for CEU and
Message-Id: <Pine.LNX.4.64.1007261749210.9816@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1007261739180.9816@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1007261739180.9816@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Two more clocks to be managed by the runtime PM.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index b801efb..9b87985 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -395,7 +395,7 @@ static struct clk div6_reparent_clks[DIV6_REPARENT_NR] = {
 
 enum { MSTP001,
        MSTP131, MSTP130,
-       MSTP129, MSTP128,
+       MSTP129, MSTP128, MSTP127, MSTP126,
        MSTP118, MSTP117, MSTP116,
        MSTP106, MSTP101, MSTP100,
        MSTP223,
@@ -413,6 +413,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP130] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 30, 0), /* VEU2 */
 	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* VEU1 */
 	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* VEU0 */
+	[MSTP127] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 27, 0), /* CEU */
+	[MSTP126] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 26, 0), /* CSI2 */
 	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX */
 	[MSTP117] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 16, 0), /* IIC0 */
@@ -498,6 +500,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("uio_pdrv_genirq.3", &mstp_clks[MSTP130]), /* VEU2 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.2", &mstp_clks[MSTP129]), /* VEU1 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.1", &mstp_clks[MSTP128]), /* VEU0 */
+	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[MSTP127]), /* CEU */
+	CLKDEV_DEV_ID("sh-mobile-csi2.0", &mstp_clks[MSTP126]), /* CSI2 */
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1", &mstp_clks[MSTP117]), /* LCDC1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
-- 
1.6.2.4

