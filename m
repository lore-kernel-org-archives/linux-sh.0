From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 06 Jan 2014 08:32:46 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: add Audio DMAC clock
Message-Id: <87zjn9ik7o.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Audio DMAC can be controlled via sh-dma-engine

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 9dd5499b4..4f23247 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -204,6 +204,7 @@ enum {
 	MSTP717, MSTP716,
 	MSTP704,
 	MSTP522,
+	MSTP502, MSTP501,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
 	MSTP124,
@@ -239,6 +240,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
 	[MSTP704] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 4, 0), /* HSUSB */
 	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
+	[MSTP502] = SH_CLK_MSTP32(&zs_clk, SMSTPCR5, 2, 0), /* Audio-DMAC low */
+	[MSTP501] = SH_CLK_MSTP32(&zs_clk, SMSTPCR5, 1, 0), /* Audio-DMAC hi */
 	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, 0), /* MMC0 */
 	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_SD0], SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_SD1], SMSTPCR3, 13, 0), /* SDHI1 */
@@ -318,6 +321,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP502]),
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP501]),
 	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]),
-- 
1.7.9.5

