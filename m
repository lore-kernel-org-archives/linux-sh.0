From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 14 Jan 2011 07:39:18 +0000
Subject: [PATCH] ARM: mach-shmobile: ag5evm: Add IrDA support
Message-Id: <w3pr5cgndcp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3pk4jw518f.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3pk4jw518f.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ag5evm.c |   28 ++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/clock-sh73a0.c |    4 +++-
 2 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ag5evm.c b/arch/arm/mach-shmobile/board-ag5evm.c
index 2f13592..b416c08 100644
--- a/arch/arm/mach-shmobile/board-ag5evm.c
+++ b/arch/arm/mach-shmobile/board-ag5evm.c
@@ -183,11 +183,33 @@ static struct platform_device mmc_device = {
 	.resource	= sh_mmcif_resources,
 };
 
+/* IrDA */
+#define IRQ_IRDA gic_spi(95)
+static struct resource irda_resources[] = {
+	[0] = {
+		.start	= 0xE6D00000,
+		.end	= 0xE6D01FD4 - 1,
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_IRDA,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device irda_device = {
+	.name           = "sh_irda",
+	.id		= 0,
+	.resource       = irda_resources,
+	.num_resources  = ARRAY_SIZE(irda_resources),
+};
+
 static struct platform_device *ag5evm_devices[] __initdata = {
 	&eth_device,
 	&keysc_device,
 	&fsi_device,
 	&mmc_device,
+	&irda_device,
 };
 
 static struct map_desc ag5evm_io_desc[] __initdata = {
@@ -287,6 +309,12 @@ static void __init ag5evm_init(void)
 	gpio_request(GPIO_FN_FSIAISLD, NULL);
 	gpio_request(GPIO_FN_FSIAOSLD, NULL);
 
+	/* IrDA */
+	gpio_request(GPIO_FN_PORT241_IRDA_OUT, NULL);
+	gpio_request(GPIO_FN_PORT242_IRDA_IN,  NULL);
+	gpio_request(GPIO_FN_PORT243_IRDA_FIRSEL, NULL);
+	set_irq_type(IRQ_IRDA, IRQ_TYPE_LEVEL_LOW);
+
 #ifdef CONFIG_CACHE_L2X0
 	/* Shared attribute override enable, 64K*8way */
 	l2x0_init(__io(0xf0100000), 0x00460000, 0xc2000fff);
diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 4195818..d9d6d02 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -258,7 +258,7 @@ enum { MSTP001,
 	MSTP125, MSTP116,
 	MSTP219,
 	MSTP207, MSTP206, MSTP204, MSTP203, MSTP202, MSTP201, MSTP200,
-	MSTP331, MSTP329, MSTP323, MSTP312,
+	MSTP331, MSTP329, MSTP325, MSTP323, MSTP312,
 	MSTP411, MSTP410, MSTP403,
 	MSTP_NR };
 
@@ -279,6 +279,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP200] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR2, 0, 0), /* SCIFA4 */
 	[MSTP331] = MSTP(&div6_clks[DIV6_SUB], SMSTPCR3, 31, 0), /* SCIFA6 */
 	[MSTP329] = MSTP(&r_clk, SMSTPCR3, 29, 0), /* CMT10 */
+	[MSTP325] = MSTP(&div4_clks[DIV6_SUB], SMSTPCR3, 25, 0), /* IrDA */
 	[MSTP323] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 23, 0), /* IIC1 */
 	[MSTP312] = MSTP(&div4_clks[DIV4_HP], SMSTPCR3, 12, 0), /* MMCIF0 */
 	[MSTP411] = MSTP(&div4_clks[DIV4_HP], SMSTPCR4, 11, 0), /* IIC3 */
@@ -308,6 +309,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_cmt.10", &mstp_clks[MSTP329]), /* CMT10 */
+	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP323]), /* I2C1 */
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP312]), /* MMCIF0 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.3", &mstp_clks[MSTP411]), /* I2C3 */
-- 
1.7.1

