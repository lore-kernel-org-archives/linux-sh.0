From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Aug 2011 02:44:02 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh7372: fixup USB-DMAC1 settings
Message-Id: <87fwkrh6kx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

USB-DMAC1 needs SMSTPCR4/MSTP407 controls, not MSTP214

Reported-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
Paul

It is based on paul/rmobile/dma branch

 arch/arm/mach-shmobile/clock-sh7372.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index c239ab1..3f8de2c 100644
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
+	[MSTP407] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 7, 0), /* USBDMAC */
 	[MSTP406] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR4, 6, 0), /* USB1 */
 	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 3, 0), /* KEYSC */
 };
@@ -635,7 +636,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* DMAC2 */
 	CLKDEV_DEV_ID("sh-dma-engine.2", &mstp_clks[MSTP216]), /* DMAC3 */
 	CLKDEV_DEV_ID("sh-dma-engine.3", &mstp_clks[MSTP214]), /* USB-DMAC0 */
-	CLKDEV_DEV_ID("sh-dma-engine.4", &mstp_clks[MSTP214]), /* USB-DMAC1 */
+	CLKDEV_DEV_ID("sh-dma-engine.4", &mstp_clks[MSTP407]), /* USB-DMAC1 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP206]), /* SCIFB */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
-- 
1.7.4.1

