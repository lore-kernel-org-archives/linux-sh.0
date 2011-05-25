From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 25 May 2011 02:49:18 +0000
Subject: [PATCH 1/2] ARM: arch-shmobile: sh7372: add renesas_usbhs irq support
Message-Id: <w3paaebv6j5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pboyrv6j8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pboyrv6j8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

renesas_usbhs is remake version of r8a66597

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/clock-sh7372.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 95b814a..d17eb66 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -638,6 +638,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* IIC1 */
 	CLKDEV_DEV_ID("r8a66597_hcd.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("r8a66597_udc.0", &mstp_clks[MSTP322]), /* USB0 */
+	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP322]), /* USB0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP314]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP313]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMC */
@@ -648,6 +649,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-sh_mobile.4", &mstp_clks[MSTP410]), /* IIC4 */
 	CLKDEV_DEV_ID("r8a66597_hcd.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("r8a66597_udc.1", &mstp_clks[MSTP406]), /* USB1 */
+	CLKDEV_DEV_ID("renesas_usbhs.1", &mstp_clks[MSTP406]), /* USB1 */
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
 
 	CLKDEV_ICK_ID("ick", "sh-mobile-hdmi", &div6_reparent_clks[DIV6_HDMI]),
-- 
1.7.1

