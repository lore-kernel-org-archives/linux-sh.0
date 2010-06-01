From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 01 Jun 2010 02:40:32 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh7372: Add MMCIF clock
Message-Id: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 1364072..241caea 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -246,7 +246,7 @@ enum { MSTP001,
        MSTP106, MSTP101, MSTP100,
        MSTP223,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-       MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313,
+       MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
        MSTP415, MSTP410, MSTP411, MSTP406, MSTP403,
        MSTP_NR };
 
@@ -279,6 +279,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 22, 0), /* USB0 */
 	[MSTP314] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 13, 0), /* SDHI1 */
+	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMC */
 	[MSTP415] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 15, 0), /* SDHI2 */
 	[MSTP411] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 10, 0), /* IIC4 */
@@ -363,6 +364,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP323]), /* USB0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMC */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP415]), /* SDHI2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* IIC3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* IIC4 */
-- 
1.7.0.4

