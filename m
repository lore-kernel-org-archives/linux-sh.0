From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Oct 2011 03:02:35 +0000
Subject: [PATCH 5/5] ARM: mach-shmobile: add SMSC9221 support
Message-Id: <87aa8w2wmv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bonito.c |   34 +++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bonito.c b/arch/arm/mach-shmobile/board-bonito.c
index 08c3795..e93c61d 100644
--- a/arch/arm/mach-shmobile/board-bonito.c
+++ b/arch/arm/mach-shmobile/board-bonito.c
@@ -96,6 +96,8 @@
 #define FPGA_IRQ0		(FPGA_IRQ_BASE)
 #define FPGA_IRQ1		(FPGA_IRQ_BASE + 16)
 
+#define FPGA_ETH_IRQ		(FPGA_IRQ0 + 15)
+
 static u16 fpga_read(u32 offset)
 {
 	return __raw_readw(0xf0003000 + offset);
@@ -279,6 +281,37 @@ static struct platform_device lcdc0_device = {
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
@@ -289,6 +322,7 @@ static struct platform_device *bonito_core_devices[] __initdata = {
  */
 static struct platform_device *bonito_base_devices[] __initdata = {
 	&lcdc0_device,
+	&smsc_device,
 };
 
 /*
-- 
1.7.4.1

