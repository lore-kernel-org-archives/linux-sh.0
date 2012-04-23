From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 23 Apr 2012 07:03:10 +0000
Subject: [PATCH 1/2] ARM: mach-shmobile: clock-sh73a0: add FSI clock
Message-Id: <87zka37wwl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pzkuyihfm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 472d1f5..77a86dd 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -477,7 +477,7 @@ enum { MSTP001,
 	MSTP129, MSTP128, MSTP127, MSTP126, MSTP125, MSTP118, MSTP116, MSTP100,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-	MSTP331, MSTP329, MSTP325, MSTP323, MSTP318,
+	MSTP331, MSTP329, MSTP328, MSTP325, MSTP323, MSTP318,
 	MSTP314, MSTP313, MSTP312, MSTP311,
 	MSTP303, MSTP302, MSTP301, MSTP300,
 	MSTP411, MSTP410, MSTP403,
@@ -506,6 +506,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
 	[MSTP331] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 31, 0), /* SCIFA6 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
+	[MSTP328] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 28, 0), /*FSI*/
 	[MSTP325] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 25, 0), /* IrDA */
 	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP318] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 18, 0), /* SY-DMAC */
@@ -561,6 +562,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI */
 	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP318]), /* SY-DMAC */
-- 
1.7.5.4

