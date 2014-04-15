From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:04 +0000
Subject: [PATCH v2 08/17] ARM: shmobile: Call sh_pm_runtime_init() from platform code on all SoCs
Message-Id: <1397565253-22741-9-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Explicitly call sh_pm_runtime_init() from shmobile platform code on all
shmobile SoCs, to make sure the bus clocks are enabled for all devices.

On ARCH_SHMOBILE_LEGACY, this duplicates the work done in the existing
core_initcall() in drivers/sh/pm_runtime.c, which will be removed later.
On ARCH_SHMOBILE_MULTI, this was missing, leading to disabled clocks,
depending on implicit reset state or on the bootloader.

The call to sh_pm_runtime_init() is made early from .machine_init(), which
is called from an arch_initcall(), i.e. a bit later than the old
core_initcall(). It is still done before any platform devices are added.

This was based on a patch from Ben Dooks for r8a7790.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com> [r8a7779 legacy]
---
v2:
  - Add Reviewed-by, Tested-by
  - Moved the call to sh_pm_runtime_init() to the start of .machine_init(),
    to enable the GPIO clocks on R-Car Gen2.

 arch/arm/mach-shmobile/board-ape6evm-reference.c   |    2 +-
 arch/arm/mach-shmobile/board-ape6evm.c             |    2 +-
 .../board-armadillo800eva-reference.c              |    1 +
 arch/arm/mach-shmobile/board-armadillo800eva.c     |    1 +
 arch/arm/mach-shmobile/board-bockw-reference.c     |    1 +
 arch/arm/mach-shmobile/board-bockw.c               |    1 +
 arch/arm/mach-shmobile/board-genmai-reference.c    |    1 +
 arch/arm/mach-shmobile/board-genmai.c              |    1 +
 arch/arm/mach-shmobile/board-koelsch-reference.c   |    1 +
 arch/arm/mach-shmobile/board-koelsch.c             |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c               |    1 +
 arch/arm/mach-shmobile/board-lager-reference.c     |    1 +
 arch/arm/mach-shmobile/board-lager.c               |    1 +
 arch/arm/mach-shmobile/board-mackerel.c            |    1 +
 arch/arm/mach-shmobile/board-marzen.c              |    1 +
 arch/arm/mach-shmobile/include/mach/common.h       |    2 ++
 arch/arm/mach-shmobile/setup-emev2.c               |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c             |    1 +
 arch/arm/mach-shmobile/setup-r8a7779.c             |    2 ++
 arch/arm/mach-shmobile/setup-sh7372.c              |    2 ++
 arch/arm/mach-shmobile/setup-sh73a0.c              |    2 ++
 21 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 3276afcf3cc9..c355a16e7d01 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -31,10 +31,10 @@
 
 static void __init ape6evm_add_standard_devices(void)
 {
-
 	struct clk *parent;
 	struct clk *mp;
 
+	sh_pm_runtime_init();
 	r8a73a4_clock_init();
 
 	/* MP clock parent = extal2 */
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index fe071a9130b7..8d65b81b30c2 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -223,10 +223,10 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] __initconst = {
 
 static void __init ape6evm_add_standard_devices(void)
 {
-
 	struct clk *parent;
 	struct clk *mp;
 
+	sh_pm_runtime_init();
 	r8a73a4_clock_init();
 
 	/* MP clock parent = extal2 */
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
index 57d1a78367b6..a01aa9207772 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva-reference.c
@@ -158,6 +158,7 @@ clock_error:
  */
 static void __init eva_init(void)
 {
+	sh_pm_runtime_init();
 	r8a7740_clock_init(MD_CK0 | MD_CK2);
 	eva_clock_init();
 
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 486063db2a2f..276d713f0ee9 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1200,6 +1200,7 @@ static void __init eva_init(void)
 {
 	struct platform_device *usb = NULL;
 
+	sh_pm_runtime_init();
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 	regulator_register_always_on(3, "fixed-5.0V", fixed5v0_power_consumers,
diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 027373f8de82..c1ed9ee19196 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -38,6 +38,7 @@ static void __init bockw_init(void)
 	void __iomem *fpga;
 	void __iomem *pfc;
 
+	sh_pm_runtime_init();
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin_dt(1);
 	r8a7778_add_dt_devices();
diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index f444be2f241e..1b19ee407c6d 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -611,6 +611,7 @@ static void __init bockw_init(void)
 	struct platform_device *pdev;
 	int i;
 
+	sh_pm_runtime_init();
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin(1);
 	r8a7778_add_standard_devices();
diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index 7630c1053e32..fea8fc0a3683 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -28,6 +28,7 @@
 
 static void __init genmai_add_standard_devices(void)
 {
+	sh_pm_runtime_init();
 #ifdef CONFIG_COMMON_CLK
 	of_clk_init(NULL);
 #else
diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
index 6c328d63b819..9a3fbe6ae809 100644
--- a/arch/arm/mach-shmobile/board-genmai.c
+++ b/arch/arm/mach-shmobile/board-genmai.c
@@ -91,6 +91,7 @@ static const struct spi_board_info spi_info[] __initconst = {
 
 static void __init genmai_add_standard_devices(void)
 {
+	sh_pm_runtime_init();
 	r7s72100_clock_init();
 	r7s72100_add_dt_devices();
 
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 941f8b394e84..12e2c4c1b2ef 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -123,6 +123,7 @@ static const struct clk_name clk_enables[] __initconst = {
 
 static void __init koelsch_add_standard_devices(void)
 {
+	sh_pm_runtime_init();
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7791_add_dt_devices();
diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 7f32f5d02d38..4c3c160b79d5 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -540,6 +540,7 @@ static int koelsch_ksz8041_fixup(struct phy_device *phydev)
 
 static void __init koelsch_init(void)
 {
+	sh_pm_runtime_init();
 	koelsch_add_standard_devices();
 
 	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 03dc3ac84502..de683ab1e829 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -857,6 +857,7 @@ static const struct pinctrl_map kzm_pinctrl_map[] = {
 
 static void __init kzm_init(void)
 {
+	sh_pm_runtime_init();
 	regulator_register_always_on(2, "fixed-1.8V", fixed1v8_power_consumers,
 				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
 	regulator_register_fixed(3, dummy_supplies, ARRAY_SIZE(dummy_supplies));
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1eb48cffb4c5..0af38a9c390e 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -123,6 +123,7 @@ static const struct clk_name clk_enables[] __initconst = {
 
 static void __init lager_add_standard_devices(void)
 {
+	sh_pm_runtime_init();
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	shmobile_clk_workaround(clk_enables, ARRAY_SIZE(clk_enables), true);
 	r8a7790_add_dt_devices();
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index a7c82ecf1e48..8a1065173c20 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -904,6 +904,7 @@ static int lager_ksz8041_fixup(struct phy_device *phydev)
 
 static void __init lager_init(void)
 {
+	sh_pm_runtime_init();
 	lager_add_standard_devices();
 
 	irq_set_irq_type(irq_pin(0), IRQ_TYPE_LEVEL_LOW);
diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 0ff4d8e45cf7..93be9d21001e 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -1436,6 +1436,7 @@ static void __init mackerel_init(void)
 	u32 srcr4;
 	struct clk *clk;
 
+	sh_pm_runtime_init();
 	regulator_register_always_on(0, "fixed-1.8V", fixed1v8_power_consumers,
 				     ARRAY_SIZE(fixed1v8_power_consumers), 1800000);
 	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index d832a4477b4b..d18b6b08369b 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -375,6 +375,7 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 
 static void __init marzen_init(void)
 {
+	sh_pm_runtime_init();
 	regulator_register_always_on(0, "fixed-3.3V", fixed3v3_power_consumers,
 				ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
 	regulator_register_fixed(1, dummy_supplies,
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
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index a177a7b3bdbd..1bb68fcb1132 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -913,6 +913,7 @@ void __init r8a7740_init_irq_of(void)
 
 static void __init r8a7740_generic_init(void)
 {
+	sh_pm_runtime_init();
 	r8a7740_clock_init(0);
 	r8a7740_add_standard_devices_dt();
 }
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 8e860b36997a..9b26e9264b94 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -794,6 +794,8 @@ void __init r8a7779_init_delay(void)
 
 void __init r8a7779_add_standard_devices_dt(void)
 {
+	sh_pm_runtime_init();
+
 	/* clocks are setup late during boot in the case of DT */
 	r8a7779_clock_init();
 
diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index f8176b051be4..7ebe9fccbafc 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1042,6 +1042,8 @@ void __init sh7372_add_early_devices_dt(void)
 
 void __init sh7372_add_standard_devices_dt(void)
 {
+	sh_pm_runtime_init();
+
 	/* clocks are setup late during boot in the case of DT */
 	sh7372_clock_init();
 
diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index f74ab530c71d..9b193eaa4a2d 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -818,6 +818,8 @@ void __init sh73a0_add_standard_devices_dt(void)
 {
 	struct platform_device_info devinfo = { .name = "cpufreq-cpu0", .id = -1, };
 
+	sh_pm_runtime_init();
+
 	/* clocks are setup late during boot in the case of DT */
 	sh73a0_clock_init();
 
-- 
1.7.9.5

