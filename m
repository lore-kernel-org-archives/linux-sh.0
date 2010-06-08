From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Jun 2010 05:34:55 +0000
Subject: [PATCH] ARM: mach-shmobile: clock-sh7367: modify IrDA clock
Message-Id: <w3p8w6qulxd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7367.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7367.c b/arch/arm/mach-shmobile/clock-sh7367.c
index b6454c9..98024eb 100644
--- a/arch/arm/mach-shmobile/clock-sh7367.c
+++ b/arch/arm/mach-shmobile/clock-sh7367.c
@@ -322,7 +322,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[SYMSTP000]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh_siu", &mstp_clks[SYMSTP231]), /* SIU */
 	CLKDEV_CON_ID("cmt1", &mstp_clks[SYMSTP229]), /* CMT10 */
-	CLKDEV_DEV_ID("sh_irda", &mstp_clks[SYMSTP225]), /* IRDA */
+	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[SYMSTP225]), /* IRDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[SYMSTP223]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[SYMSTP222]), /* USBHS */
 	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[SYMSTP222]), /* USBHS */
-- 
1.7.0.4

