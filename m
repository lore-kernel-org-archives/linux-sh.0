From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 04 Jun 2013 05:11:39 +0000
Subject: [PATCH 3/6 v4] ARM: shmobile: r8a7778: add support MMC clock
Message-Id: <8761xu5uk7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds r8a7778 MMC clock support.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v3 -> v4

 - separated into "clock" support

 arch/arm/mach-shmobile/clock-r8a7778.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index c2c1895..18d44f5 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -103,6 +103,7 @@ static struct clk *main_clks[] = {
 };
 
 enum {
+	MSTP331,
 	MSTP323, MSTP322, MSTP321,
 	MSTP114,
 	MSTP030,
@@ -112,6 +113,7 @@ enum {
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP331] = SH_CLK_MSTP32(&s4_clk, MSTPCR3, 31, 0), /* MMC */
 	[MSTP323] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 23, 0), /* SDHI0 */
 	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
@@ -137,6 +139,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk",	&p_clk),
 
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh_mmcif", &mstp_clks[MSTP331]), /* MMC */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
-- 
1.7.9.5

