From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Jun 2015 08:57:39 +0000
Subject: [PATCH v2 02/06] ARM: shmobile: r8a7779: Generic CCF and timer support
Message-Id: <20150625085739.24543.79535.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add a r8a7779-specific callback to initialize CCF and
clocksources. With this in place we are one step closer
to be able to use r8a7779 without C board code.

Also add a multiplatform wrapper to avoid breaking the
r8a7779 marzen legacy case.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Changes since V1:
 - Added multiplatform wrapper to build with legacy_defconfig

 arch/arm/mach-shmobile/setup-r8a7779.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-06-25 17:29:28.012366518 +0900
@@ -14,6 +14,8 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/clk/shmobile.h>
+#include <linux/clocksource.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -756,6 +758,14 @@ u32 __init r8a7779_read_mode_pins(void)
 	return mode;
 }
 
+#ifdef CONFIG_ARCH_SHMOBILE_MULTI
+
+static void __init r8a7779_init_time(void)
+{
+	r8a7779_clocks_init(r8a7779_read_mode_pins());
+	clocksource_of_init();
+}
+
 static const char *r8a7779_compat_dt[] __initdata = {
 	"renesas,r8a7779",
 	NULL,
@@ -764,8 +774,10 @@ static const char *r8a7779_compat_dt[] _
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
+	.init_time	= r8a7779_init_time,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7779_compat_dt,
 MACHINE_END
+#endif /* CONFIG_ARCH_SHMOBILE_MULTI */
 #endif /* CONFIG_USE_OF */
