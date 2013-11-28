From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:03:42 +0000
Subject: [PATCH v3 05/15] ARM: shmobile: lager-reference: Switch to multiplaform
Message-Id: <1385600632-5181-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/boot/dts/Makefile                     |  1 +
 arch/arm/mach-shmobile/Kconfig                 |  8 ++++++++
 arch/arm/mach-shmobile/Makefile                |  1 +
 arch/arm/mach-shmobile/board-lager-reference.c | 11 +++++++++--
 4 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 33c6054..74e4186 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -236,6 +236,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
+	r8a7790-lager-reference.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index bc8108b..53bd009 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -27,6 +27,10 @@ config ARCH_EMEV2
 config ARCH_R7S72100
 	bool "RZ/A1H (R7S72100)"
 
+config ARCH_R8A7790
+	bool "R-Car H2 (R8A77900)"
+	select RENESAS_IRQC
+
 config ARCH_R8A7791
 	bool "R-Car M2 (R8A77910)"
 	select RENESAS_IRQC
@@ -46,6 +50,10 @@ config MACH_KZM9D
 	depends on ARCH_EMEV2
 	select REGULATOR_FIXED_VOLTAGE if REGULATOR
 
+config MACH_LAGER
+	bool "Lager board"
+	depends on ARCH_R8A7790
+
 comment "SH-Mobile System Configuration"
 endif
 
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index 1c13104..9daa9c1 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -59,6 +59,7 @@ ifdef CONFIG_ARCH_SHMOBILE_MULTI
 obj-$(CONFIG_MACH_GENMAI)	+= board-genmai-reference.o
 obj-$(CONFIG_MACH_KOELSCH)	+= board-koelsch-reference.o
 obj-$(CONFIG_MACH_KZM9D)	+= board-kzm9d-reference.o
+obj-$(CONFIG_MACH_LAGER)	+= board-lager-reference.o
 else
 obj-$(CONFIG_MACH_APE6EVM)	+= board-ape6evm.o
 obj-$(CONFIG_MACH_APE6EVM_REFERENCE)	+= board-ape6evm-reference.o
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 51a3bcc..396ef28 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -18,6 +18,7 @@
  * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/clk/shmobile.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
 #include <mach/common.h>
@@ -25,9 +26,15 @@
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
@@ -40,7 +47,7 @@ static const char *lager_boards_compat_dt[] __initdata = {
 DT_MACHINE_START(LAGER_DT, "lager")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= r8a7790_init_early,
-	.init_time	= rcar_gen2_timer_init,
+	.init_time	= lager_init_time,
 	.init_machine	= lager_add_standard_devices,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= lager_boards_compat_dt,
-- 
1.8.3.2

