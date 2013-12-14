From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 14 Dec 2013 15:23:52 +0000
Subject: [PATCH v4 2/3] ARM: shmobile: r8a7779: Wait for status on selected MSTP clocks
Message-Id: <1387034633-3798-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

When enabling some of the module clocks by clearing stop bits in the
MSTP control registers, the CPG requires waiting for the status
registers to signal that the clocks have started. Failure to do so will
result in returning from the clk_enable() call with the clock
potentially still disabled, leading to various race conditions and
difficult to debug errors.

Enable status wait for all the r8a7779 MSTP clocks that report their
status.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index f1fb89b..93a5625 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -127,16 +127,16 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP320] = SH_CLK_MSTP32(&clkp_clk, MSTPCR3, 20, 0), /* SDHI3 */
-	[MSTP120] = SH_CLK_MSTP32(&clks_clk, MSTPCR1, 20, 0), /* VIN3 */
-	[MSTP116] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 16, 0), /* PCIe */
-	[MSTP115] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 15, 0), /* SATA */
-	[MSTP114] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1, 14, 0), /* Ether */
-	[MSTP110] = SH_CLK_MSTP32(&clks_clk, MSTPCR1, 10, 0), /* VIN0 */
-	[MSTP109] = SH_CLK_MSTP32(&clks_clk, MSTPCR1,  9, 0), /* VIN1 */
-	[MSTP108] = SH_CLK_MSTP32(&clks_clk, MSTPCR1,  8, 0), /* VIN2 */
-	[MSTP103] = SH_CLK_MSTP32(&clks_clk, MSTPCR1,  3, 0), /* DU */
-	[MSTP101] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1,  1, 0), /* USB2 */
-	[MSTP100] = SH_CLK_MSTP32(&clkp_clk, MSTPCR1,  0, 0), /* USB0/1 */
+	[MSTP120] = SH_CLK_MSTP32_STS(&clks_clk, MSTPCR1, 20, MSTPSR1, 0), /* VIN3 */
+	[MSTP116] = SH_CLK_MSTP32_STS(&clkp_clk, MSTPCR1, 16, MSTPSR1, 0), /* PCIe */
+	[MSTP115] = SH_CLK_MSTP32_STS(&clkp_clk, MSTPCR1, 15, MSTPSR1, 0), /* SATA */
+	[MSTP114] = SH_CLK_MSTP32_STS(&clkp_clk, MSTPCR1, 14, MSTPSR1, 0), /* Ether */
+	[MSTP110] = SH_CLK_MSTP32_STS(&clks_clk, MSTPCR1, 10, MSTPSR1, 0), /* VIN0 */
+	[MSTP109] = SH_CLK_MSTP32_STS(&clks_clk, MSTPCR1,  9, MSTPSR1, 0), /* VIN1 */
+	[MSTP108] = SH_CLK_MSTP32_STS(&clks_clk, MSTPCR1,  8, MSTPSR1, 0), /* VIN2 */
+	[MSTP103] = SH_CLK_MSTP32_STS(&clks_clk, MSTPCR1,  3, MSTPSR1, 0), /* DU */
+	[MSTP101] = SH_CLK_MSTP32_STS(&clkp_clk, MSTPCR1,  1, MSTPSR1, 0), /* USB2 */
+	[MSTP100] = SH_CLK_MSTP32_STS(&clkp_clk, MSTPCR1,  0, MSTPSR1, 0), /* USB0/1 */
 	[MSTP030] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 30, 0), /* I2C0 */
 	[MSTP029] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 29, 0), /* I2C1 */
 	[MSTP028] = SH_CLK_MSTP32(&clkp_clk, MSTPCR0, 28, 0), /* I2C2 */
-- 
1.8.3.2

