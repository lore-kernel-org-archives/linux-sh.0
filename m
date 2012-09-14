From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Fri, 14 Sep 2012 04:27:13 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: Enable PMU
Message-Id: <1347596833-19064-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables PMU for r8a7740.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/configs/armadillo800eva_defconfig |    1 +
 arch/arm/mach-shmobile/setup-r8a7740.c     |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
index 62861bd..d952f62 100644
--- a/arch/arm/configs/armadillo800eva_defconfig
+++ b/arch/arm/configs/armadillo800eva_defconfig
@@ -7,6 +7,7 @@ CONFIG_LOG_BUF_SHIFT
 # CONFIG_IPC_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_PERF_EVENTS=y
 CONFIG_SLAB=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 78948a9..d3d6295 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -590,6 +590,21 @@ static struct platform_device i2c1_device = {
 	.num_resources	= ARRAY_SIZE(i2c1_resources),
 };
 
+static struct resource pmu_resources[] = {
+	[0] = {
+		.start	= evt2irq(0x19a0),
+		.end	= evt2irq(0x19a0),
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device pmu_device = {
+	.name	= "arm-pmu",
+	.id		= -1,
+	.num_resources = ARRAY_SIZE(pmu_resources),
+	.resource = pmu_resources,
+};
+
 static struct platform_device *r8a7740_late_devices[] __initdata = {
 	&i2c0_device,
 	&i2c1_device,
@@ -597,6 +612,7 @@ static struct platform_device *r8a7740_late_devices[] __initdata = {
 	&dma1_device,
 	&dma2_device,
 	&usb_dma_device,
+	&pmu_device,
 };
 
 /*
-- 
1.7.10.4

