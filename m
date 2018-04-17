From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Tue, 17 Apr 2018 14:13:13 +0000
Subject: [PATCH] sh: migor: Set DMA and DMA coherent mask
Message-Id: <1523974393-10870-1-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

As of commit 205e1b7f51e4 ("dma-mapping: warn when there is no
coherent_dma_mask") the Migo-R platform devices registered without a DMA
mask and coherent DMA mask issue the following warning

WARNING: CPU: 0 PID: 1 at ./include/linux/dma-mapping.h:516 0x40159e20

Set dma mask and coherent DMA mask for Migo-R platforms devices to 32
bits as all other SH4a platforms do.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 6b3a26e..3fe1ea7 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -7,6 +7,7 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  */
+#include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/platform_device.h>
@@ -347,6 +348,8 @@ static struct platform_device vpu_device = {
 	.name		= "uio_pdrv_genirq",
 	.id		= 0,
 	.dev = {
+		.dma_mask		= &vpu_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data	= &vpu_platform_data,
 	},
 	.resource	= vpu_resources,
@@ -375,6 +378,8 @@ static struct platform_device veu_device = {
 	.name		= "uio_pdrv_genirq",
 	.id		= 1,
 	.dev = {
+		.dma_mask		= &veu_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data	= &veu_platform_data,
 	},
 	.resource	= veu_resources,
@@ -403,6 +408,8 @@ static struct platform_device jpu_device = {
 	.name		= "uio_pdrv_genirq",
 	.id		= 2,
 	.dev = {
+		.dma_mask		= &jpu_device.dev.coherent_dma_mask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
 		.platform_data	= &jpu_platform_data,
 	},
 	.resource	= jpu_resources,
--
2.7.4

