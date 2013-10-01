From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Tue, 01 Oct 2013 18:30:49 +0000
Subject: [PATCH 4/6] arm: shmobile: r8a7790: Add PCI/USB host clock support
Message-Id: <1380652251-8143-5-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds PCI/USB host clock support.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index cf4abba..9061c70 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -186,7 +186,7 @@ enum {
 	MSTP813,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
 	MSTP717, MSTP716,
-	MSTP704,
+	MSTP704, MSTP703,
 	MSTP522,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
@@ -210,6 +210,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
 	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
 	[MSTP704] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 4, 0), /* HS_USB */
+	[MSTP703] = SH_CLK_MSTP32(&mp_clk, SMSTPCR7, 3, 0), /* EHCI */
 	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
 	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, 0), /* MMC0 */
 	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_SD0], SMSTPCR3, 14, 0), /* SDHI0 */
@@ -299,6 +300,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_CON_ID("hsusb", &mstp_clks[MSTP704]),
+	CLKDEV_ICK_ID("ehci", "pci-rcar-gen2", &mstp_clks[MSTP703]),
 };
 
 #define R8A7790_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.8.3.1

