From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 26 Jul 2013 07:35:08 +0000
Subject: [PATCH 4/6 v2] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

i2c-rcar driver which doesn't need platform data at the time of
registration can be registerd on SoC.
And, registering these drivers in the SoC code can avoid
unwanted device numbering issue.
(ex. the i2c3 device number will be i2c.0 if i2c3 only registered)
This patch registers it on SoC code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2
 - based on renesas-devel-20130726
 - update git log

 arch/arm/mach-shmobile/board-bockw.c          |    1 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |    6 +++++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 1c876ab..d7d3427 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -200,7 +200,6 @@ static void __init bockw_init(void)
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
 	r8a7778_add_ether_device(&ether_platform_data);
-	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
 
 	i2c_register_board_info(0, i2c0_devices,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index aaa0544..9874511 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -23,7 +23,6 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
-extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 extern void r8a7778_add_dt_devices(void);
 
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index c585ee0..e975fcc1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -250,7 +250,7 @@ static struct resource i2c_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x6d)),
 };
 
-void __init r8a7778_add_i2c_device(int id)
+static void __init r8a7778_register_i2c(int id)
 {
 	BUG_ON(id < 0 || id > 3);
 
@@ -303,6 +303,10 @@ void __init r8a7778_add_dt_devices(void)
 
 	r8a7778_register_tmu(0);
 	r8a7778_register_tmu(1);
+	r8a7778_register_i2c(0);
+	r8a7778_register_i2c(1);
+	r8a7778_register_i2c(2);
+	r8a7778_register_i2c(3);
 }
 
 void __init r8a7778_add_standard_devices(void)
-- 
1.7.9.5

