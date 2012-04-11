From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 11 Apr 2012 03:57:31 +0000
Subject: [PATCH 1/6] ARM: mach-shmobile: add KZM-A9-GT board support
Message-Id: <87d37e3opk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds very basic KZM-A9-GT board (SH73a0) support

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/Kconfig       |    5 +++
 arch/arm/mach-shmobile/Makefile      |    1 +
 arch/arm/mach-shmobile/board-kzm9g.c |   60 ++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-shmobile/board-kzm9g.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 34560ca..c39413a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -98,6 +98,11 @@ config MACH_MARZEN
 	depends on ARCH_R8A7779
 	select ARCH_REQUIRE_GPIOLIB
 
+config MACH_KZM9G
+	bool "KZM-A9-GT board"
+	depends on ARCH_SH73A0
+	select ARCH_REQUIRE_GPIOLIB
+
 comment "SH-Mobile System Configuration"
 
 config CPU_HAS_INTEVT
diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index e7c2590..015c2d4 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
 obj-$(CONFIG_MACH_KOTA2)	+= board-kota2.o
 obj-$(CONFIG_MACH_BONITO)	+= board-bonito.o
 obj-$(CONFIG_MACH_MARZEN)	+= board-marzen.o
+obj-$(CONFIG_MACH_KZM9G)	+= board-kzm9g.o
 
 # Framework support
 obj-$(CONFIG_SMP)		+= $(smp-y)
diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
new file mode 100644
index 0000000..55dad87
--- /dev/null
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -0,0 +1,60 @@
+/*
+ * KZM-A9-GT board support
+ *
+ * Copyright (C) 2012	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <mach/sh73a0.h>
+#include <mach/common.h>
+#include <asm/hardware/cache-l2x0.h>
+#include <asm/hardware/gic.h>
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+
+static struct platform_device *kzm_devices[] __initdata = {
+};
+
+static void __init kzm_init(void)
+{
+	sh73a0_pinmux_init();
+
+	/* enable SCIFA4 */
+	gpio_request(GPIO_FN_SCIFA4_TXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RXD, NULL);
+	gpio_request(GPIO_FN_SCIFA4_RTS_, NULL);
+	gpio_request(GPIO_FN_SCIFA4_CTS_, NULL);
+
+#ifdef CONFIG_CACHE_L2X0
+	/* Early BRESP enable, Shared attribute override enable, 64K*8way */
+	l2x0_init(IOMEM(0xf0100000), 0x40460000, 0x82000fff);
+#endif
+
+	sh73a0_add_standard_devices();
+	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
+}
+
+MACHINE_START(KZM9G, "kzm9g")
+	.map_io		= sh73a0_map_io,
+	.init_early	= sh73a0_add_early_devices,
+	.nr_irqs	= NR_IRQS_LEGACY,
+	.init_irq	= sh73a0_init_irq,
+	.handle_irq	= gic_handle_irq,
+	.init_machine	= kzm_init,
+	.timer		= &shmobile_timer,
+MACHINE_END
-- 
1.7.5.4

