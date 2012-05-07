From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 07 May 2012 05:58:41 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-r8a7740: add sh-eth clock
Message-Id: <87wr4o1qib.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201204252313.23899.rjw@sisk.pl>
In-Reply-To: <201204252313.23899.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

armadillo800eva board is using sh-eth, but clock-r8a7740 didn't care it.
This clock was enabled by boot-loader.
This patch fix it up.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    1 +
 arch/arm/mach-shmobile/clock-r8a7740.c         |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 0cfaec5..e750ea6 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -321,6 +321,7 @@ static struct resource sh_eth_resources[] = {
 
 static struct platform_device sh_eth_device = {
 	.name = "sh-eth",
+	.id = -1,
 	.dev = {
 		.platform_data = &sh_eth_platdata,
 	},
diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 81b54a6..26eea5f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -352,6 +352,7 @@ enum {
 
 	MSTP329, MSTP328, MSTP323, MSTP320,
 	MSTP314, MSTP313, MSTP312,
+	MSTP309,
 
 	MSTP416, MSTP415, MSTP407, MSTP406,
 
@@ -382,6 +383,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 13, 0), /* SDHI1 */
 	[MSTP312] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 12, 0), /* MMC */
+	[MSTP309] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3,  9, 0), /* GEther */
 
 	[MSTP416] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 16, 0), /* USBHOST */
 	[MSTP415] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 15, 0), /* SDHI2 */
@@ -447,6 +449,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1",	&mstp_clks[MSTP313]),
 	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
+	CLKDEV_DEV_ID("sh-eth",			&mstp_clks[MSTP309]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 
-- 
1.7.5.4

