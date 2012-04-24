From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Apr 2012 09:08:11 +0000
Subject: [PATCH 2/8] ARM: mach-shmobile: clock-r8a7740: add SDHI clock
Message-Id: <878vhlfqfc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7740.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index 30535f4..5c6b548 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -356,8 +356,9 @@ enum {
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
 
 	MSTP329, MSTP323, MSTP320,
+	MSTP314, MSTP313,
 
-	MSTP416, MSTP407, MSTP406,
+	MSTP416, MSTP415, MSTP407, MSTP406,
 
 	MSTP_NR
 };
@@ -382,8 +383,11 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP329] = SH_CLK_MSTP32(&r_clk,		SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP323] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 20, 0), /* USBF */
+	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 14, 0), /* SDHI0 */
+	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR3, 13, 0), /* SDHI1 */
 
 	[MSTP416] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 16, 0), /* USBHOST */
+	[MSTP415] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4, 15, 0), /* SDHI2 */
 	[MSTP407] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4,  7, 0), /* USB-Func */
 	[MSTP406] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR4,  6, 0), /* USB Phy */
 };
@@ -442,6 +446,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.10",		&mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.1",	&mstp_clks[MSTP323]),
 	CLKDEV_DEV_ID("renesas_usbhs",		&mstp_clks[MSTP320]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0",	&mstp_clks[MSTP314]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1",	&mstp_clks[MSTP313]),
+
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2",	&mstp_clks[MSTP415]),
 
 	/* ICK */
 	CLKDEV_ICK_ID("host",	"renesas_usbhs",	&mstp_clks[MSTP416]),
-- 
1.7.5.4

