From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:16:33 +0000
Subject: [PATCH 05/08] sh: Convert sh7723 and AP325RXA to mem_init
Message-Id: <20110106101633.1617.20476.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Convert sh7723 to use shmobile_memchunk_setup().

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boards/mach-ap325rxa/setup.c   |    9 +++++++--
 arch/sh/include/cpu-sh4/cpu/sh7723.h   |    2 ++
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   12 ++++++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

--- 0001/arch/sh/boards/mach-ap325rxa/setup.c
+++ work/arch/sh/boards/mach-ap325rxa/setup.c	2011-01-06 18:16:26.000000000 +0900
@@ -621,8 +621,6 @@ static int __init ap325rxa_devices_setup
 	__raw_writew(0xFFFF, PORT_DRVCRA);
 	__raw_writew(0xFFFF, PORT_DRVCRB);
 
-	platform_resource_setup_memory(&ceu_device, "ceu", 4 << 20);
-
 	/* SDHI0 - CN3 - SD CARD */
 	gpio_request(GPIO_FN_SDHI0CD_PTD, NULL);
 	gpio_request(GPIO_FN_SDHI0WP_PTD, NULL);
@@ -661,7 +659,14 @@ static int ap325rxa_mode_pins(void)
 	return MODE_PIN5 | MODE_PIN8;
 }
 
+static void __init ap325rxa_mem_init(void)
+{
+	sh7723_mem_init();
+	shmobile_memchunk_setup(&ceu_device, "ceu", 4 << 20);
+}
+
 static struct sh_machine_vector mv_ap325rxa __initmv = {
 	.mv_name = "AP-325RXA",
 	.mv_mode_pins = ap325rxa_mode_pins,
+	.mv_mem_init = ap325rxa_mem_init,
 };
--- 0001/arch/sh/include/cpu-sh4/cpu/sh7723.h
+++ work/arch/sh/include/cpu-sh4/cpu/sh7723.h	2011-01-06 18:16:57.000000000 +0900
@@ -282,4 +282,6 @@ enum {
 	HWBLK_NR,
 };
 
+void sh7723_mem_init(void);
+
 #endif /* __ASM_SH7723_H__ */
--- 0001/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2011-01-06 18:17:58.000000000 +0900
@@ -531,10 +531,6 @@ static struct platform_device *sh7723_de
 
 static int __init sh7723_devices_setup(void)
 {
-	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
-	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
-	platform_resource_setup_memory(&veu1_device, "veu1", 2 << 20);
-
 	return platform_add_devices(sh7723_devices,
 				    ARRAY_SIZE(sh7723_devices));
 }
@@ -562,6 +558,14 @@ void __init plat_early_device_setup(void
 				   ARRAY_SIZE(sh7723_early_devices));
 }
 
+void __init sh7723_mem_init(void)
+{
+	generic_mem_init();
+	shmobile_memchunk_setup(&vpu_device, "vpu", 2 << 20);
+	shmobile_memchunk_setup(&veu0_device, "veu0", 2 << 20);
+	shmobile_memchunk_setup(&veu1_device, "veu1", 2 << 20);
+}
+
 #define RAMCR_CACHE_L2FC	0x0002
 #define RAMCR_CACHE_L2E		0x0001
 #define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
