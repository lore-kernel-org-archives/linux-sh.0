From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Nov 2013 03:15:50 +0000
Subject: [PATCH v2 3/8] ARM: shmobile: lager-reference: Switch to multiplaform
Message-Id: <1384053355-30703-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move the Lager reference board to multiplaform ARM architecture. As
multiplatform requires usage of the common clock framework, switch from
legacy clocks to CCF by replacing the legacy clock framework
initialization code in the machine init handler with a common clock
framework initialization call in the time init handler.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/Makefile                     |  3 ++-
 arch/arm/mach-shmobile/Kconfig                 |  7 +++++++
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/board-lager-reference.c | 11 +++++++++--
 4 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 7d98d3a..eea1304 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -214,7 +214,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
-dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
+	r8a7790-lager-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index b31ceda..3887f0e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -24,6 +24,9 @@ comment "SH-Mobile System Type"
 config ARCH_EMEV2
 	bool "Emma Mobile EV2"
 
+config ARCH_R8A7790
+	bool "R-Car H2 (R8A77900)"
+
 comment "SH-Mobile Board Type"
 
 config MACH_KZM9D
@@ -31,6 +34,10 @@ config MACH_KZM9D
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+config MACH_LAGER
+	bool "Lager board"
+	depends on ARCH_R8A7790
+
 comment "SH-Mobile System Configuration"
 endif
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index cc48f14..32f3975 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -57,6 +57,7 @@ obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 # Board objects
 ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
+obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 7df9ea0..dfb7437 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -18,15 +18,22 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk/shmobile.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <mach/rcar-gen2.h>
 #include <mach/r8a7790.h>
 #include <asm/mach/arch.h>
 
+static void __init lager_init_time(void)
+{
+	rcar_gen2_clocks_init(rcar_gen2_read_mode_pins());
+
+	rcar_gen2_timer_init();
+}
+
 static void __init lager_add_standard_devices(void)
 {
-	r8a7790_clock_init();
 	r8a7790_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
@@ -39,7 +46,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(LAGER_DT, "lager")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= r8a7790_init_early,
-	.init_time	= rcar_gen2_timer_init,
+	.init_time	= lager_init_time,
 	.init_machine	= lager_add_standard_devices,
 	.dt_compat	= lager_boards_compat_dt,
 MACHINE_END
-- 
1.8.1.5

