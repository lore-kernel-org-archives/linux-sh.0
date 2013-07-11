From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:32:20 +0000
Subject: [PATCH 05/11] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <87fvvlfqen.wl%kuninori.morimoto.gx@renesas.com>
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
 arch/arm/mach-shmobile/board-bockw.c          |    1 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |    6 +++++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index b274415..9583314 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -205,7 +205,6 @@ static void __init bockw_init(void)
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
-	r8a7778_add_i2c_device(0);
 	r8a7778_add_hspi_device(0);
 
 	i2c_register_board_info(0, i2c0_devices,
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 3e8f4d6..d6d096d 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -20,7 +20,6 @@
 
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
-extern void r8a7778_add_i2c_device(int id);
 extern void r8a7778_add_hspi_device(int id);
 
 extern void r8a7778_init_late(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 67c3567..0f6edad 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -236,7 +236,7 @@ static struct resource i2c_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x6d)),
 };
 
-void __init r8a7778_add_i2c_device(int id)
+static void __init r8a7778_register_i2c(int id)
 {
 	BUG_ON(id < 0 || id > 3);
 
@@ -289,6 +289,10 @@ void __init r8a7778_add_standard_devices(void)
 
 	r8a7778_register_tmu(0);
 	r8a7778_register_tmu(1);
+	r8a7778_register_i2c(0);
+	r8a7778_register_i2c(1);
+	r8a7778_register_i2c(2);
+	r8a7778_register_i2c(3);
 }
 
 void __init r8a7778_init_late(void)
-- 
1.7.9.5

