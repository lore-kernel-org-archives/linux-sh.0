From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 24 Sep 2013 06:04:21 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7778: cleanup registration of sh_eth
Message-Id: <871u4esql9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_eth driver which needs platform data at the time of
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
 arch/arm/mach-shmobile/board-bockw.c          |   14 +++++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |   14 --------------
 3 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 450ac3d..3644b40 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -206,6 +206,12 @@ static struct resource sdhi0_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x77)),
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
@@ -568,7 +574,13 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
-	r8a7778_add_ether_device(&ether_platform_data);
+
+	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
+					  ether_resources,
+					  ARRAY_SIZE(ether_resources),
+					  &ether_platform_data,
+					  sizeof(ether_platform_data));
+
 	platform_device_register_full(&vin0_info);
 	/* VIN1 has a pin conflict with Ether */
 	if (!IS_ENABLED(CONFIG_SH_ETH))
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index cb99721..fdbd37d 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -23,7 +23,6 @@
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
-extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index e5d97dd..31e77a8 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -191,20 +191,6 @@ static struct platform_device_info hci##_info __initdata = {	\
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

