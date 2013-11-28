From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 28 Nov 2013 08:54:46 +0000
Subject: [PATCH 16/16] ARM: shmobile: sh7372: tidyup clock table order
Message-Id: <8af3f18b7b42e32387b54d2e2f8300589b0198e9.1385628709.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

SuperH lookups clock is using CLKDEV_CON/DEV/ICK_ID() macro
for a long term.
But in these days, the ICK clock is defined in random place.
This patch arranges it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh7372.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-sh7372.c b/arch/arm/mach-shmobile/clock-sh7372.c
index 5390c6b..2848997 100644
--- a/arch/arm/mach-shmobile/clock-sh7372.c
+++ b/arch/arm/mach-shmobile/clock-sh7372.c
@@ -504,10 +504,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("spu_clk", &div6_clks[DIV6_SPU]),
 	CLKDEV_CON_ID("vou_clk", &div6_clks[DIV6_VOU]),
 	CLKDEV_CON_ID("hdmi_clk", &div6_reparent_clks[DIV6_HDMI]),
-	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
-	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
-	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
-	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* IIC2 */
@@ -574,6 +570,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP403]), /* KEYSC */
 	CLKDEV_DEV_ID("sh_cmt.2", &mstp_clks[MSTP400]), /* CMT2 */
 
+	/* ICK */
+	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSIT]),
+	CLKDEV_ICK_ID("dsit_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSIT]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.0", &div6_clks[DIV6_DSI0P]),
+	CLKDEV_ICK_ID("dsip_clk", "sh-mipi-dsi.1", &div6_clks[DIV6_DSI1P]),
 	CLKDEV_ICK_ID("hdmi", "sh_mobile_lcdc_fb.1",
 		      &div6_reparent_clks[DIV6_HDMI]),
 	CLKDEV_ICK_ID("ick", "sh-mobile-hdmi", &div6_reparent_clks[DIV6_HDMI]),
-- 
1.8.4

