From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Tue, 13 Jan 2009 15:45:48 +0000
Subject: [PATCH 1/3] sh: convert magicpanelr2 platform to use smsc911x
Message-Id: <1231861550-29681-2-git-send-email-steve.glendinning@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/board-magicpanelr2.c    |   23 +++++++++++++++++------
 arch/sh/configs/magicpanelr2_defconfig |   21 +++++++++++++++++++--
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/arch/sh/boards/board-magicpanelr2.c b/arch/sh/boards/board-magicpanelr2.c
index 3de22cc..8dd589a 100644
--- a/arch/sh/boards/board-magicpanelr2.c
+++ b/arch/sh/boards/board-magicpanelr2.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/smsc911x.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/physmap.h>
@@ -242,7 +243,7 @@ static void __init mpr2_setup(char **cmdline_p)
 		printk(KERN_WARNING "Ethernet not ready\n");
 }
 
-static struct resource smc911x_resources[] = {
+static struct resource smsc911x_resources[] = {
 	[0] = {
 		.start		= 0xa8000000,
 		.end		= 0xabffffff,
@@ -255,11 +256,21 @@ static struct resource smc911x_resources[] = {
 	},
 };
 
-static struct platform_device smc911x_device = {
-	.name		= "smc911x",
+static struct smsc911x_platform_config smsc911x_config = {
+	.irq_polarity = SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type = SMSC911X_IRQ_TYPE_OPEN_DRAIN,
+	.flags = SMSC911X_USE_32BIT,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+};
+
+static struct platform_device smsc911x_device = {
+	.name		= "smsc911x",
 	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smc911x_resources),
-	.resource	= smc911x_resources,
+	.num_resources	= ARRAY_SIZE(smsc911x_resources),
+	.resource	= smsc911x_resources,
+	.dev = {
+		.platform_data = &smsc911x_config,
+	},
 };
 
 static struct resource heartbeat_resources[] = {
@@ -360,7 +371,7 @@ static void __init set_mtd_partitions(void)
 
 static struct platform_device *mpr2_devices[] __initdata = {
 	&heartbeat_device,
-	&smc911x_device,
+	&smsc911x_device,
 	&flash_device,
 };
 
diff --git a/arch/sh/configs/magicpanelr2_defconfig b/arch/sh/configs/magicpanelr2_defconfig
index 499ed72..e590085 100644
--- a/arch/sh/configs/magicpanelr2_defconfig
+++ b/arch/sh/configs/magicpanelr2_defconfig
@@ -502,13 +502,30 @@ CONFIG_NETDEVICES=y
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
1.6.0.6

