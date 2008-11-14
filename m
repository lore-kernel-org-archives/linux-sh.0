From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 14 Nov 2008 06:37:19 +0000
Subject: [PATCH 3/3] smsc911x: convert rsk7203 platform to use smsc911x
Message-Id: <491D1C9F.6060302@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/board-rsk7203.c    |   23 ++++++++++++-----------
 arch/sh/configs/rsk7203_defconfig |   21 +++++++++++++++++++--
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/sh/boards/board-rsk7203.c b/arch/sh/boards/board-rsk7203.c
index 58266f0..8446bf4 100644
--- a/arch/sh/boards/board-rsk7203.c
+++ b/arch/sh/boards/board-rsk7203.c
@@ -15,19 +15,20 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/map.h>
-#include <linux/smc911x.h>
+#include <linux/smsc911x.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <asm/machvec.h>
 #include <asm/io.h>
 #include <cpu/sh7203.h>

-static struct smc911x_platdata smc911x_info = {
-	.flags		= SMC911X_USE_16BIT,
-	.irq_flags	= IRQF_TRIGGER_LOW,
+static struct smsc911x_platform_config smsc911x_config = {
+	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
 };

-static struct resource smc911x_resources[] = {
+static struct resource smsc911x_resources[] = {
 	[0] = {
 		.start		= 0x24000000,
 		.end		= 0x24000000 + 0x100,
@@ -40,13 +41,13 @@ static struct resource smc911x_resources[] = {
 	},
 };

-static struct platform_device smc911x_device = {
-	.name		= "smc911x",
+static struct platform_device smsc911x_device = {
+	.name		= "smsc911x",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smc911x_resources),
-	.resource	= smc911x_resources,
+	.num_resources	= ARRAY_SIZE(smsc911x_resources),
+	.resource	= smsc911x_resources,
 	.dev		= {
-		.platform_data = &smc911x_info,
+		.platform_data = &smsc911x_config,
 	},
 };

@@ -154,7 +155,7 @@ static struct platform_device led_device = {
 };

 static struct platform_device *rsk7203_devices[] __initdata = {
-	&smc911x_device,
+	&smsc911x_device,
 	&flash_device,
 	&led_device,
 };
diff --git a/arch/sh/configs/rsk7203_defconfig b/arch/sh/configs/rsk7203_defconfig
index 85b0ac4..c48ddcb 100644
--- a/arch/sh/configs/rsk7203_defconfig
+++ b/arch/sh/configs/rsk7203_defconfig
@@ -496,13 +496,30 @@ CONFIG_NETDEVICES=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
-# CONFIG_PHYLIB is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+CONFIG_SMSC_PHY=y
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_AX88796 is not set
 # CONFIG_STNIC is not set
 # CONFIG_SMC91X is not set
-CONFIG_SMC911X=y
+# CONFIG_SMC911X is not set
+CONFIG_SMSC911X=y
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
-- 
1.5.6.5


