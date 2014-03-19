From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Mar 2014 19:06:49 +0000
Subject: [PATCH 4/5] ARM: shmobile: Call sh_pm_runtime_init() from platform code on all SoCs
Message-Id: <1395256010-12222-5-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Explicitly call sh_pm_runtime_init() from shmobile platform code on all
shmobile SoCs, to make sure the bus clocks are enabled for all devices.

On ARCH_SHMOBILE_LEGACY, this duplicates the work done in the existing
core_initcall() in drivers/sh/pm_runtime.c, which will be removed later.
On ARCH_SHMOBILE_MULTI, this was missing, leading to disabled clocks,
depending on implicit reset state or on the bootloader.

The call to sh_pm_runtime_init() is made from .machine_init(), which is
called from an arch_initcall(), i.e. after the old core_initcall().
On SoCs supporting power domains (sh7372, r8a7740, and r8a7779), the call
is still done before initializing the power domains, to preserve order.

This was based on a patch from Ben Dooks for r8a7790.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/include/mach/common.h |    2 ++
 arch/arm/mach-shmobile/setup-emev2.c         |    1 +
 arch/arm/mach-shmobile/setup-r7s72100.c      |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c       |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c       |    3 +++
 arch/arm/mach-shmobile/setup-r8a7778.c       |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c       |    3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c       |    1 +
 arch/arm/mach-shmobile/setup-r8a7791.c       |    1 +
 arch/arm/mach-shmobile/setup-sh7372.c        |    3 +++
 arch/arm/mach-shmobile/setup-sh73a0.c        |    2 ++
 11 files changed, 19 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index f7a360edcc35..21c2d391045d 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -53,4 +53,6 @@ static inline void __init shmobile_init_late(void)
 	shmobile_cpuidle_init();
 }
 
+extern int sh_pm_runtime_init(void);
+
 #endif /* __ARCH_MACH_COMMON_H */
diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index d953ff6e78a2..4c6334513e5a 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -49,6 +49,7 @@ static void __init emev2_init_delay(void)
 
 static void __init emev2_add_standard_devices_dt(void)
 {
+	sh_pm_runtime_init();
 	of_clk_init(NULL);
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 9c0b3a9d5f7a..81bae06795d6 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -83,6 +83,7 @@ static struct resource mtu2_0_resources[] __initdata = {
 
 void __init r7s72100_add_dt_devices(void)
 {
+	sh_pm_runtime_init();
 	r7s72100_register_scif(0);
 	r7s72100_register_scif(1);
 	r7s72100_register_scif(2);
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index cd36f8078325..d396027ce666 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -190,6 +190,7 @@ static struct resource cmt10_resources[] = {
 
 void __init r8a73a4_add_dt_devices(void)
 {
+	sh_pm_runtime_init();
 	r8a73a4_register_scif(0);
 	r8a73a4_register_scif(1);
 	r8a73a4_register_scif(2);
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 8f3c68101d59..b30f967db3cc 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -828,6 +828,8 @@ static void r8a7740_i2c_workaround(struct platform_device *pdev)
 
 void __init r8a7740_add_standard_devices(void)
 {
+	sh_pm_runtime_init();
+
 	/* I2C work-around */
 	r8a7740_i2c_workaround(&i2c0_device);
 	r8a7740_i2c_workaround(&i2c1_device);
@@ -882,6 +884,7 @@ void __init r8a7740_add_early_devices_dt(void)
 
 void __init r8a7740_add_standard_devices_dt(void)
 {
+	sh_pm_runtime_init();
 	platform_add_devices(r8a7740_devices_dt,
 			    ARRAY_SIZE(r8a7740_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 6d694526e4ca..af8c8372ccd3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -305,6 +305,7 @@ void __init r8a7778_add_dt_devices(void)
 	}
 #endif
 
+	sh_pm_runtime_init();
 	r8a7778_register_scif(0);
 	r8a7778_register_scif(1);
 	r8a7778_register_scif(2);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 8e860b36997a..414c0a69e95e 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -705,6 +705,8 @@ void __init r8a7779_add_standard_devices(void)
 #endif
 	r8a7779_pm_init();
 
+	sh_pm_runtime_init();
+
 	r8a7779_init_pm_domains();
 
 	platform_add_devices(r8a7779_devices_dt,
@@ -797,6 +799,7 @@ void __init r8a7779_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	r8a7779_clock_init();
 
+	sh_pm_runtime_init();
 	platform_add_devices(r8a7779_devices_dt,
 			     ARRAY_SIZE(r8a7779_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index a901d9ef53f6..f7463c358183 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -284,6 +284,7 @@ static const struct resource cmt00_resources[] __initconst = {
 
 void __init r8a7790_add_dt_devices(void)
 {
+	sh_pm_runtime_init();
 	r8a7790_register_scif(0);
 	r8a7790_register_scif(1);
 	r8a7790_register_scif(2);
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index a7e4966f5e18..03145c804f50 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -185,6 +185,7 @@ static const struct resource thermal_resources[] __initconst = {
 
 void __init r8a7791_add_dt_devices(void)
 {
+	sh_pm_runtime_init();
 	r8a7791_register_scif(0);
 	r8a7791_register_scif(1);
 	r8a7791_register_scif(2);
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 27301278c208..c8e38fbcab2c 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1004,6 +1004,8 @@ void __init sh7372_add_standard_devices(void)
 		{ "A4R", &tmu01_device, },
 	};
 
+	sh_pm_runtime_init();
+
 	sh7372_init_pm_domains();
 
 	platform_add_devices(sh7372_early_devices,
@@ -1049,6 +1051,7 @@ void __init sh7372_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh7372_clock_init();
 
+	sh_pm_runtime_init();
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index f74ab530c71d..928909b0edca 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -777,6 +777,7 @@ void __init sh73a0_add_standard_devices(void)
 	/* Clear software reset bit on SY-DMAC module */
 	__raw_writel(__raw_readl(SRCR2) & ~(1 << 18), SRCR2);
 
+	sh_pm_runtime_init();
 	platform_add_devices(sh73a0_devices_dt,
 			    ARRAY_SIZE(sh73a0_devices_dt));
 	platform_add_devices(sh73a0_early_devices,
@@ -821,6 +822,7 @@ void __init sh73a0_add_standard_devices_dt(void)
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
+	sh_pm_runtime_init();
 	platform_add_devices(sh73a0_devices_dt,
 			     ARRAY_SIZE(sh73a0_devices_dt));
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.9.5

