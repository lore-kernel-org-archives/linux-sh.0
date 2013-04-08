From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 08 Apr 2013 09:36:17 +0000
Subject: [PATCH 05/10] ARM: shmobile: r8a7790: Register GPIO devices
Message-Id: <1365413782-17036-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move GPIOs handling from the PFC device to separate GPIO devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 49de2d5..eeef5f6 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -23,6 +23,7 @@
 #include <linux/kernel.h>
 #include <linux/of_platform.h>
 #include <linux/serial_sci.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-irqc.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
@@ -31,13 +32,45 @@
 
 static const struct resource pfc_resources[] = {
 	DEFINE_RES_MEM(0xe6060000, 0x250),
-	DEFINE_RES_MEM(0xe6050000, 0x5050),
 };
 
+#define R8A7790_GPIO(idx)						\
+static struct resource r8a7790_gpio##idx##_resources[] = {		\
+	DEFINE_RES_MEM(0xe6050000 + 0x1000 * (idx), 0x50),		\
+	DEFINE_RES_IRQ(gic_spi(4 + (idx))),				\
+};									\
+									\
+static struct gpio_rcar_config r8a7790_gpio##idx##_platform_data = {	\
+	.gpio_base	= 32 * (idx),					\
+	.irq_base	= 0,						\
+	.number_of_pins	= 32,						\
+	.pctl_name	= "pfc-r8a7790",				\
+};									\
+
+R8A7790_GPIO(0);
+R8A7790_GPIO(1);
+R8A7790_GPIO(2);
+R8A7790_GPIO(3);
+R8A7790_GPIO(4);
+R8A7790_GPIO(5);
+
+#define r8a7790_register_gpio(idx)					\
+	platform_device_register_resndata(&platform_bus, "gpio_rcar", idx, \
+		r8a7790_gpio##idx##_resources,				\
+		ARRAY_SIZE(r8a7790_gpio##idx##_resources),		\
+		&r8a7790_gpio##idx##_platform_data,			\
+		sizeof(r8a7790_gpio##idx##_platform_data))
+
 void __init r8a7790_pinmux_init(void)
 {
 	platform_device_register_simple("pfc-r8a7790", -1, pfc_resources,
 					ARRAY_SIZE(pfc_resources));
+	r8a7790_register_gpio(0);
+	r8a7790_register_gpio(1);
+	r8a7790_register_gpio(2);
+	r8a7790_register_gpio(3);
+	r8a7790_register_gpio(4);
+	r8a7790_register_gpio(5);
 }
 
 #define SCIF_COMMON(scif_type, baseaddr, irq)			\
-- 
1.8.1.5

