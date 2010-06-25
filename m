From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 Jun 2010 07:21:40 +0000
Subject: [PATCH] ARM: sh-mobile: fix typos in sh7372 clock definitions
Message-Id: <Pine.LNX.4.64.1006250920300.1223@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Reported-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 241caea..82d3535 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -259,8 +259,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP130] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 30, 0), /* VEU2 */
 	[MSTP129] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 29, 0), /* VEU1 */
 	[MSTP128] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 28, 0), /* VEU0 */
-	[MSTP118] = MSTP(&div6_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX */
-	[MSTP117] = MSTP(&div6_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
+	[MSTP118] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 18, 0), /* DSITX */
+	[MSTP117] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 17, 0), /* LCDC1 */
 	[MSTP116] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR1, 16, 0), /* IIC0 */
 	[MSTP106] = MSTP(&div4_clks[DIV4_B], SMSTPCR1, 6, 0), /* JPU */
 	[MSTP101] = MSTP(&div4_clks[DIV4_M1], SMSTPCR1, 1, 0), /* VPU */
-- 
1.6.2.4

