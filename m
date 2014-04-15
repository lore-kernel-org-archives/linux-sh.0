From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:10 +0000
Subject: [PATCH RFC v2 14/17] ARM: shmobile: r8a73a4: Populate .init_machine for generic r8a73a4
Message-Id: <1397565253-22741-15-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/include/mach/r8a73a4.h |    1 +
 arch/arm/mach-shmobile/setup-r8a73a4.c        |    8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a73a4.h b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
index ce8bdd1d8a8a..c44a1b6d1fea 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a73a4.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a73a4.h
@@ -11,6 +11,7 @@ enum {
 };
 
 void r8a73a4_add_standard_devices(void);
+void r8a73a4_add_standard_devices_dt(void);
 void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index cd36f8078325..90414b069135 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -304,6 +304,13 @@ void __init r8a73a4_init_early(void)
 }
 
 #ifdef CONFIG_USE_OF
+void __init r8a73a4_add_standard_devices_dt(void)
+{
+	sh_pm_runtime_init();
+	r8a73a4_clock_init();
+	r8a73a4_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
 
 static const char *r8a73a4_boards_compat_dt[] __initdata = {
 	"renesas,r8a73a4",
@@ -312,6 +319,7 @@ static const char *r8a73a4_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R8A73A4_DT, "Generic R8A73A4 (Flattened Device Tree)")
 	.init_early	= r8a73a4_init_early,
+	.init_machine	= r8a73a4_add_standard_devices_dt,
 	.dt_compat	= r8a73a4_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.7.9.5

