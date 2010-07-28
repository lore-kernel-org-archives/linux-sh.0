From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 28 Jul 2010 02:54:23 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh7372: modify clock name for FSI2
Message-Id: <w3peieogvtt.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p1vcreaqm.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 2b804aa..26d651c 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -514,7 +514,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_CON_ID("cmt1", &mstp_clks[MSTP329]), /* CMT10 */
-	CLKDEV_DEV_ID("sh_fsi", &mstp_clks[MSTP328]), /* FSI */
+	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI2 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP323]), /* USB0 */
 	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP323]), /* USB0 */
-- 
1.7.0.4

