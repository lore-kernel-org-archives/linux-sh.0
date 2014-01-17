From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 17 Jan 2014 18:20:53 +0000
Subject: [PATCH V2 2/3] ARM: shmobile: r8a7790: Add PCI USB host clock support
Message-Id: <1389982854-20680-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds internal PCI USB host clock support.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

Changes in V2:
* capitalized ARM in the subject;
* rebased on top the latest devel tag.

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index f25b43a..507073e 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -201,7 +201,7 @@ enum {
 	MSTP811, MSTP810, MSTP809, MSTP808,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
 	MSTP717, MSTP716,
-	MSTP704,
+	MSTP704, MSTP703,
 	MSTP522,
 	MSTP502, MSTP501,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
@@ -244,6 +244,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP717] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR7, 17, MSTPSR7, 0), /* HSCIF0 */
 	[MSTP716] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR7, 16, MSTPSR7, 0), /* HSCIF1 */
 	[MSTP704] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR7, 4, MSTPSR7, 0), /* HSUSB */
+	[MSTP703] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR7, 3, MSTPSR7, 0), /* EHCI */
 	[MSTP522] = SH_CLK_MSTP32_STS(&extal_clk, SMSTPCR5, 22, MSTPSR5, 0), /* Thermal */
 	[MSTP502] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR5, 2, MSTPSR5, 0), /* Audio-DMAC low */
 	[MSTP501] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR5, 1, MSTPSR5, 0), /* Audio-DMAC hi */
@@ -343,6 +344,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
+	CLKDEV_DEV_ID("pci-rcar-gen2.0", &mstp_clks[MSTP703]),
+	CLKDEV_DEV_ID("pci-rcar-gen2.1", &mstp_clks[MSTP703]),
+	CLKDEV_DEV_ID("pci-rcar-gen2.2", &mstp_clks[MSTP703]),
 	CLKDEV_DEV_ID("sata-r8a7790.0", &mstp_clks[MSTP815]),
 	CLKDEV_DEV_ID("sata-r8a7790.1", &mstp_clks[MSTP814]),
 
-- 
1.8.3.1

