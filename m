From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:32:09 +0000
Subject: [PATCH 04/11] ARM: shmobile: r8a7778: cleanup registration of sdhi
Message-Id: <87hag1fqey.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_mobile_sdhi driver which needs platform data at the time of
registration is used from BockW only.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed in the future.
The driver registration method which needs platform data
and which is not shared complicates codes.
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw.c          |   11 ++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    3 ---
 arch/arm/mach-shmobile/setup-r8a7778.c        |   24 ------------------------
 3 files changed, 10 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 12341f3..b274415 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -20,6 +20,7 @@
 
 #include <linux/mfd/tmio.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mmc/sh_mmcif.h>
 #include <linux/mtd/partitions.h>
 #include <linux/pinctrl/machine.h>
@@ -86,6 +87,11 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
+static struct resource sdhi0_resources[] __initdata = {
+	DEFINE_RES_MEM(0xFFE4C000, 0x100),
+	DEFINE_RES_IRQ(gic_iid(0x77)),
+};
+
 /* Ether */
 static struct resource ether_resources[] __initdata = {
 	DEFINE_RES_MEM(0xfde00000, 0x400),
@@ -265,7 +271,10 @@ static void __init bockw_init(void)
 		iowrite32(ioread32(base + PUPR4) | (3 << 26), base + PUPR4);
 		iounmap(base);
 
-		r8a7778_sdhi_init(0, &sdhi0_info);
+		platform_device_register_resndata(
+			&platform_bus, "sh_mobile_sdhi", 0,
+			sdhi0_resources, ARRAY_SIZE(sdhi0_resources),
+			&sdhi0_info, sizeof(struct sh_mobile_sdhi_info));
 	}
 }
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 57a58dd..3e8f4d6 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -18,8 +18,6 @@
 #ifndef __ASM_R8A7778_H__
 #define __ASM_R8A7778_H__
 
-#include <linux/mmc/sh_mobile_sdhi.h>
-
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_i2c_device(int id);
@@ -31,6 +29,5 @@ extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
-extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index b2e4c37..67c3567 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -220,30 +220,6 @@ void __init r8a7778_pinmux_init(void)
 	r8a7778_register_gpio(4);
 };
 
-/* SDHI */
-static struct resource sdhi_resources[] __initdata = {
-	/* SDHI0 */
-	DEFINE_RES_MEM(0xFFE4C000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x77)),
-	/* SDHI1 */
-	DEFINE_RES_MEM(0xFFE4D000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x78)),
-	/* SDHI2 */
-	DEFINE_RES_MEM(0xFFE4F000, 0x100),
-	DEFINE_RES_IRQ(gic_iid(0x76)),
-};
-
-void __init r8a7778_sdhi_init(int id,
-			      struct sh_mobile_sdhi_info *info)
-{
-	BUG_ON(id < 0 || id > 2);
-
-	platform_device_register_resndata(
-		&platform_bus, "sh_mobile_sdhi", id,
-		sdhi_resources + (2 * id), 2,
-		info, sizeof(*info));
-}
-
 /* I2C */
 static struct resource i2c_resources[] __initdata = {
 	/* I2C0 */
-- 
1.7.9.5

