From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Tue, 15 Jun 2010 01:15:41 +0000
Subject: [PATCH] Enable UIO block clocks at system initialization on SH7372
Message-Id: <1276564541-24990-1-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Temporary workaround to enable the clocks for the UIO blocks (VEU,
JPU, VPU, SPU) until the runtime PM is ready. In order to have UIO support
for these subsystems, the following patches (already available on the
linux-sh mailing list) should be applied:

SH-Mobile ARM UIO Multimedia Support
ARM: CONFG_FORCE_MAX_ZONEORDER update of SH-Mobile ARM

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 arch/arm/mach-shmobile/clock-sh7372.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 241caea..aae0875 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -255,17 +255,17 @@ enum { MSTP001,
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP001] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR0, 1, 0), /* IIC2 */
-	[MSTP131] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 31, 0), /* VEU3 */
-	[MSTP130] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 30, 0), /* VEU2 */
-	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* VEU1 */
-	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* VEU0 */
+	[MSTP131] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 31, CLK_ENABLE_ON_INIT), /* VEU3 */
+	[MSTP130] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 30, CLK_ENABLE_ON_INIT), /* VEU2 */
+	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, CLK_ENABLE_ON_INIT), /* VEU1 */
+	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, CLK_ENABLE_ON_INIT), /* VEU0 */
 	[MSTP118] = MSTP(&div6_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX */
 	[MSTP117] = MSTP(&div6_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 16, 0), /* IIC0 */
-	[MSTP106] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 6, 0), /* JPU */
-	[MSTP101] = MSTP(&div4_clks[DIV4_M1], SMSTPCR1, 1, 0), /* VPU */
+	[MSTP106] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 6, CLK_ENABLE_ON_INIT), /* JPU */
+	[MSTP101] = MSTP(&div4_clks[DIV4_M1], SMSTPCR1, 1, CLK_ENABLE_ON_INIT), /* VPU */
 	[MSTP100] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 0, 0), /* LCDC0 */
-	[MSTP223] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR2, 23, 0), /* SPU2 */
+	[MSTP223] = MSTP(&div6_clks[DIV6_SPU], SMSTPCR2, 23, CLK_ENABLE_ON_INIT), /* SPU2 */
 	[MSTP207] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 6, 0), /* SCIFB */
 	[MSTP204] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 4, 0), /* SCIFA0 */
-- 
1.6.1

