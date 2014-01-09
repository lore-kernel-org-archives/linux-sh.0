From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 09 Jan 2014 15:23:21 +0000
Subject: [PATCH V2 2/4] ARM: shmobile: r8a7791: Add SATA clocks
Message-Id: <1389281003-10253-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA[01] clock support to R8A7791 SoC.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
Changes in V2:
 * used zs_clk as SATA clock parent, according to the feedback from Renesas.

 arch/arm/mach-shmobile/clock-r8a7791.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 52d7d13..e4e4dfa 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -135,6 +135,7 @@ static struct clk *main_clks[] = {
 /* MSTP */
 enum {
 	MSTP931, MSTP930, MSTP929, MSTP928, MSTP927, MSTP925,
+	MSTP815, MSTP814,
 	MSTP813,
 	MSTP811, MSTP810, MSTP809,
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
@@ -153,6 +154,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
 	[MSTP927] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 27, MSTPSR9, 0), /* I2C4 */
 	[MSTP925] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 25, MSTPSR9, 0), /* I2C5 */
+	[MSTP815] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 15, MSTPSR8, 0), /* SATA0 */
+	[MSTP814] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 14, MSTPSR8, 0), /* SATA1 */
 	[MSTP813] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR8, 13, MSTPSR8, 0), /* Ether */
 	[MSTP811] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 11, MSTPSR8, 0), /* VIN0 */
 	[MSTP810] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 10, MSTPSR8, 0), /* VIN1 */
@@ -229,6 +232,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a7791-vin.0", &mstp_clks[MSTP811]),
 	CLKDEV_DEV_ID("r8a7791-vin.1", &mstp_clks[MSTP810]),
 	CLKDEV_DEV_ID("r8a7791-vin.2", &mstp_clks[MSTP809]),
+	CLKDEV_DEV_ID("sata-r8a7791.0", &mstp_clks[MSTP815]),
+	CLKDEV_DEV_ID("sata-r8a7791.1", &mstp_clks[MSTP814]),
 };
 
 #define R8A7791_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.8.3.1

