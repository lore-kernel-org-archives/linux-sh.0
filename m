From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:16:41 +0000
Subject: [PATCH 06/08] sh: Convert sh7724, Ecovec, se7724 and kfr2r09 to mem_init
Message-Id: <20110106101641.1617.59827.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7724 to use shmobile_memchunk_setup().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ecovec24/setup.c   |   10 ++++++++--
 arch/sh/boards/mach-kfr2r09/setup.c    |    9 +++++++--
 arch/sh/boards/mach-se/7724/setup.c    |   10 ++++++++--
 arch/sh/include/cpu-sh4/cpu/sh7724.h   |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   18 +++++++++++-------
 5 files changed, 36 insertions(+), 13 deletions(-)

--- 0001/arch/sh/boards/mach-ecovec24/setup.c
+++ work/arch/sh/boards/mach-ecovec24/setup.c	2011-01-06 16:54:22.000000000 +0900
@@ -1126,7 +1126,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_VIO0_CLK, NULL);
 	gpio_request(GPIO_FN_VIO0_FLD, NULL);
 	gpio_request(GPIO_FN_VIO0_HD,  NULL);
-	platform_resource_setup_memory(&ceu0_device, "ceu0", 4 << 20);
 
 	/* enable CEU1 */
 	gpio_request(GPIO_FN_VIO1_D7,  NULL);
@@ -1141,7 +1140,6 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_VIO1_HD,  NULL);
 	gpio_request(GPIO_FN_VIO1_VD,  NULL);
 	gpio_request(GPIO_FN_VIO1_CLK, NULL);
-	platform_resource_setup_memory(&ceu1_device, "ceu1", 4 << 20);
 
 	/* enable KEYSC */
 	gpio_request(GPIO_FN_KEYOUT5_IN5, NULL);
@@ -1336,6 +1334,14 @@ static int __init devices_setup(void)
 }
 device_initcall(devices_setup);
 
+static void __init ecovec_mem_init(void)
+{
+	sh7724_mem_init();
+	shmobile_memchunk_setup(&ceu0_device, "ceu0", 4 << 20);
+	shmobile_memchunk_setup(&ceu1_device, "ceu1", 4 << 20);
+}
+
 static struct sh_machine_vector mv_ecovec __initmv = {
 	.mv_name	= "R0P7724 (EcoVec)",
+	.mv_mem_init	= ecovec_mem_init,
 };
--- 0001/arch/sh/boards/mach-kfr2r09/setup.c
+++ work/arch/sh/boards/mach-kfr2r09/setup.c	2011-01-06 16:54:52.000000000 +0900
@@ -611,8 +611,6 @@ static int __init kfr2r09_devices_setup(
 	gpio_request(GPIO_FN_VIO0_D1, NULL);
 	gpio_request(GPIO_FN_VIO0_D0, NULL);
 
-	platform_resource_setup_memory(&kfr2r09_ceu_device, "ceu", 4 << 20);
-
 	/* SDHI0 connected to yc304 */
 	gpio_request(GPIO_FN_SDHI0CD, NULL);
 	gpio_request(GPIO_FN_SDHI0D3, NULL);
@@ -638,10 +636,17 @@ static int kfr2r09_mode_pins(void)
 	return MODE_PIN0 | MODE_PIN1 | MODE_PIN5 | MODE_PIN8;
 }
 
+static void __init kfr2r09_mem_init(void)
+{
+	sh7724_mem_init();
+	shmobile_memchunk_setup(&kfr2r09_ceu_device, "ceu", 4 << 20);
+}
+
 /*
  * The Machine Vector
  */
 static struct sh_machine_vector mv_kfr2r09 __initmv = {
 	.mv_name		= "kfr2r09",
 	.mv_mode_pins		= kfr2r09_mode_pins,
+	.mv_mem_init		= kfr2r09_mem_init,
 };
--- 0001/arch/sh/boards/mach-se/7724/setup.c
+++ work/arch/sh/boards/mach-se/7724/setup.c	2011-01-06 16:54:41.000000000 +0900
@@ -796,7 +796,6 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_VIO0_CLK, NULL);
 	gpio_request(GPIO_FN_VIO0_FLD, NULL);
 	gpio_request(GPIO_FN_VIO0_HD,  NULL);
-	platform_resource_setup_memory(&ceu0_device, "ceu0", 4 << 20);
 
 	/* enable CEU1 */
 	gpio_request(GPIO_FN_VIO1_D7,  NULL);
@@ -811,7 +810,6 @@ static int __init devices_setup(void)
 	gpio_request(GPIO_FN_VIO1_HD,  NULL);
 	gpio_request(GPIO_FN_VIO1_VD,  NULL);
 	gpio_request(GPIO_FN_VIO1_CLK, NULL);
-	platform_resource_setup_memory(&ceu1_device, "ceu1", 4 << 20);
 
 	/* KEYSC */
 	gpio_request(GPIO_FN_KEYOUT5_IN5, NULL);
@@ -938,8 +936,16 @@ static int __init devices_setup(void)
 }
 device_initcall(devices_setup);
 
+static void __init ms7724se_mem_init(void)
+{
+	sh7724_mem_init();
+	shmobile_memchunk_setup(&ceu0_device, "ceu0", 4 << 20);
+	shmobile_memchunk_setup(&ceu1_device, "ceu1", 4 << 20);
+}
+
 static struct sh_machine_vector mv_ms7724se __initmv = {
 	.mv_name	= "ms7724se",
 	.mv_init_irq	= init_se7724_IRQ,
 	.mv_nr_irqs	= SE7724_FPGA_IRQ_BASE + SE7724_FPGA_IRQ_NR,
+	.mv_mem_init	= ms7724se_mem_init,
 };
--- 0001/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7724.h	2011-01-06 16:48:49.000000000 +0900
@@ -306,4 +306,6 @@ enum {
 extern struct clk sh7724_fsimcka_clk;
 extern struct clk sh7724_fsimckb_clk;
 
+void sh7724_mem_init(void);
+
 #endif /* __ASM_SH7724_H__ */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7724.c	2011-01-06 16:54:24.000000000 +0900
@@ -930,13 +930,6 @@ static struct platform_device *sh7724_de
 
 static int __init sh7724_devices_setup(void)
 {
-	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
-	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
-	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
-	platform_resource_setup_memory(&jpu_device,  "jpu",  2 << 20);
-	platform_resource_setup_memory(&spu0_device, "spu0", 2 << 20);
-	platform_resource_setup_memory(&spu1_device, "spu1", 2 << 20);
-
 	return platform_add_devices(sh7724_devices,
 				    ARRAY_SIZE(sh7724_devices));
 }
@@ -964,6 +957,17 @@ void __init plat_early_device_setup(void
 				   ARRAY_SIZE(sh7724_early_devices));
 }
 
+void __init sh7724_mem_init(void)
+{
+	generic_mem_init();
+	shmobile_memchunk_setup(&vpu_device, "vpu", 2 << 20);
+	shmobile_memchunk_setup(&veu0_device, "veu0", 2 << 20);
+	shmobile_memchunk_setup(&veu1_device, "veu1", 2 << 20);
+	shmobile_memchunk_setup(&jpu_device,  "jpu",  2 << 20);
+	shmobile_memchunk_setup(&spu0_device, "spu0", 2 << 20);
+	shmobile_memchunk_setup(&spu1_device, "spu1", 2 << 20);
+}
+
 #define RAMCR_CACHE_L2FC	0x0002
 #define RAMCR_CACHE_L2E		0x0001
 #define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
