From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 04 Dec 2009 18:45:13 +0000
Subject: [PATCH 5/5] sh: dmaengine support for sh7724
Message-Id: <Pine.LNX.4.64.0912041942330.3981@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0912041936541.3981@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Add a dmaengine platform device to sh7724, fix DMA channel interrupt numbers.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

With this patch dmatest works with channels 0-5, channels 6-11 still don't 
work for some reason... So, feel free to discard it for now, if a complete 
fix would be preferred.

 arch/sh/include/cpu-sh4/cpu/dma-sh4a.h |    8 ++++----
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   14 ++++++++++++++
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
index f0886bc..c4ed660 100644
--- a/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
+++ b/arch/sh/include/cpu-sh4/cpu/dma-sh4a.h
@@ -19,10 +19,10 @@
 #elif defined(CONFIG_CPU_SUBTYPE_SH7723) || \
       defined(CONFIG_CPU_SUBTYPE_SH7724)
 #define DMTE0_IRQ	48	/* DMAC0A*/
-#define DMTE4_IRQ	40	/* DMAC0B */
-#define DMTE6_IRQ	42
-#define DMTE8_IRQ	76	/* DMAC1A */
-#define DMTE9_IRQ	77
+#define DMTE4_IRQ	76	/* DMAC0B */
+#define DMTE6_IRQ	40
+#define DMTE8_IRQ	42	/* DMAC1A */
+#define DMTE9_IRQ	43
 #define DMTE10_IRQ	72	/* DMAC1B */
 #define DMTE11_IRQ	73
 #define DMAE0_IRQ	78	/* DMA Error IRQ*/
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 6dc4469..da55a4e 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -23,9 +23,22 @@
 #include <linux/notifier.h>
 #include <asm/suspend.h>
 #include <asm/clock.h>
+#include <asm/dma-sh.h>
 #include <asm/mmzone.h>
 #include <cpu/sh7724.h>
 
+static struct sh_dmae_pdata dma_platform_data = {
+	.mode = SHDMA_DMAOR1,
+};
+
+static struct platform_device dma_device = {
+	.name		= "sh-dma-engine",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
 /* Serial */
 static struct plat_sci_port sci_platform_data[] = {
 	{
@@ -533,6 +546,7 @@ static struct platform_device *sh7724_devices[] __initdata = {
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
+	&dma_device,
 	&sci_device,
 	&rtc_device,
 	&iic0_device,
-- 
1.6.2.4

