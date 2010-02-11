From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Feb 2010 16:50:10 +0000
Subject: [PATCH 2/5 v2] sh: convert shdma dmaengine driver to use platform
Message-Id: <Pine.LNX.4.64.1002111709290.4484@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The shdma dmaengine driver currently uses numerous macros to support various
platforms, selected by ifdef's. Convert it to use platform device resources and
lists of channel descriptors to specify register locations, interrupt numbers
and other system-specific configuration variants. Unavoidably, we have to
simultaneously convert all shdma users to provide those resources.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

1. Move all channel IRQs to resources.
2. Fix sh7722 typo in setup-sh7724

 arch/sh/include/asm/dma-sh.h           |   13 +-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   70 +++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  159 +++++++++++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  113 +++++++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  113 +++++++++++-
 drivers/dma/shdma.c                    |  318 +++++++++++++++++++-------------
 drivers/dma/shdma.h                    |    6 +-
 7 files changed, 636 insertions(+), 156 deletions(-)

diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index e934a2e..2e3631d 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -154,10 +154,17 @@ struct sh_dmae_slave_config {
 	char				mid_rid;
 };
 
+struct sh_dmae_channel {
+	unsigned int	offset;
+	unsigned int	dmars;
+	unsigned int	dmars_bit;
+};
+
 struct sh_dmae_pdata {
-	unsigned int mode;
-	struct sh_dmae_slave_config *config;
-	int config_num;
+	struct sh_dmae_slave_config *slave;
+	int slave_num;
+	struct sh_dmae_channel *channel;
+	int channel_num;
 };
 
 struct device;
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 5c6a40d..5dcd0de 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -75,15 +75,79 @@ static struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
 	},
 };
 
+static struct sh_dmae_channel sh7722_dmae_channels[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
 static struct sh_dmae_pdata dma_platform_data = {
-	.mode		= 0,
-	.config		= sh7722_dmae_slaves,
-	.config_num	= ARRAY_SIZE(sh7722_dmae_slaves),
+	.slave		= sh7722_dmae_slaves,
+	.slave_num	= ARRAY_SIZE(sh7722_dmae_slaves),
+	.channel	= sh7722_dmae_channels,
+	.channel_num	= ARRAY_SIZE(sh7722_dmae_channels),
+};
+
+static struct resource sh7722_dmae_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfe008020,
+		.end	= 0xfe00808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xfe009000,
+		.end	= 0xfe00900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start	= 78,
+		.end	= 78,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-3 */
+		.start	= 48,
+		.end	= 51,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 4-5 */
+		.start	= 76,
+		.end	= 77,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
 struct platform_device dma_device = {
 	.name		= "sh-dma-engine",
 	.id		= -1,
+	.resource	= sh7722_dmae_resources,
+	.num_resources	= ARRAY_SIZE(sh7722_dmae_resources),
 	.dev		= {
 		.platform_data	= &dma_platform_data,
 	},
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index aa0f6e9..f001fc4 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -28,15 +28,157 @@
 #include <cpu/sh7724.h>
 
 /* DMA */
-static struct sh_dmae_pdata dma_platform_data = {
-	.mode = SHDMA_DMAOR1,
+static struct sh_dmae_channel sh7724_dmae0_channels[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_channel sh7724_dmae1_channels[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_pdata dma0_platform_data = {
+	.channel	= sh7724_dmae0_channels,
+	.channel_num	= ARRAY_SIZE(sh7724_dmae0_channels),
+};
+
+static struct sh_dmae_pdata dma1_platform_data = {
+	.channel	= sh7724_dmae1_channels,
+	.channel_num	= ARRAY_SIZE(sh7724_dmae1_channels),
+};
+
+/* Resource order important! */
+static struct resource sh7724_dmae0_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfe008020,
+		.end	= 0xfe00808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfe009000,
+		.end	= 0xfe00900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start	= 78,
+		.end	= 78,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-3 */
+		.start	= 48,
+		.end	= 51,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 4-5 */
+		.start	= 76,
+		.end	= 77,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
-static struct platform_device dma_device = {
-	.name	= "sh-dma-engine",
-	.id		= -1,
-	.dev	= {
-		.platform_data	= &dma_platform_data,
+/* Resource order important! */
+static struct resource sh7724_dmae1_resources[] = {
+	{
+		/* Channel registers and DMAOR */
+		.start	= 0xfdc08020,
+		.end	= 0xfdc0808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMARSx */
+		.start	= 0xfdc09000,
+		.end	= 0xfdc0900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start	= 74,
+		.end	= 74,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 0-3 */
+		.start	= 40,
+		.end	= 43,
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		/* IRQ for channels 4-5 */
+		.start	= 72,
+		.end	= 73,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device dma0_device = {
+	.name		= "sh-dma-engine",
+	.id		= 0,
+	.resource	= sh7724_dmae0_resources,
+	.num_resources	= ARRAY_SIZE(sh7724_dmae0_resources),
+	.dev		= {
+		.platform_data	= &dma0_platform_data,
+	},
+};
+
+static struct platform_device dma1_device = {
+	.name		= "sh-dma-engine",
+	.id		= 1,
+	.resource	= sh7724_dmae1_resources,
+	.num_resources	= ARRAY_SIZE(sh7724_dmae1_resources),
+	.dev		= {
+		.platform_data	= &dma1_platform_data,
 	},
 };
 
@@ -663,7 +805,8 @@ static struct platform_device *sh7724_devices[] __initdata = {
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
-	&dma_device,
+	&dma0_device,
+	&dma1_device,
 	&rtc_device,
 	&iic0_device,
 	&iic1_device,
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
index f8f2161..338dfc2 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -247,15 +247,115 @@ static struct platform_device rtc_device = {
 	.resource	= rtc_resources,
 };
 
-static struct sh_dmae_pdata dma_platform_data = {
-	.mode = (SHDMA_MIX_IRQ | SHDMA_DMAOR1),
+/* DMA */
+static struct sh_dmae_channel sh7780_dmae0_channels[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_channel sh7780_dmae1_channels[] = {
+	{
+		.offset = 0,
+	}, {
+		.offset = 0x10,
+	}, {
+		.offset = 0x20,
+	}, {
+		.offset = 0x30,
+	}, {
+		.offset = 0x50,
+	}, {
+		.offset = 0x60,
+	}
+};
+
+static struct sh_dmae_pdata dma0_platform_data = {
+	.channel	= sh7780_dmae0_channels,
+	.channel_num	= ARRAY_SIZE(sh7780_dmae0_channels),
+};
+
+static struct sh_dmae_pdata dma1_platform_data = {
+	.channel	= sh7780_dmae1_channels,
+	.channel_num	= ARRAY_SIZE(sh7780_dmae1_channels),
+};
+
+static struct resource sh7780_dmae0_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfc808020,
+		.end	= 0xfc80808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xfc809000,
+		.end	= 0xfc80900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* Real DMA error IRQ is 38, and channel IRQs are 34-37, 44-45 */
+		.start	= 34,
+		.end	= 34,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+};
+
+static struct resource sh7780_dmae1_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfc818020,
+		.end	= 0xfc81808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	/* DMAC1 has no DMARS */
+	{
+		/* Real DMA error IRQ is 38, and channel IRQs are 46-47, 92-95 */
+		.start	= 46,
+		.end	= 46,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
 };
 
-static struct platform_device dma_device = {
+static struct platform_device dma0_device = {
 	.name           = "sh-dma-engine",
-	.id             = -1,
+	.id             = 0,
+	.resource	= sh7780_dmae0_resources,
+	.num_resources	= ARRAY_SIZE(sh7780_dmae0_resources),
 	.dev            = {
-		.platform_data  = &dma_platform_data,
+		.platform_data	= &dma0_platform_data,
+	},
+};
+
+static struct platform_device dma1_device = {
+	.name		= "sh-dma-engine",
+	.id		= 1,
+	.resource	= sh7780_dmae1_resources,
+	.num_resources	= ARRAY_SIZE(sh7780_dmae1_resources),
+	.dev		= {
+		.platform_data	= &dma1_platform_data,
 	},
 };
 
@@ -269,7 +369,8 @@ static struct platform_device *sh7780_devices[] __initdata = {
 	&tmu4_device,
 	&tmu5_device,
 	&rtc_device,
-	&dma_device,
+	&dma0_device,
+	&dma1_device,
 };
 
 static int __init sh7780_devices_setup(void)
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 23448d8..fbb5d1f 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -295,15 +295,115 @@ static struct platform_device tmu5_device = {
 	.num_resources	= ARRAY_SIZE(tmu5_resources),
 };
 
-static struct sh_dmae_pdata dma_platform_data = {
-	.mode = (SHDMA_MIX_IRQ | SHDMA_DMAOR1),
+/* DMA */
+static struct sh_dmae_channel sh7785_dmae0_channels[] = {
+	{
+		.offset = 0,
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_channel sh7785_dmae1_channels[] = {
+	{
+		.offset = 0,
+	}, {
+		.offset = 0x10,
+	}, {
+		.offset = 0x20,
+	}, {
+		.offset = 0x30,
+	}, {
+		.offset = 0x50,
+	}, {
+		.offset = 0x60,
+	}
+};
+
+static struct sh_dmae_pdata dma0_platform_data = {
+	.channel	= sh7785_dmae0_channels,
+	.channel_num	= ARRAY_SIZE(sh7785_dmae0_channels),
+};
+
+static struct sh_dmae_pdata dma1_platform_data = {
+	.channel	= sh7785_dmae1_channels,
+	.channel_num	= ARRAY_SIZE(sh7785_dmae1_channels),
+};
+
+static struct resource sh7785_dmae0_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfc808020,
+		.end	= 0xfc80808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xfc809000,
+		.end	= 0xfc80900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* Real DMA error IRQ is 39, and channel IRQs are 33-38 */
+		.start	= 33,
+		.end	= 33,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
+};
+
+static struct resource sh7785_dmae1_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfcc08020,
+		.end	= 0xfcc0808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	/* DMAC1 has no DMARS */
+	{
+		/* Real DMA error IRQ is 58, and channel IRQs are 52-57 */
+		.start	= 52,
+		.end	= 52,
+		.flags	= IORESOURCE_IRQ | IORESOURCE_IRQ_SHAREABLE,
+	},
 };
 
-static struct platform_device dma_device = {
+static struct platform_device dma0_device = {
 	.name           = "sh-dma-engine",
-	.id             = -1,
+	.id             = 0,
+	.resource	= sh7785_dmae0_resources,
+	.num_resources	= ARRAY_SIZE(sh7785_dmae0_resources),
 	.dev            = {
-		.platform_data  = &dma_platform_data,
+		.platform_data	= &dma0_platform_data,
+	},
+};
+
+static struct platform_device dma1_device = {
+	.name		= "sh-dma-engine",
+	.id		= 1,
+	.resource	= sh7785_dmae1_resources,
+	.num_resources	= ARRAY_SIZE(sh7785_dmae1_resources),
+	.dev		= {
+		.platform_data	= &dma1_platform_data,
 	},
 };
 
@@ -320,7 +420,8 @@ static struct platform_device *sh7785_devices[] __initdata = {
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
-	&dma_device,
+	&dma0_device,
+	&dma1_device,
 };
 
 static int __init sh7785_devices_setup(void)
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 7731169..bf70132 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -53,15 +53,24 @@ static unsigned long sh_dmae_slave_used[BITS_TO_LONGS(SHDMA_SLAVE_NUMBER)];
 
 static void sh_dmae_chan_ld_cleanup(struct sh_dmae_chan *sh_chan, bool all);
 
-#define SH_DMAC_CHAN_BASE(id) (dma_base_addr[id])
 static void sh_dmae_writel(struct sh_dmae_chan *sh_dc, u32 data, u32 reg)
 {
-	ctrl_outl(data, SH_DMAC_CHAN_BASE(sh_dc->id) + reg);
+	__raw_writel(data, sh_dc->base + reg / sizeof(u32));
 }
 
 static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
 {
-	return ctrl_inl(SH_DMAC_CHAN_BASE(sh_dc->id) + reg);
+	return __raw_readl(sh_dc->base + reg / sizeof(u32));
+}
+
+static u16 dmaor_read(struct sh_dmae_device *shdev)
+{
+	return __raw_readw(shdev->chan_reg + DMAOR / sizeof(u32));
+}
+
+static void dmaor_write(struct sh_dmae_device *shdev, u16 data)
+{
+	__raw_writew(data, shdev->chan_reg + DMAOR / sizeof(u32));
 }
 
 /*
@@ -69,23 +78,22 @@ static u32 sh_dmae_readl(struct sh_dmae_chan *sh_dc, u32 reg)
  *
  * SH7780 has two DMAOR register
  */
-static void sh_dmae_ctl_stop(int id)
+static void sh_dmae_ctl_stop(struct sh_dmae_device *shdev)
 {
-	unsigned short dmaor = dmaor_read_reg(id);
+	unsigned short dmaor = dmaor_read(shdev);
 
-	dmaor &= ~(DMAOR_NMIF | DMAOR_AE | DMAOR_DME);
-	dmaor_write_reg(id, dmaor);
+	dmaor_write(shdev, dmaor & ~(DMAOR_NMIF | DMAOR_AE | DMAOR_DME));
 }
 
-static int sh_dmae_rst(int id)
+static int sh_dmae_rst(struct sh_dmae_device *shdev)
 {
 	unsigned short dmaor;
 
-	sh_dmae_ctl_stop(id);
-	dmaor = dmaor_read_reg(id) | DMAOR_INIT;
+	sh_dmae_ctl_stop(shdev);
+	dmaor = dmaor_read(shdev) | DMAOR_INIT;
 
-	dmaor_write_reg(id, dmaor);
-	if (dmaor_read_reg(id) & (DMAOR_AE | DMAOR_NMIF)) {
+	dmaor_write(shdev, dmaor);
+	if (dmaor_read(shdev) & (DMAOR_AE | DMAOR_NMIF)) {
 		pr_warning("dma-sh: Can't initialize DMAOR.\n");
 		return -EINVAL;
 	}
@@ -153,31 +161,20 @@ static int dmae_set_chcr(struct sh_dmae_chan *sh_chan, u32 val)
 	return 0;
 }
 
-#define DMARS_SHIFT	8
-#define DMARS_CHAN_MSK	0x01
 static int dmae_set_dmars(struct sh_dmae_chan *sh_chan, u16 val)
 {
-	u32 addr;
-	int shift = 0;
+	struct sh_dmae_device *shdev = container_of(sh_chan->common.device,
+						struct sh_dmae_device, common);
+	struct sh_dmae_pdata *pdata = shdev->pdata;
+	struct sh_dmae_channel *chan_pdata = &pdata->channel[sh_chan->id];
+	u16 __iomem *addr = shdev->dmars + chan_pdata->dmars / sizeof(u16);
+	int shift = chan_pdata->dmars_bit;
 
 	if (dmae_is_busy(sh_chan))
 		return -EBUSY;
 
-	if (sh_chan->id & DMARS_CHAN_MSK)
-		shift = DMARS_SHIFT;
-
-	if (sh_chan->id < 6)
-		/* DMA0RS0 - DMA0RS2 */
-		addr = SH_DMARS_BASE0 + (sh_chan->id / 2) * 4;
-#ifdef SH_DMARS_BASE1
-	else if (sh_chan->id < 12)
-		/* DMA1RS0 - DMA1RS2 */
-		addr = SH_DMARS_BASE1 + ((sh_chan->id - 6) / 2) * 4;
-#endif
-	else
-		return -EINVAL;
-
-	ctrl_outw((val << shift) | (ctrl_inw(addr) & (0xFF00 >> shift)), addr);
+	__raw_writew((__raw_readw(addr) & (0xff00 >> shift)) | (val << shift),
+		     addr);
 
 	return 0;
 }
@@ -251,15 +248,15 @@ static struct sh_dmae_slave_config *sh_dmae_find_slave(
 	struct dma_device *dma_dev = sh_chan->common.device;
 	struct sh_dmae_device *shdev = container_of(dma_dev,
 					struct sh_dmae_device, common);
-	struct sh_dmae_pdata *pdata = &shdev->pdata;
+	struct sh_dmae_pdata *pdata = shdev->pdata;
 	int i;
 
 	if ((unsigned)slave_id >= SHDMA_SLAVE_NUMBER)
 		return NULL;
 
-	for (i = 0; i < pdata->config_num; i++)
-		if (pdata->config[i].slave_id = slave_id)
-			return pdata->config + i;
+	for (i = 0; i < pdata->slave_num; i++)
+		if (pdata->slave[i].slave_id = slave_id)
+			return pdata->slave + i;
 
 	return NULL;
 }
@@ -757,9 +754,7 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 	int i;
 
 	/* halt the dma controller */
-	sh_dmae_ctl_stop(0);
-	if (shdev->pdata.mode & SHDMA_DMAOR1)
-		sh_dmae_ctl_stop(1);
+	sh_dmae_ctl_stop(shdev);
 
 	/* We cannot detect, which channel caused the error, have to reset all */
 	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
@@ -778,9 +773,7 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 			list_splice_init(&sh_chan->ld_queue, &sh_chan->ld_free);
 		}
 	}
-	sh_dmae_rst(0);
-	if (shdev->pdata.mode & SHDMA_DMAOR1)
-		sh_dmae_rst(1);
+	sh_dmae_rst(shdev);
 
 	return IRQ_HANDLED;
 }
@@ -813,19 +806,12 @@ static void dmae_do_tasklet(unsigned long data)
 	sh_dmae_chan_ld_cleanup(sh_chan, false);
 }
 
-static unsigned int get_dmae_irq(unsigned int id)
-{
-	unsigned int irq = 0;
-	if (id < ARRAY_SIZE(dmte_irq_map))
-		irq = dmte_irq_map[id];
-	return irq;
-}
-
-static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
+static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
+					int irq, unsigned long flags)
 {
 	int err;
-	unsigned int irq = get_dmae_irq(id);
-	unsigned long irqflags = IRQF_DISABLED;
+	struct sh_dmae_channel *chan_pdata = &shdev->pdata->channel[id];
+	struct platform_device *pdev = to_platform_device(shdev->common.dev);
 	struct sh_dmae_chan *new_sh_chan;
 
 	/* alloc channel */
@@ -838,6 +824,8 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
 
 	new_sh_chan->dev = shdev->common.dev;
 	new_sh_chan->id = id;
+	new_sh_chan->irq = irq;
+	new_sh_chan->base = shdev->chan_reg + chan_pdata->offset / sizeof(u32);
 
 	/* Init DMA tasklet */
 	tasklet_init(&new_sh_chan->tasklet, dmae_do_tasklet,
@@ -860,21 +848,15 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
 			&shdev->common.channels);
 	shdev->common.chancnt++;
 
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
-		irqflags = IRQF_SHARED;
-#if defined(DMTE6_IRQ)
-		if (irq >= DMTE6_IRQ)
-			irq = DMTE6_IRQ;
-		else
-#endif
-			irq = DMTE0_IRQ;
-	}
-
-	snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
-		 "sh-dmae%d", new_sh_chan->id);
+	if (pdev->id >= 0)
+		snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
+			 "sh-dmae%d.%d", pdev->id, new_sh_chan->id);
+	else
+		snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
+			 "sh-dma%d", new_sh_chan->id);
 
 	/* set up channel irq */
-	err = request_irq(irq, &sh_dmae_interrupt, irqflags,
+	err = request_irq(irq, &sh_dmae_interrupt, flags,
 			  new_sh_chan->dev_id, new_sh_chan);
 	if (err) {
 		dev_err(shdev->common.dev, "DMA channel %d request_irq error "
@@ -898,12 +880,12 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
 
 	for (i = shdev->common.chancnt - 1 ; i >= 0 ; i--) {
 		if (shdev->chan[i]) {
-			struct sh_dmae_chan *shchan = shdev->chan[i];
-			if (!(shdev->pdata.mode & SHDMA_MIX_IRQ))
-				free_irq(dmte_irq_map[i], shchan);
+			struct sh_dmae_chan *sh_chan = shdev->chan[i];
+
+			free_irq(sh_chan->irq, sh_chan);
 
-			list_del(&shchan->common.device_node);
-			kfree(shchan);
+			list_del(&sh_chan->common.device_node);
+			kfree(sh_chan);
 			shdev->chan[i] = NULL;
 		}
 	}
@@ -912,47 +894,81 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
 
 static int __init sh_dmae_probe(struct platform_device *pdev)
 {
-	int err = 0, cnt, ecnt;
-	unsigned long irqflags = IRQF_DISABLED;
-#if defined(CONFIG_CPU_SH4)
-	int eirq[] = { DMAE0_IRQ,
-#if defined(DMAE1_IRQ)
-			DMAE1_IRQ
-#endif
-		};
-#endif
+	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
+	unsigned long irqflags = IRQF_DISABLED,
+		chan_flag[MAX_DMA_CHANNELS] = {};
+	int errirq, chan_irq[MAX_DMA_CHANNELS];
+	int err, i, irq_cnt = 0, irqres = 0;
 	struct sh_dmae_device *shdev;
+	struct resource *chan, *dmars, *errirq_res, *chanirq_res;
 
 	/* get platform data */
-	if (!pdev->dev.platform_data)
+	if (!pdata || !pdata->channel_num)
 		return -ENODEV;
 
+	chan = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/* DMARS area is optional, if absent, this controller cannot do slave DMA */
+	dmars = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	/*
+	 * IRQ resources:
+	 * 1. there always must be at least one IRQ IO-resource. On SH4 it is
+	 *    the error IRQ, in which case it is the only IRQ in this resource:
+	 *    start = end. If it is the only IRQ resource, all channels also
+	 *    use the same IRQ.
+	 * 2. DMA channel IRQ resources can be specified one per resource or in
+	 *    ranges (start != end)
+	 * 3. iff all events (channels and, optionally, error) on this
+	 *    controller use the same IRQ, only one IRQ resource can be
+	 *    specified, otherwise there must be one IRQ per channel, even if
+	 *    some of them are equal
+	 * 4. if all IRQs on this controller are equal or if some specific IRQs
+	 *    specify IORESOURCE_IRQ_SHAREABLE in their resources, they will be
+	 *    requested with the IRQF_SHARED flag
+	 */
+	errirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!chan || !errirq_res)
+		return -ENODEV;
+
+	if (!request_mem_region(chan->start, resource_size(chan), pdev->name)) {
+		dev_err(&pdev->dev, "DMAC register region already claimed\n");
+		return -EBUSY;
+	}
+
+	if (dmars && !request_mem_region(dmars->start, resource_size(dmars), pdev->name)) {
+		dev_err(&pdev->dev, "DMAC DMARS region already claimed\n");
+		err = -EBUSY;
+		goto ermrdmars;
+	}
+
+	err = -ENOMEM;
 	shdev = kzalloc(sizeof(struct sh_dmae_device), GFP_KERNEL);
 	if (!shdev) {
-		dev_err(&pdev->dev, "No enough memory\n");
-		return -ENOMEM;
+		dev_err(&pdev->dev, "Not enough memory\n");
+		goto ealloc;
+	}
+
+	shdev->chan_reg = ioremap(chan->start, resource_size(chan));
+	if (!shdev->chan_reg)
+		goto emapchan;
+	if (dmars) {
+		shdev->dmars = ioremap(dmars->start, resource_size(dmars));
+		if (!shdev->dmars)
+			goto emapdmars;
 	}
 
 	/* platform data */
-	memcpy(&shdev->pdata, pdev->dev.platform_data,
-			sizeof(struct sh_dmae_pdata));
+	shdev->pdata = pdata;
 
 	/* reset dma controller */
-	err = sh_dmae_rst(0);
+	err = sh_dmae_rst(shdev);
 	if (err)
 		goto rst_err;
 
-	/* SH7780/85/23 has DMAOR1 */
-	if (shdev->pdata.mode & SHDMA_DMAOR1) {
-		err = sh_dmae_rst(1);
-		if (err)
-			goto rst_err;
-	}
-
 	INIT_LIST_HEAD(&shdev->common.channels);
 
 	dma_cap_set(DMA_MEMCPY, shdev->common.cap_mask);
-	dma_cap_set(DMA_SLAVE, shdev->common.cap_mask);
+	if (dmars)
+		dma_cap_set(DMA_SLAVE, shdev->common.cap_mask);
 
 	shdev->common.device_alloc_chan_resources
 		= sh_dmae_alloc_chan_resources;
@@ -970,30 +986,63 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 	shdev->common.copy_align = 5;
 
 #if defined(CONFIG_CPU_SH4)
-	/* Non Mix IRQ mode SH7722/SH7730 etc... */
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
+	chanirq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 1);
+
+	if (!chanirq_res)
+		chanirq_res = errirq_res;
+	else
+		irqres++;
+
+	if (chanirq_res = errirq_res ||
+	    (errirq_res->flags & IORESOURCE_BITS) = IORESOURCE_IRQ_SHAREABLE)
 		irqflags = IRQF_SHARED;
-		eirq[0] = DMTE0_IRQ;
-#if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
-		eirq[1] = DMTE6_IRQ;
-#endif
+
+	errirq = errirq_res->start;
+
+	err = request_irq(errirq, sh_dmae_err, irqflags,
+			  "DMAC Address Error", shdev);
+	if (err) {
+		dev_err(&pdev->dev,
+			"DMA failed requesting irq #%d, error %d\n",
+			errirq, err);
+		goto eirq_err;
 	}
 
-	for (ecnt = 0 ; ecnt < ARRAY_SIZE(eirq); ecnt++) {
-		err = request_irq(eirq[ecnt], sh_dmae_err, irqflags,
-				  "DMAC Address Error", shdev);
-		if (err) {
-			dev_err(&pdev->dev, "DMA device request_irq"
-				"error (irq %d) with return %d\n",
-				eirq[ecnt], err);
-			goto eirq_err;
+#else
+	chanirq_res = errirq_res;
+#endif /* CONFIG_CPU_SH4 */
+
+	if (chanirq_res->start = chanirq_res->end &&
+	    !platform_get_resource(pdev, IORESOURCE_IRQ, 1)) {
+		/* Special case - all multiplexed */
+		for (; irq_cnt < pdata->channel_num; irq_cnt++) {
+			chan_irq[irq_cnt] = chanirq_res->start;
+			chan_flag[irq_cnt] = IRQF_SHARED;
 		}
+	} else {
+		do {
+			for (i = chanirq_res->start; i <= chanirq_res->end; i++) {
+				if ((errirq_res->flags & IORESOURCE_BITS) =
+				    IORESOURCE_IRQ_SHAREABLE)
+					chan_flag[irq_cnt] = IRQF_SHARED;
+				else
+					chan_flag[irq_cnt] = IRQF_DISABLED;
+				dev_dbg(&pdev->dev,
+					"Found IRQ %d for channel %d\n",
+					i, irq_cnt);
+				chan_irq[irq_cnt++] = i;
+			}
+			chanirq_res = platform_get_resource(pdev,
+						IORESOURCE_IRQ, ++irqres);
+		} while (irq_cnt < pdata->channel_num && chanirq_res);
 	}
-#endif /* CONFIG_CPU_SH4 */
+
+	if (irq_cnt < pdata->channel_num)
+		goto eirqres;
 
 	/* Create DMA Channel */
-	for (cnt = 0 ; cnt < MAX_DMA_CHANNELS ; cnt++) {
-		err = sh_dmae_chan_probe(shdev, cnt);
+	for (i = 0; i < pdata->channel_num; i++) {
+		err = sh_dmae_chan_probe(shdev, i, chan_irq[i], chan_flag[i]);
 		if (err)
 			goto chan_probe_err;
 	}
@@ -1005,13 +1054,23 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 
 chan_probe_err:
 	sh_dmae_chan_remove(shdev);
-
+eirqres:
+#if defined(CONFIG_CPU_SH4)
+	free_irq(errirq, shdev);
 eirq_err:
-	for (ecnt-- ; ecnt >= 0; ecnt--)
-		free_irq(eirq[ecnt], shdev);
-
+#endif
 rst_err:
+	if (dmars)
+		iounmap(shdev->dmars);
+emapdmars:
+	iounmap(shdev->chan_reg);
+emapchan:
 	kfree(shdev);
+ealloc:
+	if (dmars)
+		release_mem_region(dmars->start, resource_size(dmars));
+ermrdmars:
+	release_mem_region(chan->start, resource_size(chan));
 
 	return err;
 }
@@ -1019,36 +1078,37 @@ rst_err:
 static int __exit sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
+	struct resource *res;
+	int errirq = platform_get_irq(pdev, 0);
 
 	dma_async_device_unregister(&shdev->common);
 
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
-		free_irq(DMTE0_IRQ, shdev);
-#if defined(DMTE6_IRQ)
-		free_irq(DMTE6_IRQ, shdev);
-#endif
-	}
+	if (errirq > 0)
+		free_irq(errirq, shdev);
 
 	/* channel data remove */
 	sh_dmae_chan_remove(shdev);
 
-	if (!(shdev->pdata.mode & SHDMA_MIX_IRQ)) {
-		free_irq(DMAE0_IRQ, shdev);
-#if defined(DMAE1_IRQ)
-		free_irq(DMAE1_IRQ, shdev);
-#endif
-	}
+	if (shdev->dmars)
+		iounmap(shdev->dmars);
+	iounmap(shdev->chan_reg);
+
 	kfree(shdev);
 
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
+
 	return 0;
 }
 
 static void sh_dmae_shutdown(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
-	sh_dmae_ctl_stop(0);
-	if (shdev->pdata.mode & SHDMA_DMAOR1)
-		sh_dmae_ctl_stop(1);
+	sh_dmae_ctl_stop(shdev);
 }
 
 static struct platform_driver sh_dmae_driver = {
diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
index 7e227f3..800fd88 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -47,14 +47,18 @@ struct sh_dmae_chan {
 	struct tasklet_struct tasklet;	/* Tasklet */
 	int descs_allocated;		/* desc count */
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
+	int irq;
 	int id;				/* Raw id of this channel */
+	u32 __iomem *base;
 	char dev_id[16];		/* unique name per DMAC of channel */
 };
 
 struct sh_dmae_device {
 	struct dma_device common;
 	struct sh_dmae_chan *chan[MAX_DMA_CHANNELS];
-	struct sh_dmae_pdata pdata;
+	struct sh_dmae_pdata *pdata;
+	u32 __iomem *chan_reg;
+	u16 __iomem *dmars;
 };
 
 #define to_sh_chan(chan) container_of(chan, struct sh_dmae_chan, common)
-- 
1.6.2.4

