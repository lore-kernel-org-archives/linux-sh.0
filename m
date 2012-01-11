From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Jan 2012 07:28:26 +0000
Subject: [PATCH v3 1/2] sh: add platform_device for SUDMAC in setup-sh7757
Message-Id: <4F0D3A1A.5070701@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 about v3:
  - use defination macros for IRQ resource

 arch/sh/include/cpu-sh4/cpu/sh7757.h   |    1 +
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   50 ++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/sh/include/cpu-sh4/cpu/sh7757.h b/arch/sh/include/cpu-sh4/cpu/sh7757.h
index 41f9f8b..f9be40a 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7757.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7757.h
@@ -283,5 +283,6 @@ enum {
 	SHDMA_SLAVE_RIIC8_RX,
 	SHDMA_SLAVE_RIIC9_TX,
 	SHDMA_SLAVE_RIIC9_RX,
+	SHDMA_SLAVE_SUDMAC00,
 };
 #endif /* __ASM_SH7757_H__ */
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index cf2667a..f8adc26 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -665,6 +665,55 @@ static struct platform_device dma3_device = {
 	},
 };

+/* SUDMAC */
+static const struct sh_dmae_channel sh7757_sudmac_channel[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}
+};
+
+static const struct sh_dmae_slave_config sh7757_sudmac00_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SUDMAC00,
+		.addr		= 0xfe451000,
+	},
+};
+
+static struct sh_dmae_pdata sudmac00_platform_data = {
+	.slave		= sh7757_sudmac00_slaves,
+	.slave_num	= ARRAY_SIZE(sh7757_sudmac00_slaves),
+	.channel	= sh7757_sudmac_channel,
+	.channel_num	= 1,
+	.no_dmars	= 1,
+	.sudmac		= 1,
+};
+
+static struct resource sh7757_sudmac00_resources[] = {
+	[0] = {
+		.start	= 0xfe451000,
+		.end	= 0xfe451000,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= SH_DMA_IRQ_CHANNEL,
+		.start	= 50,
+		.end	= 50,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+};
+
+static struct platform_device sudmac00_device = {
+	.name		= "sh-dma-engine",
+	.id		= 4,
+	.resource	= sh7757_sudmac00_resources,
+	.num_resources	= ARRAY_SIZE(sh7757_sudmac00_resources),
+	.dev		= {
+		.platform_data	= &sudmac00_platform_data,
+	},
+};
+
 static struct platform_device spi0_device = {
 	.name	= "sh_spi",
 	.id	= 0,
@@ -734,6 +783,7 @@ static struct platform_device *sh7757_devices[] __initdata = {
 	&dma1_device,
 	&dma2_device,
 	&dma3_device,
+	&sudmac00_device,
 	&spi0_device,
 	&usb_ehci_device,
 	&usb_ohci_device,
-- 
1.7.1
