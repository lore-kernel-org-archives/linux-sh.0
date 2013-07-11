From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:32:40 +0000
Subject: [PATCH 07/11] ARM: shmobile: r8a7779: cleanup registration of usb phy
Message-Id: <87d2qpfqe3.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

usb phy driver which needs platform data at the time of
registration is used from Marzen only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed in the future.
The driver registration method which needs platform data
and which is not shared complicates codes.
This patch Registers it on board code as cleanup C code,
here, it used current board's registration method.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-marzen.c         |   24 ++++++++++++++++++++++--
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 --
 arch/arm/mach-shmobile/setup-r8a7779.c        |   17 -----------------
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index a7d1010..9d96233 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -29,6 +29,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
+#include <linux/platform_data/usb-rcar-phy.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/smsc911x.h>
@@ -57,7 +58,26 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 	REGULATOR_SUPPLY("vdd33a", "smsc911x"),
 };
 
-static struct rcar_phy_platform_data usb_phy_platform_data __initdata;
+/* USB PHY */
+static struct resource usb_phy_resources[] = {
+	[0] = {
+		.start		= 0xffe70800,
+		.end		= 0xffe70900 - 1,
+		.flags		= IORESOURCE_MEM,
+	},
+};
+
+static struct rcar_phy_platform_data usb_phy_platform_data;
+
+static struct platform_device usb_phy = {
+	.name		= "rcar_usb_phy",
+	.id		= -1,
+	.dev  = {
+		.platform_data = &usb_phy_platform_data,
+	},
+	.resource	= usb_phy_resources,
+	.num_resources	= ARRAY_SIZE(usb_phy_resources),
+};
 
 /* SMSC LAN89218 */
 static struct resource smsc911x_resources[] = {
@@ -184,6 +204,7 @@ static struct platform_device *marzen_devices[] __initdata = {
 	&thermal_device,
 	&hspi_device,
 	&leds_device,
+	&usb_phy,
 };
 
 static const struct pinctrl_map marzen_pinctrl_map[] = {
@@ -234,7 +255,6 @@ static void __init marzen_init(void)
 	r8a7779_init_irq_extpin(1); /* IRQ1 as individual interrupt */
 
 	r8a7779_add_standard_devices();
-	r8a7779_add_usb_phy_device(&usb_phy_platform_data);
 	platform_add_devices(marzen_devices, ARRAY_SIZE(marzen_devices));
 }
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index fc47073..f10727f7 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -4,7 +4,6 @@
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
 #include <linux/sh_eth.h>
-#include <linux/platform_data/usb-rcar-phy.h>
 
 struct platform_device;
 
@@ -34,7 +33,6 @@ extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
 extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
-extern void r8a7779_add_usb_phy_device(struct rcar_phy_platform_data *pdata);
 extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index e811159..0863aa9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -387,15 +387,6 @@ static struct platform_device sata_device = {
 	},
 };
 
-/* USB PHY */
-static struct resource usb_phy_resources[] __initdata = {
-	[0] = {
-		.start		= 0xffe70800,
-		.end		= 0xffe70900 - 1,
-		.flags		= IORESOURCE_MEM,
-	},
-};
-
 /* USB */
 static struct usb_phy *phy;
 
@@ -601,14 +592,6 @@ void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
 					  pdata, sizeof(*pdata));
 }
 
-void __init r8a7779_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "rcar_usb_phy", -1,
-					  usb_phy_resources,
-					  ARRAY_SIZE(usb_phy_resources),
-					  pdata, sizeof(*pdata));
-}
-
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak r8a7779_register_twd(void) { }
 
-- 
1.7.9.5

