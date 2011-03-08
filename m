From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 08 Mar 2011 08:00:00 +0000
Subject: [PATCH] sh: add GETHER's platform_device in board-sh7757lcr
Message-Id: <4D75E200.4040409@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch also modifies for ETHER's platform_device.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch depends on the following patches in netdev ml.
  - net: sh_eth: modify the definitions of register
  - net: sh_eth: remove the SH_TSU_ADDR
  - net: sh_eth: add set_mdio_gate in bb_info

 arch/sh/boards/board-sh7757lcr.c |   93 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 93 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-sh7757lcr.c b/arch/sh/boards/board-sh7757lcr.c
index c475f10..c26c344 100644
--- a/arch/sh/boards/board-sh7757lcr.c
+++ b/arch/sh/boards/board-sh7757lcr.c
@@ -44,6 +44,17 @@ static struct platform_device heartbeat_device = {
 };

 /* Fast Ethernet */
+#define GBECONT		0xffc10100
+#define GBECONT_RMII1	BIT(17)
+#define GBECONT_RMII0	BIT(16)
+static void sh7757_eth_set_mdio_gate(unsigned long addr)
+{
+	if ((addr & 0x00000fff) < 0x0800)
+		writel(readl(GBECONT) | GBECONT_RMII0, GBECONT);
+	else
+		writel(readl(GBECONT) | GBECONT_RMII1, GBECONT);
+}
+
 static struct resource sh_eth0_resources[] = {
 	{
 		.start  = 0xfef00000,
@@ -59,6 +70,8 @@ static struct resource sh_eth0_resources[] = {
 static struct sh_eth_plat_data sh7757_eth0_pdata = {
 	.phy = 1,
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_FAST_SH4,
+	.set_mdio_gate = sh7757_eth_set_mdio_gate,
 };

 static struct platform_device sh7757_eth0_device = {
@@ -86,6 +99,8 @@ static struct resource sh_eth1_resources[] = {
 static struct sh_eth_plat_data sh7757_eth1_pdata = {
 	.phy = 1,
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_FAST_SH4,
+	.set_mdio_gate = sh7757_eth_set_mdio_gate,
 };

 static struct platform_device sh7757_eth1_device = {
@@ -98,10 +113,88 @@ static struct platform_device sh7757_eth1_device = {
 	},
 };

+static void sh7757_eth_giga_set_mdio_gate(unsigned long addr)
+{
+	if ((addr & 0x00000fff) < 0x0800) {
+		gpio_set_value(GPIO_PTT4, 1);
+		writel(readl(GBECONT) & ~GBECONT_RMII0, GBECONT);
+	} else {
+		gpio_set_value(GPIO_PTT4, 0);
+		writel(readl(GBECONT) & ~GBECONT_RMII1, GBECONT);
+	}
+}
+
+static struct resource sh_eth_giga0_resources[] = {
+	{
+		.start  = 0xfee00000,
+		.end    = 0xfee007ff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		/* TSU */
+		.start  = 0xfee01800,
+		.end    = 0xfee01fff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = 315,
+		.end    = 315,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_eth_plat_data sh7757_eth_giga0_pdata = {
+	.phy = 18,
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_GIGABIT,
+	.set_mdio_gate = sh7757_eth_giga_set_mdio_gate,
+	.phy_interface = PHY_INTERFACE_MODE_RGMII_ID,
+};
+
+static struct platform_device sh7757_eth_giga0_device = {
+	.name		= "sh-eth",
+	.resource	= sh_eth_giga0_resources,
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(sh_eth_giga0_resources),
+	.dev		= {
+		.platform_data = &sh7757_eth_giga0_pdata,
+	},
+};
+
+static struct resource sh_eth_giga1_resources[] = {
+	{
+		.start  = 0xfee00800,
+		.end    = 0xfee00fff,
+		.flags  = IORESOURCE_MEM,
+	}, {
+		.start  = 316,
+		.end    = 316,
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct sh_eth_plat_data sh7757_eth_giga1_pdata = {
+	.phy = 19,
+	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_GIGABIT,
+	.set_mdio_gate = sh7757_eth_giga_set_mdio_gate,
+	.phy_interface = PHY_INTERFACE_MODE_RGMII_ID,
+};
+
+static struct platform_device sh7757_eth_giga1_device = {
+	.name		= "sh-eth",
+	.resource	= sh_eth_giga1_resources,
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(sh_eth_giga1_resources),
+	.dev		= {
+		.platform_data = &sh7757_eth_giga1_pdata,
+	},
+};
+
 static struct platform_device *sh7757lcr_devices[] __initdata = {
 	&heartbeat_device,
 	&sh7757_eth0_device,
 	&sh7757_eth1_device,
+	&sh7757_eth_giga0_device,
+	&sh7757_eth_giga1_device,
 };

 static int __init sh7757lcr_devices_setup(void)
-- 
1.7.1
