From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Apr 2013 05:17:04 +0000
Subject: [PATCH 2/6] ARM: shmobile: r8a7778: add SDHI clock support
Message-Id: <87d2ttenxv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7778.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 5cc271e..b251e4d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -103,12 +103,16 @@ static struct clk *main_clks[] = {
 };
 
 enum {
+	MSTP323, MSTP322, MSTP321,
 	MSTP114,
 	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP323] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 23, 0), /* SDHI0 */
+	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
+	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP114] = SH_CLK_MSTP32(&p_clk, MSTPCR1, 14, 0), /* Ether */
 	[MSTP026] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 26, 0), /* SCIF0 */
 	[MSTP025] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 25, 0), /* SCIF1 */
@@ -122,6 +126,9 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
-- 
1.7.9.5

