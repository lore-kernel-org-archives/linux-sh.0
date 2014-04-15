From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:13 +0000
Subject: [PATCH RFC v2 17/17] ARM: shmobile: r8a7791: Populate .init_machine for generic r8a7791
Message-Id: <1397565253-22741-18-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/include/mach/r8a7791.h |    1 +
 arch/arm/mach-shmobile/setup-r8a7791.c        |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7791.h b/arch/arm/mach-shmobile/include/mach/r8a7791.h
index 200fa699f730..cb0bb74ee290 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7791.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7791.h
@@ -2,6 +2,7 @@
 #define __ASM_R8A7791_H__
 
 void r8a7791_add_standard_devices(void);
+void r8a7791_add_standard_devices_dt(void);
 void r8a7791_add_dt_devices(void);
 void r8a7791_clock_init(void);
 void r8a7791_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index a7e4966f5e18..74271c622475 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -218,6 +218,13 @@ void __init r8a7791_init_early(void)
 }
 
 #ifdef CONFIG_USE_OF
+void __init r8a7791_add_standard_devices_dt(void)
+{
+	sh_pm_runtime_init();
+	r8a7791_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static const char *r8a7791_boards_compat_dt[] __initdata = {
 	"renesas,r8a7791",
 	NULL,
@@ -227,6 +234,7 @@ DT_MACHINE_START(R8A7791_DT, "Generic R8A7791 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7791_smp_ops),
 	.init_early	= r8a7791_init_early,
 	.init_time	= rcar_gen2_timer_init,
+	.init_machine	= r8a7791_add_standard_devices_dt,
 	.dt_compat	= r8a7791_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.7.9.5

