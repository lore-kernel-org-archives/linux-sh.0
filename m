From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 07 Mar 2012 05:46:41 +0000
Subject: [PATCH RESEND] sh: add platform_device for RSPI in setup-sh7757
Message-Id: <4F56F641.4030809@renesas.com>
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
index 2875e8b..c8836cf 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -680,6 +680,25 @@ static struct platform_device spi1_device = {
 	.resource	= spi1_resources,
 };

+static struct resource rspi_resources[] = {
+	{
+		.start	= 0xfe480000,
+		.end	= 0xfe4800ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= 220,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device rspi_device = {
+	.name	= "rspi",
+	.id	= 2,
+	.num_resources	= ARRAY_SIZE(rspi_resources),
+	.resource	= rspi_resources,
+};
+
 static struct resource usb_ehci_resources[] = {
 	[0] = {
 		.start	= 0xfe4f1000,
@@ -740,6 +759,7 @@ static struct platform_device *sh7757_devices[] __initdata = {
 	&dma3_device,
 	&spi0_device,
 	&spi1_device,
+	&rspi_device,
 	&usb_ehci_device,
 	&usb_ohci_device,
 };
-- 
1.7.1
