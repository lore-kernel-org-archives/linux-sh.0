From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 07 Aug 2013 16:19:55 +0000
Subject: [PATCH 3/5] ARM: shmobile: r8a7790: Add DU and LVDS support
Message-Id: <1375892397-5822-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a function to register the DU device with board-specific platform
data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7790.h |  3 +++
 arch/arm/mach-shmobile/setup-r8a7790.c        | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7790.h b/arch/arm/mach-shmobile/include/mach/r8a7790.h
index 788d559..5ffa8ce 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7790.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7790.h
@@ -1,8 +1,11 @@
 #ifndef __ASM_R8A7790_H__
 #define __ASM_R8A7790_H__
 
+struct rcar_du_platform_data;
+
 void r8a7790_add_standard_devices(void);
 void r8a7790_add_dt_devices(void);
+void r8a7790_add_du_device(struct rcar_du_platform_data *pdata);
 void r8a7790_clock_init(void);
 void r8a7790_pinmux_init(void);
 void r8a7790_init_delay(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index d0f5c9f..d1c22d2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -19,10 +19,12 @@
  */
 
 #include <linux/clocksource.h>
+#include <linux/dma-mapping.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/platform_data/gpio-rcar.h>
+#include <linux/platform_data/rcar-du.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <linux/serial_sci.h>
 #include <linux/sh_timer.h>
@@ -75,6 +77,31 @@ void __init r8a7790_pinmux_init(void)
 	r8a7790_register_gpio(5);
 }
 
+/* DU */
+static const struct resource du_resources[] = {
+	DEFINE_RES_MEM(0xfeb00000, 0x70000),
+	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
+	DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
+	DEFINE_RES_IRQ(gic_spi(256)),
+	DEFINE_RES_IRQ(gic_spi(268)),
+	DEFINE_RES_IRQ(gic_spi(269)),
+};
+
+void __init r8a7790_add_du_device(struct rcar_du_platform_data *pdata)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7790",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = pdata,
+		.size_data = sizeof(*pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
 	.type		= scif_type,				\
 	.mapbase	= baseaddr,				\
-- 
1.8.1.5

