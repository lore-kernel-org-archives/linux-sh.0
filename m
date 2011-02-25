From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Feb 2011 07:39:10 +0000
Subject: [PATCH 2/7] sh: add platform_device for SPI
Message-Id: <4D675C9E.3030603@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 9c1de26..480f665 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -124,12 +124,36 @@ static struct platform_device tmu1_device = {
 	.num_resources	= ARRAY_SIZE(tmu1_resources),
 };

+static struct resource spi0_resources[] = {
+	[0] = {
+		.start	= 0xfe002000,
+		.end	= 0xfe0020ff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 86,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device spi0_device = {
+	.name	= "sh_spi",
+	.id	= 0,
+	.dev	= {
+		.dma_mask		= NULL,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(spi0_resources),
+	.resource	= spi0_resources,
+};
+
 static struct platform_device *sh7757_devices[] __initdata = {
 	&scif2_device,
 	&scif3_device,
 	&scif4_device,
 	&tmu0_device,
 	&tmu1_device,
+	&spi0_device,
 };

 static int __init sh7757_devices_setup(void)
-- 
1.7.1
