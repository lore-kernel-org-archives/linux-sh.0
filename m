From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Fri, 24 Jan 2014 22:29:05 +0000
Subject: [PATCH V3 3/4] ARM: shmobile: r8a7791: Add PCI USB host clock support
Message-Id: <1390602546-11911-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds internal PCI USB host clock support to R-Car M2 SoC.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Changes in V3:
* none.

Changes in V2:
* capitalized ARM in the subject;
* rebased on top the latest devel tag.

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index ab1ef2e..564cd46 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -140,7 +140,7 @@ enum {
 	MSTP811, MSTP810, MSTP809,
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
-	MSTP704,
+	MSTP704, MSTP703,
 	MSTP522,
 	MSTP216, MSTP207, MSTP206,
 	MSTP204, MSTP203, MSTP202, MSTP1105, MSTP1106, MSTP1107,
@@ -171,6 +171,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP715] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR7, 15, MSTPSR7, 0), /* SCIF4 */
 	[MSTP714] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR7, 14, MSTPSR7, 0), /* SCIF5 */
 	[MSTP704] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR7, 4, MSTPSR7, 0), /* HSUSB */
+	[MSTP703] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR7, 3, MSTPSR7, 0), /* EHCI */
 	[MSTP522] = SH_CLK_MSTP32_STS(&extal_clk, SMSTPCR5, 22, MSTPSR5, 0), /* Thermal */
 	[MSTP216] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 16, MSTPSR2, 0), /* SCIFB2 */
 	[MSTP207] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR2, 7, MSTPSR2, 0), /* SCIFB1 */
@@ -238,6 +239,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sata-r8a7791.1", &mstp_clks[MSTP814]),
 	CLKDEV_DEV_ID("renesas_usbhs", &mstp_clks[MSTP704]),
 	CLKDEV_ICK_ID("usbhs", "usb_phy_rcar_gen2", &mstp_clks[MSTP704]),
+	CLKDEV_DEV_ID("pci-rcar-gen2.0", &mstp_clks[MSTP703]),
+	CLKDEV_DEV_ID("pci-rcar-gen2.1", &mstp_clks[MSTP703]),
 };
 
 #define R8A7791_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.8.3.1

