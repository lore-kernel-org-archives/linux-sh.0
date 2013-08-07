From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 07 Aug 2013 04:06:46 +0000
Subject: [PATCH 2/5] ARM: shmobile: r8a7778: add SSI/SRU clock support
Message-Id: <871u66jga4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a platform clock for the r8a7778 SRU/SSI sound.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7778.c |   43 ++++++++++++++++++++++++++++++--
 1 file changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index a0e9eb7..2a9f561 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -69,6 +69,15 @@ static struct clk extal_clk = {
 	.mapping = &cpg_mapping,
 };
 
+static struct clk audio_clk_a = {
+};
+
+static struct clk audio_clk_b = {
+};
+
+static struct clk audio_clk_c = {
+};
+
 /*
  * clock ratio of these clock will be updated
  * on r8a7778_clock_init()
@@ -100,17 +109,22 @@ static struct clk *main_clks[] = {
 	&p_clk,
 	&g_clk,
 	&z_clk,
+	&audio_clk_a,
+	&audio_clk_b,
+	&audio_clk_c,
 };
 
 enum {
 	MSTP331,
 	MSTP323, MSTP322, MSTP321,
+	MSTP311, MSTP310,
+	MSTP309, MSTP308, MSTP307,
 	MSTP114,
 	MSTP100,
 	MSTP030,
 	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
-	MSTP016, MSTP015,
-	MSTP007,
+	MSTP016, MSTP015, MSTP012, MSTP011, MSTP010,
+	MSTP009, MSTP008, MSTP007,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
@@ -118,6 +132,11 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP323] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 23, 0), /* SDHI0 */
 	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
+	[MSTP311] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 11, 0), /* SSI4 */
+	[MSTP310] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 10, 0), /* SSI5 */
+	[MSTP309] = SH_CLK_MSTP32(&p_clk, MSTPCR3,  9, 0), /* SSI6 */
+	[MSTP308] = SH_CLK_MSTP32(&p_clk, MSTPCR3,  8, 0), /* SSI7 */
+	[MSTP307] = SH_CLK_MSTP32(&p_clk, MSTPCR3,  7, 0), /* SSI8 */
 	[MSTP114] = SH_CLK_MSTP32(&p_clk, MSTPCR1, 14, 0), /* Ether */
 	[MSTP100] = SH_CLK_MSTP32(&p_clk, MSTPCR1,  0, 0), /* USB0/1 */
 	[MSTP030] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 30, 0), /* I2C0 */
@@ -132,11 +151,20 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP021] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 21, 0), /* SCIF5 */
 	[MSTP016] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 16, 0), /* TMU0 */
 	[MSTP015] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 15, 0), /* TMU1 */
+	[MSTP012] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 12, 0), /* SSI0 */
+	[MSTP011] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 11, 0), /* SSI1 */
+	[MSTP010] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 10, 0), /* SSI2 */
+	[MSTP009] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  9, 0), /* SSI3 */
+	[MSTP008] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  8, 0), /* SRU */
 	[MSTP007] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  7, 0), /* HSPI */
 };
 
 static struct clk_lookup lookups[] = {
 	/* main */
+	CLKDEV_CON_ID("audio_clk_a",	&audio_clk_a),
+	CLKDEV_CON_ID("audio_clk_b",	&audio_clk_b),
+	CLKDEV_CON_ID("audio_clk_c",	&audio_clk_c),
+	CLKDEV_CON_ID("audio_clk_internal",	&s1_clk),
 	CLKDEV_CON_ID("shyway_clk",	&s_clk),
 	CLKDEV_CON_ID("peripheral_clk",	&p_clk),
 
@@ -163,6 +191,17 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
 	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
 	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
+	CLKDEV_DEV_ID("rcar_sound", &mstp_clks[MSTP008]), /* SRU */
+
+	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP012]),
+	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP011]),
+	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP010]),
+	CLKDEV_ICK_ID("ssi.3", "rcar_sound", &mstp_clks[MSTP009]),
+	CLKDEV_ICK_ID("ssi.4", "rcar_sound", &mstp_clks[MSTP311]),
+	CLKDEV_ICK_ID("ssi.5", "rcar_sound", &mstp_clks[MSTP310]),
+	CLKDEV_ICK_ID("ssi.6", "rcar_sound", &mstp_clks[MSTP309]),
+	CLKDEV_ICK_ID("ssi.7", "rcar_sound", &mstp_clks[MSTP308]),
+	CLKDEV_ICK_ID("ssi.8", "rcar_sound", &mstp_clks[MSTP307]),
 };
 
 void __init r8a7778_clock_init(void)
-- 
1.7.9.5

