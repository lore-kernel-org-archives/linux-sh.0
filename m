From: Tetsuyuki Kobayshi <koba@kmckk.co.jp>
Date: Wed, 05 Sep 2012 02:48:37 +0000
Subject: [PATCH 2/2] ARM: shmobile: emev2: enable PMU(Performance Monitoring Unit)
Message-Id: <1346813317-4030-3-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

This patch enables PMU(Performance Monitoring Unit) for emev2 when compiled with CONFIG_HW_PERF_EVENTS.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/setup-emev2.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index dae9aa6..f3ff171 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -36,6 +36,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/time.h>
 #include <asm/hardware/gic.h>
+#include <asm/pmu.h>
 
 static struct map_desc emev2_io_desc[] __initdata = {
 #ifdef CONFIG_SMP
@@ -356,6 +357,28 @@ static struct platform_device gio4_device = {
 	},
 };
 
+#ifdef CONFIG_HW_PERF_EVENTS
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start	= 152,
+		.end	= 152,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start	= 153,
+		.end	= 153,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pmu_device = {
+	.name		= "arm-pmu",
+	.id		= ARM_PMU_DEVICE_CPU,
+	.num_resources	= ARRAY_SIZE(pmu_resources),
+	.resource	= pmu_resources,
+};
+#endif
+
 static struct platform_device *emev2_early_devices[] __initdata = {
 	&uart0_device,
 	&uart1_device,
@@ -370,6 +393,9 @@ static struct platform_device *emev2_late_devices[] __initdata = {
 	&gio2_device,
 	&gio3_device,
 	&gio4_device,
+#ifdef CONFIG_HW_PERF_EVENTS
+	&pmu_device,
+#endif
 };
 
 void __init emev2_add_standard_devices(void)
-- 
1.7.9.5

