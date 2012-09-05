From: Tetsuyuki Kobayshi <koba@kmckk.co.jp>
Date: Wed, 05 Sep 2012 02:48:36 +0000
Subject: [PATCH 1/2] ARM: shmobile: sh73a0: enable PMU(Performance Monitoring Unit)
Message-Id: <1346813317-4030-2-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

This patch enables PMU(Performance Monitoring Unit) for sh73a0 when compiled with CONFIG_HW_PERF_EVENTS.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |   26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index d230af6..1c96d53 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -39,6 +39,7 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/time.h>
+#include <asm/pmu.h>
 
 static struct map_desc sh73a0_io_desc[] __initdata = {
 	/* create a 1:1 entity map for 0xe6xxxxxx
@@ -734,6 +735,28 @@ static struct platform_device mpdma0_device = {
 	},
 };
 
+#ifdef CONFIG_HW_PERF_EVENTS
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start	= gic_spi(55),
+		.end	= gic_spi(55),
+		.flags	= IORESOURCE_IRQ,
+	},
+	[1] = {
+		.start	= gic_spi(56),
+		.end	= gic_spi(56),
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
 static struct platform_device *sh73a0_early_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -757,6 +780,9 @@ static struct platform_device *sh73a0_late_devices[] __initdata = {
 	&i2c4_device,
 	&dma0_device,
 	&mpdma0_device,
+#ifdef CONFIG_HW_PERF_EVENTS
+	&pmu_device,
+#endif
 };
 
 #define SRCR2          0xe61580b0
-- 
1.7.9.5

