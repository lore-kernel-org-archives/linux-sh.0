From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 19 Dec 2013 17:59:04 +0000
Subject: [PATCH 1/2] arm: shmobile: r8a7791: Add SATA clocks
Message-Id: <1387475945-25995-2-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201310310218.37578.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201310310218.37578.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA 0/1 clock support. External 100MHz SATA 0/1
reference clock is supposed to be applied to the following pins:
  CICREFP0_SATA/CICREFP1_SATA;
  CICREFN0_SATA/CICREFN1_SATA.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index f546126..01a0314 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -78,6 +78,18 @@ static struct clk extal_clk = {
 	.mapping	= &cpg_mapping,
 };
 
+/* External SATA0 reference clock: 100MHz fixed */
+static struct clk sata0_clk = {
+	.rate		= 100000000,
+	.mapping	= &cpg_mapping,
+};
+
+/* External SATA1 reference clock: 100MHz fixed */
+static struct clk sata1_clk = {
+	.rate		= 100000000,
+	.mapping	= &cpg_mapping,
+};
+
 static struct sh_clk_ops followparent_clk_ops = {
 	.recalc	= followparent_recalc,
 };
@@ -118,10 +130,13 @@ static struct clk *main_clks[] = {
 	&mp_clk,
 	&cp_clk,
 	&zx_clk,
+	&sata0_clk,
+	&sata1_clk,
 };
 
 /* MSTP */
 enum {
+	MSTP815, MSTP814,
 	MSTP813,
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
@@ -133,6 +148,8 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP815] = SH_CLK_MSTP32(&sata0_clk, SMSTPCR8, 15, 0), /* SATA0 */
+	[MSTP814] = SH_CLK_MSTP32(&sata1_clk, SMSTPCR8, 14, 0),	/* SATA1 */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP724] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 24, 0), /* DU0 */
@@ -195,6 +212,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("r8a7791-ether", &mstp_clks[MSTP813]), /* Ether */
+	CLKDEV_DEV_ID("sata-r8a7791.0", &mstp_clks[MSTP815]),
+	CLKDEV_DEV_ID("sata-r8a7791.1", &mstp_clks[MSTP814]),
 };
 
 #define R8A7791_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.8.3.1

