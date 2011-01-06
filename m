From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 06 Jan 2011 10:41:09 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7377 Enable SDIO IRQs
Message-Id: <20110106104109.7697.96086.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch enables interrupt generation for SDIO IRQs
of the SDHI block on the sh7377 aka G4 processor. Use
together with a recent SDHI driver using TMIO_MMC_SDIO_IRQ
and with the MMC_CAP_SDIO_IRQ flag in the board code.

The G4EVM specific SDHI platform data is also updated to
flag SDIO capabilities.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-g4evm.c |   15 +++++++++++++++
 arch/arm/mach-shmobile/intc-sh7377.c |    4 ++--
 2 files changed, 17 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-g4evm.c
+++ work/arch/arm/mach-shmobile/board-g4evm.c	2011-01-06 19:32:29.000000000 +0900
@@ -30,6 +30,7 @@
 #include <linux/io.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/mmc/host.h>
 #include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/gpio.h>
 #include <mach/sh7377.h>
@@ -196,6 +197,10 @@ static struct platform_device keysc_devi
 };
 
 /* SDHI */
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.tmio_caps	= MMC_CAP_SDIO_IRQ,
+};
+
 static struct resource sdhi0_resources[] = {
 	[0] = {
 		.name	= "SDHI0",
@@ -214,6 +219,13 @@ static struct platform_device sdhi0_devi
 	.num_resources  = ARRAY_SIZE(sdhi0_resources),
 	.resource       = sdhi0_resources,
 	.id             = 0,
+	.dev	= {
+		.platform_data	= &sdhi0_info,
+	},
+};
+
+static struct sh_mobile_sdhi_info sdhi1_info = {
+	.tmio_caps	= MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
 };
 
 static struct resource sdhi1_resources[] = {
@@ -234,6 +246,9 @@ static struct platform_device sdhi1_devi
 	.num_resources  = ARRAY_SIZE(sdhi1_resources),
 	.resource       = sdhi1_resources,
 	.id             = 1,
+	.dev	= {
+		.platform_data	= &sdhi1_info,
+	},
 };
 
 static struct platform_device *g4evm_devices[] __initdata = {
--- 0001/arch/arm/mach-shmobile/intc-sh7377.c
+++ work/arch/arm/mach-shmobile/intc-sh7377.c	2011-01-06 19:28:07.000000000 +0900
@@ -234,10 +234,10 @@ static struct intc_mask_reg intca_mask_r
 	  { SCIFB, SCIFA5, SCIFA4, MSIOF1,
 	    0, 0, MSIOF2, 0 } },
 	{ 0xe694009c, 0xe69400dc, 8, /* IMR7A / IMCR7A */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { DISABLED, ENABLED, ENABLED, ENABLED,
 	    FLCTL_FLTREQ1I, FLCTL_FLTREQ0I, FLCTL_FLTENDI, FLCTL_FLSTEI } },
 	{ 0xe69400a0, 0xe69400e0, 8, /* IMR8A / IMCR8A */
-	  { DISABLED, DISABLED, ENABLED, ENABLED,
+	  { DISABLED, ENABLED, ENABLED, ENABLED,
 	    TTI20, USBDMAC_USHDMI, 0, MSUG } },
 	{ 0xe69400a4, 0xe69400e4, 8, /* IMR9A / IMCR9A */
 	  { CMT1_CMT13, CMT1_CMT12, CMT1_CMT11, CMT1_CMT10,
