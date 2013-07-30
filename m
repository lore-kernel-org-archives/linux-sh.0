From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Jul 2013 07:02:24 +0000
Subject: [PATCH 2/2 v3] ARM: shmobile: r8a7778: cleanup registration of hspi
Message-Id: <87a9l4edj6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh-hspi driver which doesn't need platform data at the time of
registration can be registerd on SoC.
And, registering these drivers in the SoC code can avoid
unwanted device numbering issue.
(ex. the hspi2 device number will be spi.0 if hspi2 only registered)
This patch registers it on SoC code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - based on 1/2 patch

 arch/arm/mach-shmobile/board-bockw.c          |    1 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |    5 ++++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 12b7396..07009f5 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -206,7 +206,6 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_ether_device(&ether_platform_data);
-	r8a7778_add_hspi_device(0);
 
 	i2c_register_board_info(0, i2c0_devices,
 				ARRAY_SIZE(i2c0_devices));
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 9874511..41fd6da 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -23,7 +23,6 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
-extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_dt_devices(void);
 
 extern void r8a7778_init_late(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index ce3b54d..1a154d4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -272,7 +272,7 @@ static struct resource hspi_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x75)),
 };
 
-void __init r8a7778_add_hspi_device(int id)
+void __init r8a7778_register_hspi(int id)
 {
 	BUG_ON(id < 0 || id > 2);
 
@@ -312,6 +312,9 @@ void __init r8a7778_add_standard_devices(void)
 	r8a7778_register_i2c(1);
 	r8a7778_register_i2c(2);
 	r8a7778_register_i2c(3);
+	r8a7778_register_hspi(0);
+	r8a7778_register_hspi(1);
+	r8a7778_register_hspi(2);
 }
 
 void __init r8a7778_init_late(void)
-- 
1.7.9.5

