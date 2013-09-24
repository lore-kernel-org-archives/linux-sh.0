From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Sep 2013 06:04:10 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7778: cleanup registration of vin
Message-Id: <8738ousqlk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

vin driver which needs platform data at the time of
registration is used from BockW only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed
if DT support is completed.
Current driver registration method which needs platform data
and which is not shared complicates codes.
This means legacy C code cleanup after DT supporting
will be more complicated
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c          |   32 ++++++++++++++++++-----
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 --
 arch/arm/mach-shmobile/setup-r8a7778.c        |   34 -------------------------
 3 files changed, 26 insertions(+), 42 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 330e84c..450ac3d 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -269,10 +269,6 @@ static struct sh_mmcif_plat_data sh_mmcif_plat __initdata = {
 			  MMC_CAP_NEEDS_POLL,
 };
 
-static struct rcar_vin_platform_data vin_platform_data __initdata = {
-	.flags	= RCAR_VIN_BT656,
-};
-
 /* In the default configuration both decoders reside on I2C bus 0 */
 #define BOCKW_CAMERA(idx)						\
 static struct i2c_board_info camera##idx##_info = {			\
@@ -469,6 +465,30 @@ static struct asoc_simple_card_info rsnd_card_info[] = {
 	}
 };
 
+/* VIN */
+static struct rcar_vin_platform_data vin_platform_data __initdata = {
+	.flags	= RCAR_VIN_BT656,
+};
+
+#define R8A7778_VIN(idx)						\
+static struct resource vin##idx##_resources[] __initdata = {		\
+	DEFINE_RES_MEM(0xffc50000 + 0x1000 * (idx), 0x1000),		\
+	DEFINE_RES_IRQ(gic_iid(0x5a)),					\
+};									\
+									\
+static struct platform_device_info vin##idx##_info __initdata = {	\
+	.parent		= &platform_bus,				\
+	.name		= "r8a7778-vin",				\
+	.id		= idx,						\
+	.res		= vin##idx##_resources,				\
+	.num_res	= ARRAY_SIZE(vin##idx##_resources),		\
+	.dma_mask	= DMA_BIT_MASK(32),				\
+	.data		= &vin_platform_data,				\
+	.size_data	= sizeof(vin_platform_data),			\
+}
+R8A7778_VIN(0);
+R8A7778_VIN(1);
+
 static const struct pinctrl_map bockw_pinctrl_map[] = {
 	/* AUDIO */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar_sound", "pfc-r8a7778",
@@ -549,10 +569,10 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_ether_device(&ether_platform_data);
-	r8a7778_add_vin_device(0, &vin_platform_data);
+	platform_device_register_full(&vin0_info);
 	/* VIN1 has a pin conflict with Ether */
 	if (!IS_ENABLED(CONFIG_SH_ETH))
-		r8a7778_add_vin_device(1, &vin_platform_data);
+		platform_device_register_full(&vin1_info);
 	platform_device_register_data(&platform_bus, "soc-camera-pdrv", 0,
 				      &iclink0_ml86v7667,
 				      sizeof(iclink0_ml86v7667));
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index ea1dca6..cb99721 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -24,8 +24,6 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
-extern void r8a7778_add_vin_device(int id,
-				   struct rcar_vin_platform_data *pdata);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index e484d14..e5d97dd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -298,40 +298,6 @@ void __init r8a7778_register_hspi(int id)
 		hspi_resources + (2 * id), 2);
 }
 
-/* VIN */
-#define R8A7778_VIN(idx)						\
-static struct resource vin##idx##_resources[] __initdata = {		\
-	DEFINE_RES_MEM(0xffc50000 + 0x1000 * (idx), 0x1000),		\
-	DEFINE_RES_IRQ(gic_iid(0x5a)),					\
-};									\
-									\
-static struct platform_device_info vin##idx##_info __initdata = {	\
-	.parent		= &platform_bus,				\
-	.name		= "r8a7778-vin",				\
-	.id		= idx,						\
-	.res		= vin##idx##_resources,				\
-	.num_res	= ARRAY_SIZE(vin##idx##_resources),		\
-	.dma_mask	= DMA_BIT_MASK(32),				\
-}
-
-R8A7778_VIN(0);
-R8A7778_VIN(1);
-
-static struct platform_device_info *vin_info_table[] __initdata = {
-	&vin0_info,
-	&vin1_info,
-};
-
-void __init r8a7778_add_vin_device(int id, struct rcar_vin_platform_data *pdata)
-{
-	BUG_ON(id < 0 || id > 1);
-
-	vin_info_table[id]->data = pdata;
-	vin_info_table[id]->size_data = sizeof(*pdata);
-
-	platform_device_register_full(vin_info_table[id]);
-}
-
 void __init r8a7778_add_dt_devices(void)
 {
 	int i;
-- 
1.7.9.5

