From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 17 Dec 2009 03:15:57 +0000
Subject: [PATCH]: sh: dmaengine support for SH7785
Message-Id: <29ab51dc0912161915p55672faxd2790b69ed59ba7d@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add dmaengine platform device to SH7785.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index ef26ebd..f685b9b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -14,6 +14,7 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 #include <linux/sh_timer.h>
+#include <asm/dma-sh.h>
 #include <asm/mmzone.h>

 static struct plat_sci_port scif0_platform_data = {
@@ -294,6 +295,18 @@ static struct platform_device tmu5_device = {
 	.num_resources	= ARRAY_SIZE(tmu5_resources),
 };

+static struct sh_dmae_pdata dma_platform_data = {
+	.mode = (SHDMA_MIX_IRQ | SHDMA_DMAOR1),
+};
+
+static struct platform_device dma_device = {
+	.name           = "sh-dma-engine",
+	.id             = -1,
+	.dev            = {
+		.platform_data  = &dma_platform_data,
+	},
+};
+
 static struct platform_device *sh7785_devices[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -307,6 +320,7 @@ static struct platform_device *sh7785_devices[]
__initdata = {
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
+	&dma_device,
 };

 static int __init sh7785_devices_setup(void)
-- 
1.6.5.4
