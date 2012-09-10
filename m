From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Date: Mon, 10 Sep 2012 10:30:55 +0000
Subject: [RFC PATCH 2/2] ARM: shmobile: sh7372: Change VPU UIO to uio_dmem_genirq
Message-Id: <1347273055-10311-3-git-send-email-dhobsong@igel.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This allows the VPU memory to be allocated dynamically only when it
is needed.

Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
---
 arch/arm/mach-shmobile/setup-sh7372.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 1106b4f..fe75701 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/platform_data/uio_dmem_genirq.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
 #include <linux/uio_driver.h>
@@ -761,11 +762,19 @@ static struct platform_device usb_dma1_device = {
 	},
 };
 
+static unsigned int region_sizes[] = {
+	(32 << 20),
+};
+
 /* VPU */
-static struct uio_info vpu_platform_data = {
-	.name = "VPU5HG",
-	.version = "0",
-	.irq = intcs_evt2irq(0x980),
+static struct uio_dmem_genirq_pdata vpu_platform_data = {
+	.uioinfo = {
+		.name = "VPU5HG",
+		.version = "0",
+		.irq = intcs_evt2irq(0x980),
+	},
+	.dynamic_region_sizes	= region_sizes,
+	.num_dynamic_regions	= ARRAY_SIZE(region_sizes),
 };
 
 static struct resource vpu_resources[] = {
@@ -778,7 +787,7 @@ static struct resource vpu_resources[] = {
 };
 
 static struct platform_device vpu_device = {
-	.name		= "uio_pdrv_genirq",
+	.name		= "uio_dmem_genirq",
 	.id		= 0,
 	.dev = {
 		.platform_data	= &vpu_platform_data,
-- 
1.7.5.4

