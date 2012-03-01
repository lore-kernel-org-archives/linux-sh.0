From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 01 Mar 2012 02:32:42 +0000
Subject: [PATCH 3/3] sh: sh7786: Add echi-sh of platform data
Message-Id: <1330569162-9485-3-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
index 599022d..9e32e1c 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7786.c
@@ -23,6 +23,7 @@
 #include <linux/sh_timer.h>
 #include <linux/sh_dma.h>
 #include <linux/sh_intc.h>
+#include <linux/usb/ehci-sh.h>
 #include <cpu/dma-register.h>
 #include <asm/mmzone.h>
 
@@ -540,6 +541,11 @@ static struct platform_device dma0_device = {
 	},
 };
 
+static struct ehci_sh_platdata usb_ehci_pdata = {
+	.phy_init = NULL,
+	.clkmode = 0,
+};
+
 #define USB_EHCI_START 0xffe70000
 #define USB_OHCI_START 0xffe70400
 
@@ -562,6 +568,7 @@ static struct platform_device usb_ehci_device = {
 	.dev = {
 		.dma_mask		= &usb_ehci_device.dev.coherent_dma_mask,
 		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data      = &usb_ehci_pdata,
 	},
 	.num_resources	= ARRAY_SIZE(usb_ehci_resources),
 	.resource	= usb_ehci_resources,
-- 
1.7.9.1

