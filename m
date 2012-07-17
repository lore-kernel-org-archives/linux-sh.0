From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 17 Jul 2012 11:53:58 +0000
Subject: [PATCH 1/2] r8a7779: add SDHI clock support
Message-Id: <1342526039-11128-2-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 339c62c..8b35165 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -86,11 +86,14 @@ static struct clk div4_clks[DIV4_NR] = {
 				      0x0300, CLK_ENABLE_ON_INIT),
 };
 
-enum { MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
-	MSTP016, MSTP015, MSTP014,
-	MSTP_NR };
+enum { MSTP323, MSTP322, MSTP321, MSTP320, MSTP026, MSTP025, MSTP024, MSTP023,
+	MSTP022, MSTP021, MSTP016, MSTP015, MSTP014, MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP323] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 23, 0), /* SDHI0 */
+	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
+	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
+	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
 	[MSTP026] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 26, 0), /* SCIF0 */
 	[MSTP025] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 25, 0), /* SCIF1 */
 	[MSTP024] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 24, 0), /* SCIF2 */
@@ -141,6 +144,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
 
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
-- 
1.7.5.4

