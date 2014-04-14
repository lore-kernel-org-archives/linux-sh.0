From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 14 Apr 2014 10:58:36 +0000
Subject: [PATCH 01/02] ARM: shmobile: lager: DT reference VSP1 platform devices
Message-Id: <20140414105836.12530.68878.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add 4 VSP1 devices to the Lager board. Based on BSP code written
by Yoshifumi Hosoya, but adjusted to use CCF for clocks.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas-devel-v3.15-rc1-20140414v2 and
 [PATCH v2 00/05] ARM: shmobile: Lager and Koelsch USB prototype patches

 arch/arm/mach-shmobile/board-lager-reference.c |   88 ++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

--- 0002/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-04-14 18:25:48.000000000 +0900
@@ -25,6 +25,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/usb-rcar-gen2-phy.h>
+#include <linux/platform_data/vsp1.h>
 #include <linux/usb/phy.h>
 #include <linux/usb/renesas_usbhs.h>
 #include <mach/clock.h>
@@ -112,6 +113,10 @@ static const struct clk_name clk_names[]
 	{ "lvds0", "lvds.0", "rcar-du-r8a7790" },
 	{ "lvds1", "lvds.1", "rcar-du-r8a7790" },
 	{ "hsusb", NULL, "usb_phy_rcar_gen2" },
+	{ "vsp1-rt", NULL, "vsp1.0" },
+	{ "vsp1-sy", NULL, "vsp1.1" },
+	{ "vsp1-du0", NULL, "vsp1.2" },
+	{ "vsp1-du1", NULL, "vsp1.3" },
 };
 
 /*
@@ -324,6 +329,88 @@ static void __init lager_add_usb2_device
 	platform_device_register_full(&pci2_info);
 }
 
+/* VSP1 */
+static const struct vsp1_platform_data lager_vspr_pdata __initconst = {
+	.features = VSP1_HAS_LUT | VSP1_HAS_SRU,
+	.rpf_count = 5,
+	.uds_count = 1,
+	.wpf_count = 4,
+};
+
+static const struct vsp1_platform_data lager_vsps_pdata __initconst = {
+	.features = VSP1_HAS_SRU,
+	.rpf_count = 5,
+	.uds_count = 3,
+	.wpf_count = 4,
+};
+
+static const struct vsp1_platform_data lager_vspd0_pdata __initconst = {
+	.features = VSP1_HAS_LIF | VSP1_HAS_LUT,
+	.rpf_count = 4,
+	.uds_count = 1,
+	.wpf_count = 4,
+};
+
+static const struct vsp1_platform_data lager_vspd1_pdata __initconst = {
+	.features = VSP1_HAS_LIF | VSP1_HAS_LUT,
+	.rpf_count = 4,
+	.uds_count = 1,
+	.wpf_count = 4,
+};
+
+static const struct vsp1_platform_data * const lager_vsp1_pdata[4] __initconst = {
+	&lager_vspr_pdata,
+	&lager_vsps_pdata,
+	&lager_vspd0_pdata,
+	&lager_vspd1_pdata,
+};
+
+static const struct resource vspr_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfe920000, 0x8000),
+	DEFINE_RES_IRQ(gic_spi(266)),
+};
+
+static const struct resource vsps_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfe928000, 0x8000),
+	DEFINE_RES_IRQ(gic_spi(267)),
+};
+
+static const struct resource vspd0_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfe930000, 0x8000),
+	DEFINE_RES_IRQ(gic_spi(246)),
+};
+
+static const struct resource vspd1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xfe938000, 0x8000),
+	DEFINE_RES_IRQ(gic_spi(247)),
+};
+
+static const struct resource * const vsp1_resources[4] __initconst = {
+	vspr_resources,
+	vsps_resources,
+	vspd0_resources,
+	vspd1_resources,
+};
+
+static void __init lager_add_vsp1_devices(void)
+{
+	struct platform_device_info info = {
+		.name = "vsp1",
+		.size_data = sizeof(*lager_vsp1_pdata[0]),
+		.num_res = 2,
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(vsp1_resources); ++i) {
+		info.id = i;
+		info.data = lager_vsp1_pdata[i];
+		info.res = vsp1_resources[i];
+
+		platform_device_register_full(&info);
+	}
+}
+
 static void __init lager_add_standard_devices(void)
 {
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
@@ -340,6 +427,7 @@ static void __init lager_add_standard_de
 	lager_register_usbhs();
 	lager_add_usb1_device();
 	lager_add_usb2_device();
+	lager_add_vsp1_devices();
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
