From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 29 Oct 2012 08:15:11 +0000
Subject: [PATCH 4/7] ARM: shmobile: r8a7779: add USB OHCI clock support
Message-Id: <87fw4x4ruc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ohci-platform driver require these clocks

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 8dea307..c019609 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -157,7 +157,9 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
+	CLKDEV_DEV_ID("ohci-platform.1", &mstp_clks[MSTP101]), /* USB OHCI port2 */
 	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
+	CLKDEV_DEV_ID("ohci-platform.0", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
-- 
1.7.9.5

