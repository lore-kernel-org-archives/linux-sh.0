From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Apr 2014 10:58:45 +0000
Subject: [PATCH 02/02] ARM: shmobile: koelsch: DT reference VSP1 platform devices
Message-Id: <20140414105845.12530.98920.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add 3 VSP1 devices to the Koelsch board. Based on BSP code written
by Yoshifumi Hosoya, but adjusted to use CCF for clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.15-rc1-20140414v2 and
 [PATCH v2 00/05] ARM: shmobile: Lager and Koelsch USB prototype patches

 arch/arm/mach-shmobile/board-koelsch-reference.c |   74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

--- 0004/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-04-14 17:36:04.000000000 +0900
@@ -26,6 +26,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-gen2-phy.h>
+#include <linux/platform_data/vsp1.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <mach/clock.h>
@@ -111,6 +112,9 @@ static const struct clk_name clk_names[]
 	{ "du1", "du.1", "rcar-du-r8a7791" },
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
 	{ "hsusb", NULL, "usb_phy_rcar_gen2" },
+	{ "vsp1-sy", NULL, "vsp1.1" },
+	{ "vsp1-du0", NULL, "vsp1.2" },
+	{ "vsp1-du1", NULL, "vsp1.3" },
 };
 
 /*
@@ -303,6 +307,75 @@ static void __init koelsch_add_usb_devic
 	koelsch_add_usb0_gadget();
 	koelsch_add_usb1_host();
 }
+ 
+/* VSP1 */
+static const struct vsp1_platform_data koelsch_vsps_pdata __initconst = {
+	.features = 0,
+	.rpf_count = 5,
+	.uds_count = 3,
+	.wpf_count = 4,
+};
+
+static const struct vsp1_platform_data koelsch_vspd0_pdata __initconst = {
+	.features = VSP1_HAS_LIF,
+	.rpf_count = 4,
+	.uds_count = 1,
+	.wpf_count = 4,
+};
+
+static const struct vsp1_platform_data koelsch_vspd1_pdata __initconst = {
+	.features = VSP1_HAS_LIF,
+	.rpf_count = 4,
+	.uds_count = 1,
+	.wpf_count = 4,
+};
+
+static const struct vsp1_platform_data * const koelsch_vsp1_pdata[] __initconst
+									= {
+	&koelsch_vsps_pdata,
+	&koelsch_vspd0_pdata,
+	&koelsch_vspd1_pdata,
+};
+
+static const struct resource vsp1_1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfe928000, 0x8000),
+	DEFINE_RES_IRQ(gic_spi(267)),
+};
+
+static const struct resource vsp1_2_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfe930000, 0x8000),
+	DEFINE_RES_IRQ(gic_spi(246)),
+};
+
+static const struct resource vsp1_3_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfe938000, 0x8000),
+	DEFINE_RES_IRQ(gic_spi(247)),
+};
+
+static const struct resource * const vsp1_resources[] __initconst = {
+	vsp1_1_resources,
+	vsp1_2_resources,
+	vsp1_3_resources,
+};
+
+static void __init koelsch_add_vsp1_devices(void)
+{
+	struct platform_device_info info = {
+		.name = "vsp1",
+		.size_data = sizeof(*koelsch_vsp1_pdata[0]),
+		.num_res = 2,
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsp1_resources); ++i) {
+		info.id = i + 1;
+		info.data = koelsch_vsp1_pdata[i];
+		info.res = vsp1_resources[i];
+
+		platform_device_register_full(&info);
+	}
+}
 
 static void __init koelsch_add_standard_devices(void)
 {
@@ -313,6 +386,7 @@ static void __init koelsch_add_standard_
 
 	koelsch_add_du_device();
 	koelsch_add_usb_devices();
+	koelsch_add_vsp1_devices();
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
