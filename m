From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Dec 2013 02:17:18 +0000
Subject: [PATCH 4/4 v2] ARM: shmobile: r8a7790: add SSI MSTP clocks
Message-Id: <87fvqcc7ys.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4ignqie.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4ignqie.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - MSTP part only

 arch/arm/mach-shmobile/clock-r8a7790.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 7960dc0..312376d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -53,6 +53,7 @@
 #define SMSTPCR7 0xe615014c
 #define SMSTPCR8 0xe6150990
 #define SMSTPCR9 0xe6150994
+#define SMSTPCR10 0xe6150998
 
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
@@ -182,6 +183,8 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP1015, MSTP1014, MSTP1013, MSTP1012, MSTP1011, MSTP1010,
+	MSTP1009, MSTP1008, MSTP1007, MSTP1006, MSTP1005,
 	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP917,
 	MSTP813,
@@ -196,6 +199,17 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP1015] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 15, 0), /* SSI0 */
+	[MSTP1014] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 14, 0), /* SSI1 */
+	[MSTP1013] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 13, 0), /* SSI2 */
+	[MSTP1012] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 12, 0), /* SSI3 */
+	[MSTP1011] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 11, 0), /* SSI4 */
+	[MSTP1010] = SH_CLK_MSTP32(&p_clk, SMSTPCR10, 10, 0), /* SSI5 */
+	[MSTP1009] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  9, 0), /* SSI6 */
+	[MSTP1008] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  8, 0), /* SSI7 */
+	[MSTP1007] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  7, 0), /* SSI8 */
+	[MSTP1006] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  6, 0), /* SSI9 */
+	[MSTP1005] = SH_CLK_MSTP32(&p_clk, SMSTPCR10,  5, 0), /* SSI ALL */
 	[MSTP931] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 31, 0), /* I2C0 */
 	[MSTP930] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 30, 0), /* I2C1 */
 	[MSTP929] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 29, 0), /* I2C2 */
@@ -266,6 +280,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("ssprs",		&div6_clks[DIV6_SSPRS]),
 
 	/* MSTP */
+	CLKDEV_DEV_ID("rcar_sound", &mstp_clks[MSTP1005]),
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]),
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]),
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP206]),
@@ -306,6 +321,16 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("du.0", "rcar-du-r8a7790", &mstp_clks[MSTP724]),
 	CLKDEV_ICK_ID("du.1", "rcar-du-r8a7790", &mstp_clks[MSTP723]),
 	CLKDEV_ICK_ID("du.2", "rcar-du-r8a7790", &mstp_clks[MSTP722]),
+	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP1015]),
+	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP1014]),
+	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP1013]),
+	CLKDEV_ICK_ID("ssi.3", "rcar_sound", &mstp_clks[MSTP1012]),
+	CLKDEV_ICK_ID("ssi.4", "rcar_sound", &mstp_clks[MSTP1011]),
+	CLKDEV_ICK_ID("ssi.5", "rcar_sound", &mstp_clks[MSTP1010]),
+	CLKDEV_ICK_ID("ssi.6", "rcar_sound", &mstp_clks[MSTP1009]),
+	CLKDEV_ICK_ID("ssi.7", "rcar_sound", &mstp_clks[MSTP1008]),
+	CLKDEV_ICK_ID("ssi.8", "rcar_sound", &mstp_clks[MSTP1007]),
+	CLKDEV_ICK_ID("ssi.9", "rcar_sound", &mstp_clks[MSTP1006]),
 
 };
 
-- 
1.7.9.5

