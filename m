From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 19 Mar 2013 09:35:57 +0000
Subject: [PATCH v2] ARM: shmobile: r8a7779: Add PCIe clocks
Message-Id: <1363685757-8159-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
v2:
  Rebased on renesas soc branch.
  Removed ".0" from clock name.

 arch/arm/mach-shmobile/clock-r8a7779.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index d9edeaf..a23c5eb 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -87,7 +87,7 @@ static struct clk div4_clks[DIV4_NR] = {
 };
 
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
-	MSTP115,
+	MSTP116, MSTP115,
 	MSTP103, MSTP101, MSTP100,
 	MSTP030,
 	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
@@ -100,6 +100,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
+	[MSTP116] = SH_CLK_MSTP32(&div4_clks[DIV4_S], MSTPCR1, 16, 0), /* PCIe */
 	[MSTP115] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1, 15, 0), /* SATA */
 	[MSTP103] = SH_CLK_MSTP32(&div4_clks[DIV4_S], MSTPCR1,  3, 0), /* DU */
 	[MSTP101] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  1, 0), /* USB2 */
@@ -159,6 +160,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("peripheral_clk",	&div4_clks[DIV4_P]),
 
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("rcar-pcie", &mstp_clks[MSTP116]), /* PCIe */
 	CLKDEV_DEV_ID("sata_rcar", &mstp_clks[MSTP115]), /* SATA */
 	CLKDEV_DEV_ID("fc600000.sata", &mstp_clks[MSTP115]), /* SATA w/DT */
 	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
-- 
1.7.5.4

