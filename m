From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Wed, 18 May 2011 11:10:06 +0000
Subject: [PATCH 1/6] sh_mobile: Add MSTP clock for MERAM
Message-Id: <1305717011-20742-2-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 6c79b40..fbca92c 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -501,7 +501,7 @@ static struct clk *late_main_clks[] = {
 enum { MSTP001,
        MSTP131, MSTP130,
        MSTP129, MSTP128, MSTP127, MSTP126, MSTP125,
-       MSTP118, MSTP117, MSTP116,
+       MSTP118, MSTP117, MSTP116, MSTP113,
        MSTP106, MSTP101, MSTP100,
        MSTP223,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
@@ -524,6 +524,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX */
 	[MSTP117] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 16, 0), /* IIC0 */
+	[MSTP113] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 13, 0), /* MERAM */
 	[MSTP106] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 6, 0), /* JPU */
 	[MSTP101] = MSTP(&div4_clks[DIV4_M1], SMSTPCR1, 1, 0), /* VPU */
 	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
@@ -614,6 +615,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-mipi-dsi.0", &mstp_clks[MSTP118]), /* DSITX0 */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.1", &mstp_clks[MSTP117]), /* LCDC1 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
+	CLKDEV_DEV_ID("sh_mobile_meram.0", &mstp_clks[MSTP113]), /* MERAM */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.5", &mstp_clks[MSTP106]), /* JPU */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP101]), /* VPU */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
-- 
1.7.1

