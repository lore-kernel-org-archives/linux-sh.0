From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 21 Jun 2011 08:28:27 +0000
Subject: [PATCH] sh: add platform_device of EHCI/OHCI to setup-sh7757
Message-Id: <4E00562B.6050300@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   50 ++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 423dabf..717a76b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -659,6 +659,54 @@ static struct platform_device spi0_device = {
 	.resource	= spi0_resources,
 };

+static struct resource usb_ehci_resources[] = {
+	[0] = {
+		.start	= 0xfe4f1000,
+		.end	= 0xfe4f10ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 57,
+		.end	= 57,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_ehci_device = {
+	.name		= "sh_ehci",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &usb_ehci_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(usb_ehci_resources),
+	.resource	= usb_ehci_resources,
+};
+
+static struct resource usb_ohci_resources[] = {
+	[0] = {
+		.start	= 0xfe4f1800,
+		.end	= 0xfe4f18ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 57,
+		.end	= 57,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device usb_ohci_device = {
+	.name		= "sh_ohci",
+	.id		= -1,
+	.dev = {
+		.dma_mask = &usb_ohci_device.dev.coherent_dma_mask,
+		.coherent_dma_mask = DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(usb_ohci_resources),
+	.resource	= usb_ohci_resources,
+};
+
 static struct platform_device *sh7757_devices[] __initdata = {
 	&scif2_device,
 	&scif3_device,
@@ -670,6 +718,8 @@ static struct platform_device *sh7757_devices[] __initdata = {
 	&dma2_device,
 	&dma3_device,
 	&spi0_device,
+	&usb_ehci_device,
+	&usb_ohci_device,
 };

 static int __init sh7757_devices_setup(void)
-- 
1.7.1
