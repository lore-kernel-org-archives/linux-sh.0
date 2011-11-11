From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Nov 2011 02:47:36 +0000
Subject: [PATCH 20/20] ARM: mach-shmobile: bonito: add SMSC9221 support
Message-Id: <878vnn9xyy.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index fe749e3..4d22016 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -95,6 +95,7 @@
 #define FPGA_IRQ_BASE		(512)
 #define FPGA_IRQ0		(FPGA_IRQ_BASE)
 #define FPGA_IRQ1		(FPGA_IRQ_BASE + 16)
+#define FPGA_ETH_IRQ		(FPGA_IRQ0 + 15)
 static u16 bonito_fpga_read(u32 offset)
 {
 	return __raw_readw(0xf0003000 + offset);
@@ -278,6 +279,37 @@ static struct platform_device lcdc0_device = {
 };
 
 /*
+ * SMSC 9221
+ */
+static struct resource smsc_resources[] = {
+	[0] = {
+		.start		= 0x18010000,
+		.end		= 0x18011000 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= FPGA_ETH_IRQ,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config smsc_platdata = {
+	.flags		= SMSC911X_USE_16BIT,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
+	.irq_polarity	= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type	= SMSC911X_IRQ_TYPE_PUSH_PULL,
+};
+
+static struct platform_device smsc_device = {
+	.name		= "smsc911x",
+	.dev  = {
+		.platform_data = &smsc_platdata,
+	},
+	.resource	= smsc_resources,
+	.num_resources	= ARRAY_SIZE(smsc_resources),
+};
+
+/*
  * core board devices
  */
 static struct platform_device *bonito_core_devices[] __initdata = {
@@ -288,6 +320,7 @@ static struct platform_device *bonito_core_devices[] __initdata = {
  */
 static struct platform_device *bonito_base_devices[] __initdata = {
 	&lcdc0_device,
+	&smsc_device,
 };
 
 /*
-- 
1.7.5.4

