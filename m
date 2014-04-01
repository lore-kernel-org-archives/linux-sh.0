From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 01 Apr 2014 11:02:16 +0000
Subject: [PATCH 2/4] ARM: shmobile: r8a7791: Fix the I2C clocks parents in legacy code
Message-Id: <1396350138-26850-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All I2C clocks derive from the HP clock, not from the P clock. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index fc90f97..d2cb5cf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -188,12 +188,12 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP1108] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR11, 8, MSTPSR11, 0), /* SCIFA5 */
 	[MSTP1107] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR11, 7, MSTPSR11, 0), /* SCIFA4 */
 	[MSTP1106] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR11, 6, MSTPSR11, 0), /* SCIFA3 */
-	[MSTP931] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 31, MSTPSR9, 0), /* I2C0 */
-	[MSTP930] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 30, MSTPSR9, 0), /* I2C1 */
-	[MSTP929] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
-	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
-	[MSTP927] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 27, MSTPSR9, 0), /* I2C4 */
-	[MSTP925] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 25, MSTPSR9, 0), /* I2C5 */
+	[MSTP931] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 31, MSTPSR9, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 30, MSTPSR9, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
+	[MSTP927] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 27, MSTPSR9, 0), /* I2C4 */
+	[MSTP925] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 25, MSTPSR9, 0), /* I2C5 */
 	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
 	[MSTP815] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 15, MSTPSR8, 0), /* SATA0 */
 	[MSTP814] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 14, MSTPSR8, 0), /* SATA1 */
-- 
1.8.3.2

