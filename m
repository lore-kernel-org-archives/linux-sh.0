From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 10 Sep 2013 11:39:54 +0000
Subject: [PATCH 3/3] ARM: shmobile: r8a7790: add the I2C bus clock
Message-Id: <1378813194-19493-4-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Nguyen Viet Dung <nv-dung@jinso.co.jp>

This patch adds the I2C bus clock.

Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index d99b87b..654d922 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -52,6 +52,7 @@
 #define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
 #define SMSTPCR8 0xe6150990
+#define SMSTPCR9 0xe6150994
 
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
@@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP813,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
 	MSTP717, MSTP716,
@@ -192,6 +194,10 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP931] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 31, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 30, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 29, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 28, 0), /* I2C3 */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP725] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 25, 0), /* LVDS1 */
@@ -247,6 +253,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("mp",		&mp_clk),
 	CLKDEV_CON_ID("qspi",		&qspi_clk),
 	CLKDEV_CON_ID("cp",		&cp_clk),
+	CLKDEV_CON_ID("peripheral_clk",	&hp_clk),
 
 	/* DIV4 */
 	CLKDEV_CON_ID("sdh",		&div4_clks[DIV4_SDH]),
@@ -286,6 +293,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
+	CLKDEV_DEV_ID("i2c-rcar_h2.0", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("i2c-rcar_h2.1", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("i2c-rcar_h2.2", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("i2c-rcar_h2.3", &mstp_clks[MSTP928]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.8.1.4

