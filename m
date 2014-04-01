From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 01 Apr 2014 11:02:15 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7790: Fix the I2C clocks parents in legacy code
Message-Id: <1396350138-26850-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All I2C clocks derive from the HP clock, not from the P clock. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 4ee1ae6..05f92d4 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -249,10 +249,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP1007] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 7, MSTPSR10, 0), /* SSI8 */
 	[MSTP1006] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 6, MSTPSR10, 0), /* SSI9 */
 	[MSTP1005] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 5, MSTPSR10, 0), /* SSI ALL */
-	[MSTP931] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 31, MSTPSR9, 0), /* I2C0 */
-	[MSTP930] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 30, MSTPSR9, 0), /* I2C1 */
-	[MSTP929] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
-	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
+	[MSTP931] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 31, MSTPSR9, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 30, MSTPSR9, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
 	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
 	[MSTP815] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 15, MSTPSR8, 0), /* SATA0 */
 	[MSTP814] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 14, MSTPSR8, 0), /* SATA1 */
-- 
1.8.3.2

