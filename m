From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:16:24 +0000
Subject: [PATCH 04/08] sh: Convert sh7722, Migo-R and se7722 to mem_init
Message-Id: <20110106101624.1617.15198.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7722 to use shmobile_memchunk_setup().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-migor/setup.c      |    9 +++++++--
 arch/sh/boards/mach-se/7722/setup.c    |    1 +
 arch/sh/include/cpu-sh4/cpu/sh7722.h   |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   12 ++++++++----
 4 files changed, 18 insertions(+), 6 deletions(-)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2011-01-06 18:04:30.000000000 +0900
@@ -631,8 +631,6 @@ static int __init migor_devices_setup(vo
 #endif
 	__raw_writew(__raw_readw(PORT_MSELCRB) | 0x2000, PORT_MSELCRB); /* D15->D8 */
 
-	platform_resource_setup_memory(&migor_ceu_device, "ceu", 4 << 20);
-
 	/* SIU: Port B */
 	gpio_request(GPIO_FN_SIUBOLR, NULL);
 	gpio_request(GPIO_FN_SIUBOBT, NULL);
@@ -664,10 +662,17 @@ static int migor_mode_pins(void)
 	return MODE_PIN0 | MODE_PIN1 | MODE_PIN5;
 }
 
+static void __init migor_mem_init(void)
+{
+	sh7722_mem_init();
+	shmobile_memchunk_setup(&migor_ceu_device, "ceu", 4 << 20);
+}
+
 /*
  * The Machine Vector
  */
 static struct sh_machine_vector mv_migor __initmv = {
 	.mv_name		= "Migo-R",
 	.mv_mode_pins		= migor_mode_pins,
+	.mv_mem_init		= migor_mem_init,
 };
--- 0001/arch/sh/boards/mach-se/7722/setup.c
+++ work/arch/sh/boards/mach-se/7722/setup.c	2011-01-06 18:07:20.000000000 +0900
@@ -191,4 +191,5 @@ static struct sh_machine_vector mv_se772
 	.mv_name                = "Solution Engine 7722" ,
 	.mv_setup               = se7722_setup ,
 	.mv_init_irq		= init_se7722_IRQ,
+	.mv_mem_init		= sh7722_mem_init,
 };
--- 0001/arch/sh/include/cpu-sh4/cpu/sh7722.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7722.h	2011-01-06 18:04:58.000000000 +0900
@@ -250,4 +250,6 @@ enum {
 	SHDMA_SLAVE_SDHI0_RX,
 };
 
+void sh7722_mem_init(void);
+
 #endif /* __ASM_SH7722_H__ */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2011-01-06 18:06:26.000000000 +0900
@@ -583,10 +583,6 @@ static struct platform_device *sh7722_de
 
 static int __init sh7722_devices_setup(void)
 {
-	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
-	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
-	platform_resource_setup_memory(&jpu_device, "jpu", 2 << 20);
-
 	return platform_add_devices(sh7722_devices,
 				    ARRAY_SIZE(sh7722_devices));
 }
@@ -608,6 +604,14 @@ void __init plat_early_device_setup(void
 				   ARRAY_SIZE(sh7722_early_devices));
 }
 
+void __init sh7722_mem_init(void)
+{
+	generic_mem_init();
+	shmobile_memchunk_setup(&vpu_device, "vpu", 1 << 20);
+	shmobile_memchunk_setup(&veu_device, "veu", 2 << 20);
+	shmobile_memchunk_setup(&jpu_device, "jpu", 2 << 20);
+}
+
 enum {
 	UNUSED=0,
 	ENABLED,
