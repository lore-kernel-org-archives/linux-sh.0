From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Nov 2010 07:41:14 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh73a0: modify MSTP order
Message-Id: <w3pmxozyxra.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch permuted clock arrays in the order of MSTP

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh73a0.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 6e48aae..81fd429 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -51,10 +51,11 @@ static struct clk *main_clks[] = {
 	&hp_clk,
 };
 
-enum { MSTP219,
-	MSTP001, MSTP116, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
-	MSTP201, MSTP200, MSTP323, MSTP331, MSTP329, MSTP312, MSTP411,
-	MSTP410, MSTP403,
+enum {	MSTP001,
+	MSTP116,
+	MSTP219, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
+	MSTP331, MSTP329, MSTP323,
+	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
 #define MSTP(_parent, _reg, _bit, _flags) \
@@ -62,8 +63,8 @@ enum { MSTP219,
 
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP001] = MSTP(&hp_clk, SMSTPCR0, 1, 0), /* I2C2 */
-	[MSTP219] = MSTP(&sub_clk, SMSTPCR2, 19, 0), /* SCIFA7 */
 	[MSTP116] = MSTP(&hp_clk, SMSTPCR1, 16, 0), /* I2C0 */
+	[MSTP219] = MSTP(&sub_clk, SMSTPCR2, 19, 0), /* SCIFA7 */
 	[MSTP207] = MSTP(&sub_clk, SMSTPCR2, 7, 0), /* SCIFA5 */
 	[MSTP206] = MSTP(&sub_clk, SMSTPCR2, 6, 0), /* SCIFB */
 	[MSTP204] = MSTP(&sub_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
@@ -74,15 +75,17 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP331] = MSTP(&sub_clk, SMSTPCR3, 31, 0), /* SCIFA6 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
 	[MSTP323] = MSTP(&hp_clk, SMSTPCR3, 23, 0), /* I2C1 */
-	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 0, 0), /* KEYSC0 */
 	[MSTP411] = MSTP(&hp_clk, SMSTPCR4, 11, 0), /* I2C3 */
 	[MSTP410] = MSTP(&hp_clk, SMSTPCR4, 10, 0), /* I2C4 */
+	[MSTP403] = MSTP(&r_clk, SMSTPCR4, 0, 0), /* KEYSC0 */
 };
 
 #define CLKDEV_DEV_ID(_id, _clk) { .dev_id = _id, .clk = _clk }
 
 static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
@@ -93,12 +96,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
-	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC0 */
-	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
-	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* I2C2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* I2C4 */
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC0 */
 };
 
 void __init sh73a0_clock_init(void)
-- 
1.7.0.4

