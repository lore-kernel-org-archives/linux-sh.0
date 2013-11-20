From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 20 Nov 2013 17:38:06 +0000
Subject: [PATCH 9/9] ARM: shmobile: lager: add PCI USB host controllers
Message-Id: <1384969086-8920-10-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Adds USB1 and 2 as hosts and binds them to the USB phy.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/Kconfig       |  1 +
 arch/arm/mach-shmobile/board-lager.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 557f55c..e93812f 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -244,6 +244,7 @@ config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
 	select USE_OF
+	select PCI
 
 config MACH_LAGER_REFERENCE
 	bool "Lager board - Reference Device Tree Implementation"
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index efe242d8..71d4482 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -271,6 +271,17 @@ static const struct resource usbhs_phy_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6590100, 0x100),
 };
 
+static const struct resource usbhs_pci1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0b0000, 0xc00),
+	DEFINE_RES_MEM(0xee0a0000, 0x1100),
+	DEFINE_RES_IRQ(gic_spi(112)),
+};
+static const struct resource usbhs_pci2_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee0d0000, 0xc00),
+	DEFINE_RES_MEM(0xee0c0000, 0x1100),
+	DEFINE_RES_IRQ(gic_spi(113)),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -337,6 +348,18 @@ static void __init lager_add_standard_devices(void)
 					  sizeof(usbhs_phy_pdata));
 	lager_register_usbhs();
 
+	usb_bind_phy("0000:00:01.0", 0, "usb_phy_rcar_gen2");
+	usb_bind_phy("0000:00:02.0", 0, "usb_phy_rcar_gen2");
+	usb_bind_phy("0000:01:01.0", 0, "usb_phy_rcar_gen2");
+	usb_bind_phy("0000:01:02.0", 0, "usb_phy_rcar_gen2");
+
+	platform_device_register_simple("pci-rcar-gen2", 1,
+					usbhs_pci1_resources,
+					ARRAY_SIZE(usbhs_pci1_resources));
+	platform_device_register_simple("pci-rcar-gen2", 2,
+					usbhs_pci2_resources,
+					ARRAY_SIZE(usbhs_pci2_resources));
+
 	lager_add_du_device();
 }
 
-- 
1.8.4

