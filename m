From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 26 Dec 2013 15:37:59 +0000
Subject: [PATCH V2 3/3] arm: shmobile: koelsch: Add VIN1 SoC camera support
Message-Id: <1388072279-12508-4-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds VIN1 SoC camera along with ADV7180 subdevice support to Koelsch.
VIN0 camera is not registered because it has ADV7612 I2C subdevice
which is not supported yet.

Changes in V2:
* made koelsch_add_vin_device function static.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-koelsch.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 799825c..6eb5a58 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -27,6 +27,7 @@
 #include <linux/leds.h>
 #include <linux/phy.h>
 #include <linux/pinctrl/machine.h>
+#include <linux/platform_data/camera-rcar.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/rcar-du.h>
 #include <linux/platform_device.h>
@@ -35,6 +36,7 @@
 #include <mach/irqs.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
+#include <media/soc_camera.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -180,6 +182,62 @@ static void __init koelsch_add_i2c(unsigned idx)
 					i2c_resources + res_idx, 2);
 }
 
+/* VIN */
+static const struct resource vin_resources[] __initconst = {
+	/* VIN0 */
+	DEFINE_RES_MEM(0xe6ef0000, 0x1000),
+	DEFINE_RES_IRQ(gic_spi(188)),
+	/* VIN1 */
+	DEFINE_RES_MEM(0xe6ef1000, 0x1000),
+	DEFINE_RES_IRQ(gic_spi(189)),
+};
+
+static void __init koelsch_add_vin_device(unsigned idx,
+					  struct rcar_vin_platform_data *pdata)
+{
+	struct platform_device_info vin_info = {
+		.parent		= &platform_bus,
+		.name		= "r8a7791-vin",
+		.id		= idx,
+		.res		= &vin_resources[idx * 2],
+		.num_res	= 2,
+		.dma_mask	= DMA_BIT_MASK(32),
+		.data		= pdata,
+		.size_data	= sizeof(*pdata),
+	};
+
+	BUG_ON(idx > 1);
+
+	platform_device_register_full(&vin_info);
+}
+
+#define KOELSCH_CAMERA(idx, name, addr, pdata, flag)			\
+static struct i2c_board_info i2c_cam##idx##_device = {			\
+	I2C_BOARD_INFO(name, addr),					\
+};									\
+									\
+static struct rcar_vin_platform_data vin##idx##_pdata = {		\
+	.flags = flag,							\
+};									\
+									\
+static struct soc_camera_link cam##idx##_link = {			\
+	.bus_id = idx,							\
+	.board_info = &i2c_cam##idx##_device,				\
+	.i2c_adapter_id = 2,						\
+	.module_name = name,						\
+	.priv = pdata,							\
+}
+
+/* Camera 0 is not currently supported due to adv7612 support missing */
+KOELSCH_CAMERA(1, "adv7180", 0x20, NULL, RCAR_VIN_BT656);
+
+static void __init koelsch_add_camera1_device(void)
+{
+	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 1,
+				      &cam1_link, sizeof(cam1_link));
+	koelsch_add_vin_device(1, &vin1_pdata);
+}
+
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* DU */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
@@ -212,6 +270,22 @@ static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* I2C4 */
 	PIN_MAP_MUX_GROUP_DEFAULT("i2c-rcar_gen2.4", "pfc-r8a7791",
 				  "i2c4_c", "i2c4"),
+	/* VIN0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-vin.0", "pfc-r8a7791",
+				  "vin0_data24", "vin0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-vin.0", "pfc-r8a7791",
+				  "vin0_sync", "vin0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-vin.0", "pfc-r8a7791",
+				  "vin0_field", "vin0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-vin.0", "pfc-r8a7791",
+				  "vin0_clkenb", "vin0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-vin.0", "pfc-r8a7791",
+				  "vin0_clk", "vin0"),
+	/* VIN1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-vin.1", "pfc-r8a7791",
+				  "vin1_data8", "vin1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7791-vin.1", "pfc-r8a7791",
+				  "vin1_clk", "vin1"),
 };
 
 static void __init koelsch_add_standard_devices(void)
@@ -238,6 +312,8 @@ static void __init koelsch_add_standard_devices(void)
 	koelsch_add_i2c(2);
 	koelsch_add_i2c(4);
 	koelsch_add_i2c(5);
+
+	koelsch_add_camera1_device();
 }
 
 /*
-- 
1.8.3.1

