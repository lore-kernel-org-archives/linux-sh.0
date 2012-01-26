From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 26 Jan 2012 08:44:07 +0000
Subject: [PATCH 2/2] sh: add platform_device for SPI1 in setup-sh7757
Message-Id: <4F211257.6040803@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 226d809..2875e8b 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -661,6 +661,25 @@ static struct platform_device spi0_device = {
 	.resource	= spi0_resources,
 };

+static struct resource spi1_resources[] = {
+	{
+		.start	= 0xffd8ee70,
+		.end	= 0xffd8eeff,
+		.flags	= IORESOURCE_MEM | IORESOURCE_MEM_8BIT,
+	},
+	{
+		.start	= 54,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device spi1_device = {
+	.name	= "sh_spi",
+	.id	= 1,
+	.num_resources	= ARRAY_SIZE(spi1_resources),
+	.resource	= spi1_resources,
+};
+
 static struct resource usb_ehci_resources[] = {
 	[0] = {
 		.start	= 0xfe4f1000,
@@ -720,6 +739,7 @@ static struct platform_device *sh7757_devices[] __initdata = {
 	&dma2_device,
 	&dma3_device,
 	&spi0_device,
+	&spi1_device,
 	&usb_ehci_device,
 	&usb_ohci_device,
 };
-- 
1.7.1
