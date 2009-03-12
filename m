From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 12 Mar 2009 07:31:45 +0000
Subject: [PATCH] sh: Add support DMA Engine to SH7780
Message-Id: <49B8BA61.4000608@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <49B8BA5D.1000300@renesas.com>
In-Reply-To: <49B8BA5D.1000300@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index 6f7227c..272c3c3 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -12,6 +12,7 @@
 #include <linux/serial.h>
 #include <linux/io.h>
 #include <linux/serial_sci.h>
+#include <asm/dma-sh.h>

 static struct resource rtc_resources[] = {
 	[0] = {
@@ -57,9 +58,23 @@ static struct platform_device sci_device = {
 	},
 };

+static struct sh_dmae_pdata dma_platform_data = {
+        .mode = (SHDMA_MIX_IRQ|SHDMA_DMAOR1),
+};
+
+static struct platform_device dma_device = {
+        .name           = "sh-dma-engine",
+        .id             = -1,
+        .dev            = {
+                .platform_data  = &dma_platform_data,
+        },
+};
+
+
 static struct platform_device *sh7780_devices[] __initdata = {
 	&rtc_device,
 	&sci_device,
+	&dma_device,
 };

 static int __init sh7780_devices_setup(void)
-- 
1.6.2

