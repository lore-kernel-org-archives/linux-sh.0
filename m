From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:12 +0000
Subject: [PATCH RFC v2 16/17] ARM: shmobile: r8a7790: Populate .init_machine for generic r8a7790
Message-Id: <1397565253-22741-17-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/include/mach/r8a7790.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7790.c        |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 0b95babe84ba..92d6ecf0e290 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -29,6 +29,7 @@ enum {
 };
 
 void r8a7790_add_standard_devices(void);
+void r8a7790_add_standard_devices_dt(void);
 void r8a7790_add_dt_devices(void);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index a901d9ef53f6..ad7777674269 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -318,6 +318,12 @@ void __init r8a7790_init_early(void)
 }
 
 #ifdef CONFIG_USE_OF
+void __init r8a7790_add_standard_devices_dt(void)
+{
+	sh_pm_runtime_init();
+	r8a7790_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
 
 static const char * const r8a7790_boards_compat_dt[] __initconst = {
 	"renesas,r8a7790",
@@ -328,6 +334,7 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= r8a7790_init_early,
 	.init_time	= rcar_gen2_timer_init,
+	.init_machine	= r8a7790_add_standard_devices_dt,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.7.9.5

