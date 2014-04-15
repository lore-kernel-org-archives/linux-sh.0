From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 15 Apr 2014 12:34:09 +0000
Subject: [PATCH RFC v2 13/17] ARM: shmobile: r7s72100: Populate .init_machine for generic r7s72100
Message-Id: <1397565253-22741-14-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 arch/arm/mach-shmobile/board-genmai-reference.c |   15 +--------------
 arch/arm/mach-shmobile/include/mach/r7s72100.h  |    1 +
 arch/arm/mach-shmobile/setup-r7s72100.c         |   14 ++++++++++++++
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-genmai-reference.c b/arch/arm/mach-shmobile/board-genmai-reference.c
index fea8fc0a3683..2eaeadfd3a5d 100644
--- a/arch/arm/mach-shmobile/board-genmai-reference.c
+++ b/arch/arm/mach-shmobile/board-genmai-reference.c
@@ -18,7 +18,6 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <linux/clk-provider.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
@@ -26,18 +25,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-static void __init genmai_add_standard_devices(void)
-{
-	sh_pm_runtime_init();
-#ifdef CONFIG_COMMON_CLK
-	of_clk_init(NULL);
-#else
-	r7s72100_clock_init();
-#endif
-	r7s72100_add_dt_devices();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
-
 static const char * const genmai_boards_compat_dt[] __initconst = {
 	"renesas,genmai-reference",
 	NULL,
@@ -45,6 +32,6 @@ static const char * const genmai_boards_compat_dt[] __initconst = {
 
 DT_MACHINE_START(GENMAI_DT, "genmai")
 	.init_early	= r7s72100_init_early,
-	.init_machine	= genmai_add_standard_devices,
+	.init_machine	= r7s72100_add_standard_devices_dt,
 	.dt_compat	= genmai_boards_compat_dt,
 MACHINE_END
diff --git a/arch/arm/mach-shmobile/include/mach/r7s72100.h b/arch/arm/mach-shmobile/include/mach/r7s72100.h
index 5f34b20ecd4a..ba8c5ca8ae60 100644
--- a/arch/arm/mach-shmobile/include/mach/r7s72100.h
+++ b/arch/arm/mach-shmobile/include/mach/r7s72100.h
@@ -2,6 +2,7 @@
 #define __ASM_R7S72100_H__
 
 void r7s72100_add_dt_devices(void);
+void r7s72100_add_standard_devices_dt(void);
 void r7s72100_clock_init(void);
 void r7s72100_init_early(void);
 
diff --git a/arch/arm/mach-shmobile/setup-r7s72100.c b/arch/arm/mach-shmobile/setup-r7s72100.c
index 9c0b3a9d5f7a..3dc7c591e739 100644
--- a/arch/arm/mach-shmobile/setup-r7s72100.c
+++ b/arch/arm/mach-shmobile/setup-r7s72100.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk-provider.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
@@ -100,6 +101,18 @@ void __init r7s72100_init_early(void)
 }
 
 #ifdef CONFIG_USE_OF
+void __init r7s72100_add_standard_devices_dt(void)
+{
+	sh_pm_runtime_init();
+#ifdef CONFIG_COMMON_CLK
+	of_clk_init(NULL);
+#else
+	r7s72100_clock_init();
+#endif
+	r7s72100_add_dt_devices();
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+}
+
 static const char *r7s72100_boards_compat_dt[] __initdata = {
 	"renesas,r7s72100",
 	NULL,
@@ -107,6 +120,7 @@ static const char *r7s72100_boards_compat_dt[] __initdata = {
 
 DT_MACHINE_START(R7S72100_DT, "Generic R7S72100 (Flattened Device Tree)")
 	.init_early	= r7s72100_init_early,
+	.init_machine	= r7s72100_add_standard_devices_dt,
 	.dt_compat	= r7s72100_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
1.7.9.5

