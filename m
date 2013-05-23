From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 23 May 2013 03:24:04 +0000
Subject: [PATCH 17/17 v2] ARM: shmobile: r8a7778: rename sdhi device additional function
Message-Id: <87obc22xbi.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Other device additional function are r8a7778_add_xxx_device()
sdhi also follow it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - r8a7778_sdhi_init() was out of naming rule

 arch/arm/mach-shmobile/board-bockw.c          |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 2f51e8b..b8e8d9f 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -211,7 +211,7 @@ static void __init bockw_init(void)
 		iowrite32(ioread32(base + PUPR4) | (3 << 26), base + PUPR4);
 		iounmap(base);
 
-		r8a7778_sdhi_init(0, &sdhi0_info);
+		r8a7778_add_sdhi_device(0, &sdhi0_info);
 	}
 }
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index fcf3c90..3fcbb771 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -28,6 +28,7 @@ extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_mmc_device(struct sh_mmcif_plat_data *info);
+extern void r8a7778_add_sdhi_device(int id, struct sh_mobile_sdhi_info *info);
 
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
@@ -35,6 +36,5 @@ extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
-extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 3e128c3..749d886 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -162,7 +162,7 @@ static struct resource sdhi_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x76)),
 };
 
-void __init r8a7778_sdhi_init(int id,
+void __init r8a7778_add_sdhi_device(int id,
 			      struct sh_mobile_sdhi_info *info)
 {
 	BUG_ON(id < 0 || id > 2);
-- 
1.7.9.5

