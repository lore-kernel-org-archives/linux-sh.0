From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 27 May 2013 01:41:08 +0000
Subject: [PATCH 1/2 v3] ARM: shmobile: r8a7778: rename device additional function for sh-eth
Message-Id: <87fvx98aj2.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current r8a7778 is using r8a7778_add_ether_device().
Here, this "ether" means "sh-eth".

Now, we use r8a7778_register_xxx() instead of r8a7778_add_xxx_device()

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

  - new added

 arch/arm/mach-shmobile/include/mach/r8a7778.h |    4 +++-
 arch/arm/mach-shmobile/setup-r8a7778.c        |    2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index ae65b45..695cd76 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -23,7 +23,7 @@
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
-extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
+
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
@@ -32,4 +32,6 @@ extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
 extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
 
+extern void r8a7778_register_sheth(struct sh_eth_plat_data *pdata);
+
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 9191acc..9bff1e1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -95,7 +95,7 @@ static struct resource ether_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x89)),
 };
 
-void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
+void __init r8a7778_register_sheth(struct sh_eth_plat_data *pdata)
 {
 	platform_device_register_resndata(&platform_bus, "sh-eth", -1,
 					  ether_resources,
-- 
1.7.9.5

