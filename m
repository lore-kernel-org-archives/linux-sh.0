From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 01 Mar 2012 02:32:41 +0000
Subject: [PATCH 2/3] sh: sh7757: Add echi-sh of platform data
Message-Id: <1330569162-9485-2-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 2875e8b..d791d64 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -18,6 +18,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/sh_timer.h>
 #include <linux/sh_dma.h>
+#include <linux/usb/ehci-sh.h>
 
 #include <cpu/dma-register.h>
 #include <cpu/sh7757.h>
@@ -680,6 +681,11 @@ static struct platform_device spi1_device = {
 	.resource	= spi1_resources,
 };
 
+static struct ehci_sh_platdata usb_ehci_pdata = {
+	.phy_init = NULL,
+	.clkmode = 0,
+};
+
 static struct resource usb_ehci_resources[] = {
 	[0] = {
 		.start	= 0xfe4f1000,
@@ -699,6 +705,7 @@ static struct platform_device usb_ehci_device = {
 	.dev = {
 		.dma_mask = &usb_ehci_device.dev.coherent_dma_mask,
 		.coherent_dma_mask = DMA_BIT_MASK(32),
+		.platform_data      = &usb_ehci_pdata,
 	},
 	.num_resources	= ARRAY_SIZE(usb_ehci_resources),
 	.resource	= usb_ehci_resources,
-- 
1.7.9.1

