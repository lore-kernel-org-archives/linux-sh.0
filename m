From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:31:38 +0000
Subject: [PATCH 01/11] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <87li5dfqft.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_eth driver which needs platform data at the time of
registration is used from BockW only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed in the future.
The driver registration method which needs platform data
and which is not shared complicates codes.
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c          |   15 ++++++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 --
 arch/arm/mach-shmobile/setup-r8a7778.c        |   14 --------------
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 6f541ad..82a5559 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -25,6 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
+#include <linux/sh_eth.h>
 #include <linux/smsc911x.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/flash.h>
@@ -83,6 +84,12 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
+/* Ether */
+static struct resource ether_resources[] __initdata = {
+	DEFINE_RES_MEM(0xfde00000, 0x400),
+	DEFINE_RES_IRQ(gic_iid(0x89)),
+};
+
 static struct sh_eth_plat_data ether_platform_data __initdata = {
 	.phy		= 0x01,
 	.edmac_endian	= EDMAC_LITTLE_ENDIAN,
@@ -179,7 +186,6 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
-	r8a7778_add_ether_device(&ether_platform_data);
 	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
 	r8a7778_add_mmc_device(&sh_mmcif_plat);
@@ -193,6 +199,13 @@ static void __init bockw_init(void)
 				  ARRAY_SIZE(bockw_pinctrl_map));
 	r8a7778_pinmux_init();
 
+	platform_device_register_resndata(
+		&platform_bus, "r8a777x-ether", -1,
+		ether_resources,
+		ARRAY_SIZE(ether_resources),
+		&ether_platform_data,
+		sizeof(struct sh_eth_plat_data));
+
 	/* for SMSC */
 	base = ioremap_nocache(FPGA, SZ_1M);
 	if (base) {
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 5d0e120..fab62d0 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -20,12 +20,10 @@
 
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
-#include <linux/sh_eth.h>
 #include <linux/platform_data/usb-rcar-phy.h>
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
-extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index a3a2e37..21db023 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -188,20 +188,6 @@ static struct platform_device_info hci##_info __initdata = {	\
 USB_PLATFORM_INFO(ehci);
 USB_PLATFORM_INFO(ohci);
 
-/* Ether */
-static struct resource ether_resources[] __initdata = {
-	DEFINE_RES_MEM(0xfde00000, 0x400),
-	DEFINE_RES_IRQ(gic_iid(0x89)),
-};
-
-void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  pdata, sizeof(*pdata));
-}
-
 /* PFC/GPIO */
 static struct resource pfc_resources[] __initdata = {
 	DEFINE_RES_MEM(0xfffc0000, 0x118),
-- 
1.7.9.5

