From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 18:15:38 +0000
Subject: [PATCH v3 2/5] ARM: shmobile: r8a7791: Add MSIOF clocks
Message-Id: <1397499341-11964-3-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Add clocks for MSIOF0, 1, and 2.
DEV_ID is 1-based for compatibility with the BSP, as QSPI uses zero.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
[geert] Updated for change from SH_CLK_MSTP32() to SH_CLK_MSTP32_STS()
[geert] Updated for new platform device name
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm@opensource.se>
---
v3:
  - Add Acked-by
v2:
  - No changes
---
 arch/arm/mach-shmobile/clock-r8a7791.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 3b26c7eee873..a6ae7f58ddc1 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -58,6 +58,7 @@
 #define SMSTPCR10	0xE6150998
 #define SMSTPCR11	0xE615099C
 
+#define MSTPSR0		IOMEM(0xe6150030)
 #define MSTPSR1		IOMEM(0xe6150038)
 #define MSTPSR2		IOMEM(0xe6150040)
 #define MSTPSR3		IOMEM(0xe6150048)
@@ -178,9 +179,10 @@ enum {
 	MSTP719, MSTP718, MSTP715, MSTP714,
 	MSTP522,
 	MSTP314, MSTP312, MSTP311,
-	MSTP216, MSTP207, MSTP206,
+	MSTP216, MSTP208, MSTP207, MSTP206, MSTP205,
 	MSTP204, MSTP203, MSTP202,
 	MSTP124,
+	MSTP000,
 	MSTP_NR
 };
 
@@ -215,12 +217,15 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP312] = SH_CLK_MSTP32_STS(&div6_clks[DIV6_SD1], SMSTPCR3, 12, MSTPSR3, 0), /* SDHI1 */
 	[MSTP311] = SH_CLK_MSTP32_STS(&div6_clks[DIV6_SD2], SMSTPCR3, 11, MSTPSR3, 0), /* SDHI2 */
 	[MSTP216] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 16, MSTPSR2, 0), /* SCIFB2 */
+	[MSTP208] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 8, MSTPSR2, 0), /* MSIOF1 */
 	[MSTP207] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 7, MSTPSR2, 0), /* SCIFB1 */
 	[MSTP206] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 6, MSTPSR2, 0), /* SCIFB0 */
+	[MSTP205] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 5, MSTPSR2, 0), /* MSIOF2 */
 	[MSTP204] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 4, MSTPSR2, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 3, MSTPSR2, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 2, MSTPSR2, 0), /* SCIFA2 */
 	[MSTP124] = SH_CLK_MSTP32_STS(&rclk_clk, SMSTPCR1, 24, MSTPSR1, 0), /* CMT0 */
+	[MSTP000] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR0, 0, MSTPSR0, 0), /* MSIOF0 */
 };
 
 static struct clk_lookup lookups[] = {
@@ -266,6 +271,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
+	CLKDEV_DEV_ID("spi_r8a7791_msiof.1", &mstp_clks[MSTP000]),
+	CLKDEV_DEV_ID("spi_r8a7791_msiof.2", &mstp_clks[MSTP208]),
+	CLKDEV_DEV_ID("spi_r8a7791_msiof.3", &mstp_clks[MSTP205]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
-- 
1.7.9.5

