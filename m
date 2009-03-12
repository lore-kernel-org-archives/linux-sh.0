From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Thu, 12 Mar 2009 07:31:41 +0000
Subject: [PATCH] sh: Add support DMA Engine to SH7722
Message-Id: <49B8BA5D.1000300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 0e5d204..c0949ae 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -16,6 +16,7 @@
 #include <linux/sh_cmt.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
+#include <asm/dma-sh.h>

 static struct resource rtc_resources[] = {
 	[0] = {
@@ -241,6 +242,18 @@ static struct platform_device sci_device = {
 	},
 };

+static struct sh_dmae_pdata dma_platform_data = {
+	.mode = 0,
+};
+
+static struct platform_device dma_device = {
+	.name       = "sh-dma-engine",
+	.id     = -1,
+	.dev        = {
+		.platform_data  = &dma_platform_data,
+	},
+};
+
 static struct platform_device *sh7722_devices[] __initdata = {
 	&cmt_device,
 	&rtc_device,
@@ -250,6 +263,7 @@ static struct platform_device *sh7722_devices[] __initdata = {
 	&vpu_device,
 	&veu_device,
 	&jpu_device,
+	&dma_device,
 };

 static int __init sh7722_devices_setup(void)
-- 
1.6.2

