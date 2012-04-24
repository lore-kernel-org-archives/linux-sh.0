From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Apr 2012 09:08:29 +0000
Subject: [PATCH 3/8] ARM: mach-shmobile: clock-r8a7740: add MMCIF clock
Message-Id: <877gx5fqeu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 5c6b548..927d42a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -356,7 +356,7 @@ enum {
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 
 	MSTP329, MSTP323, MSTP320,
-	MSTP314, MSTP313,
+	MSTP314, MSTP313, MSTP312,
 
 	MSTP416, MSTP415, MSTP407, MSTP406,
 
@@ -385,6 +385,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 20, 0), /* USBF */
 	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 13, 0), /* SDHI1 */
+	[MSTP312] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 12, 0), /* MMC */
 
 	[MSTP416] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 16, 0), /* USBHOST */
 	[MSTP415] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 15, 0), /* SDHI2 */
@@ -448,6 +449,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1",	&mstp_clks[MSTP313]),
+	CLKDEV_DEV_ID("sh_mmcif",		&mstp_clks[MSTP312]),
 
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 
-- 
1.7.5.4

