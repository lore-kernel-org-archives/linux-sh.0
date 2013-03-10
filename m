From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Mar 2013 18:58:47 +0000
Subject: [PATCH/RFC 11/12] ARM: shmobile: r8a7779: Register GPIO devices
Message-Id: <1362941928-18115-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Move GPIOs handling from the PFC device to separate GPIO devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 58 ++++++++++++++++++++++++++++++----
 1 file changed, 52 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index c54ff9b..1580605 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -66,11 +67,6 @@ static struct resource r8a7779_pfc_resources[] = {
 		.end	= 0xfffc023b,
 		.flags	= IORESOURCE_MEM,
 	},
-	[1] = {
-		.start	= 0xffc40000,
-		.end	= 0xffc46fff,
-		.flags	= IORESOURCE_MEM,
-	}
 };
 
 static struct platform_device r8a7779_pfc_device = {
@@ -80,9 +76,59 @@ static struct platform_device r8a7779_pfc_device = {
 	.num_resources	= ARRAY_SIZE(r8a7779_pfc_resources),
 };
 
+#define R8A7779_GPIO(idx, npins) \
+static struct resource r8a7779_gpio##idx##_resources[] = {		\
+	[0] = {								\
+		.start	= 0xffc40000 + 0x1000 * (idx),			\
+		.end	= 0xffc4002b + 0x1000 * (idx),			\
+		.flags	= IORESOURCE_MEM,				\
+	},								\
+	[1] = {								\
+		.start	= gic_spi(141 + (idx)),				\
+		.flags	= IORESOURCE_IRQ,				\
+	}								\
+};									\
+									\
+static struct gpio_rcar_config r8a7779_gpio##idx##_platform_data = {	\
+	.gpio_base	= 32 * (idx),					\
+	.irq_base	= 0,						\
+	.number_of_pins	= npins,					\
+	.pctl_name	= "pfc-r8a7779",				\
+};									\
+									\
+static struct platform_device r8a7779_gpio##idx##_device = {		\
+	.name		= "gpio_rcar",					\
+	.id		= idx,						\
+	.resource	= r8a7779_gpio##idx##_resources,		\
+	.num_resources	= ARRAY_SIZE(r8a7779_gpio##idx##_resources),	\
+	.dev		= {						\
+		.platform_data	= &r8a7779_gpio##idx##_platform_data,	\
+	},								\
+}
+
+R8A7779_GPIO(0, 32);
+R8A7779_GPIO(1, 32);
+R8A7779_GPIO(2, 32);
+R8A7779_GPIO(3, 32);
+R8A7779_GPIO(4, 32);
+R8A7779_GPIO(5, 32);
+R8A7779_GPIO(6, 9);
+
+static struct platform_device *r8a7779_pinctrl_devices[] __initdata = {
+	&r8a7779_pfc_device,
+	&r8a7779_gpio0_device,
+	&r8a7779_gpio1_device,
+	&r8a7779_gpio2_device,
+	&r8a7779_gpio3_device,
+	&r8a7779_gpio4_device,
+	&r8a7779_gpio5_device,
+	&r8a7779_gpio6_device,
+};
+
 void __init r8a7779_pinmux_init(void)
 {
-	platform_device_register(&r8a7779_pfc_device);
+	platform_add_devices(r8a7779_pinctrl_devices,
+			    ARRAY_SIZE(r8a7779_pinctrl_devices));
 }
 
 static struct plat_sci_port scif0_platform_data = {
-- 
1.8.1.5

