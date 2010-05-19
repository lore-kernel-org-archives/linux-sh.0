From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 19 May 2010 18:34:39 +0000
Subject: [PATCH 10/10 v2] SH: Add SDHI DMA support to migor
Message-Id: <Pine.LNX.4.64.1005191810490.3099@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1005191750400.3099@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, dan.j.williams@intel.com, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, sameo@linux.intel.com, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
asm/dmaengine.h is now gone.

 arch/sh/boards/mach-migor/setup.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/mach-migor/setup.c b/arch/sh/boards/mach-migor/setup.c
index 7da0fc9..87185de 100644
--- a/arch/sh/boards/mach-migor/setup.c
+++ b/arch/sh/boards/mach-migor/setup.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/input.h>
 #include <linux/input/sh_keysc.h>
+#include <linux/mfd/sh_mobile_sdhi.h>
 #include <linux/mtd/physmap.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c.h>
@@ -402,10 +403,18 @@ static struct resource sdhi_cn9_resources[] = {
 	},
 };
 
+static struct sh_mobile_sdhi_info sh7724_sdhi_data = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
+};
+
 static struct platform_device sdhi_cn9_device = {
 	.name		= "sh_mobile_sdhi",
 	.num_resources	= ARRAY_SIZE(sdhi_cn9_resources),
 	.resource	= sdhi_cn9_resources,
+	.dev = {
+		.platform_data	= &sh7724_sdhi_data,
+	},
 	.archdata = {
 		.hwblk_id = HWBLK_SDHI,
 	},
-- 
1.6.2.4

