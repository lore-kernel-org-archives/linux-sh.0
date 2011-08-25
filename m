From: kuninori.morimoto.gx@renesas.com
Date: Thu, 25 Aug 2011 03:47:42 +0000
Subject: [PATCH v2] ARM: mach-shmobile: clock-sh7372: fixup USB-DMAC1 settings
Message-Id: <874o16up7v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB-DMAC1 needs SMSTPCR4/MSTP407 controls, not MSTP214
this patch tested on mackerel board

Reported-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- tested on mackerel board
- fix comment
- fix MSTPxxx order

 arch/arm/mach-shmobile/clock-sh7372.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index d407ca7..725caf1 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -512,7 +512,7 @@ enum { MSTP001,
        MSTP214, MSTP218, MSTP217, MSTP216,
        MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
        MSTP329, MSTP328, MSTP323, MSTP322, MSTP314, MSTP313, MSTP312,
-       MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP406, MSTP403,
+       MSTP423, MSTP415, MSTP413, MSTP411, MSTP410, MSTP407, MSTP406, MSTP403,
        MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -558,6 +558,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP413] = MSTP(&pllc1_div2_clk, SMSTPCR4, 13, 0), /* HDMI */
 	[MSTP411] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 11, 0), /* IIC3 */
 	[MSTP410] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 10, 0), /* IIC4 */
+	[MSTP407] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 7, 0), /* USB-DMAC1 */
 	[MSTP406] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 6, 0), /* USB1 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
 };
@@ -631,7 +632,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* DMAC2 */
 	CLKDEV_DEV_ID("sh-dma-engine.2", &mstp_clks[MSTP216]), /* DMAC3 */
 	CLKDEV_DEV_ID("sh-dma-engine.3", &mstp_clks[MSTP214]), /* USB-DMAC0 */
-	CLKDEV_DEV_ID("sh-dma-engine.4", &mstp_clks[MSTP214]), /* USB-DMAC1 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP206]), /* SCIFB */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
@@ -653,6 +653,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-mobile-hdmi", &mstp_clks[MSTP413]), /* HDMI */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* IIC3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* IIC4 */
+	CLKDEV_DEV_ID("sh-dma-engine.4", &mstp_clks[MSTP407]), /* USB-DMAC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[MSTP406]), /* USB1 */
-- 
1.7.4.1

