From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 03 Feb 2010 15:03:46 +0000
Subject: [PATCH 1/4] sh: convert shdma dmaengine driver to use platform device
Message-Id: <Pine.LNX.4.64.1002031554020.6324@axis700.grange>
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
 arch/sh/include/asm/dma-sh.h           |   14 ++-
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   62 +++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |  141 ++++++++++++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7780.c |  126 +++++++++++++++-
 arch/sh/kernel/cpu/sh4a/setup-sh7785.c |  126 +++++++++++++++-
 drivers/dma/shdma.c                    |  264 ++++++++++++++++----------------
 drivers/dma/shdma.h                    |    5 +-
 7 files changed, 585 insertions(+), 153 deletions(-)

diff --git a/arch/sh/include/asm/dma-sh.h b/arch/sh/include/asm/dma-sh.h
index e934a2e..238df83 100644
--- a/arch/sh/include/asm/dma-sh.h
+++ b/arch/sh/include/asm/dma-sh.h
@@ -154,10 +154,20 @@ struct sh_dmae_slave_config {
 	char				mid_rid;
 };
 
+struct sh_dmae_channel {
+	unsigned int	offset;
+	int		irq;
+	unsigned int	dmars;
+	unsigned int	dmars_bit;
+};
+
 struct sh_dmae_pdata {
 	unsigned int mode;
-	struct sh_dmae_slave_config *config;
-	int config_num;
+	struct sh_dmae_slave_config *slave;
+	int slave_num;
+	struct sh_dmae_channel *channel;
+	int channel_num;
+	unsigned int dmaor_offset;
 };
 
 struct device;
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 5c6a40d..c1335e5 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -75,15 +75,73 @@ static struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
 	},
 };
 
+static struct sh_dmae_channel sh7722_dmae_channels[] = {
+	{
+		.offset = 0,
+		.irq = 48,	/* channel 0 IRQ is also used for shared IRQs */
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.irq = 49,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.irq = 50,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.irq = 51,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.irq = 76,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.irq = 77,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
 static struct sh_dmae_pdata dma_platform_data = {
 	.mode		= 0,
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
index aa0f6e9..460d147 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -28,15 +28,143 @@
 #include <cpu/sh7724.h>
 
 /* DMA */
-static struct sh_dmae_pdata dma_platform_data = {
-	.mode = SHDMA_DMAOR1,
+static struct sh_dmae_channel sh7722_dmae0_channels[] = {
+	{
+		.offset = 0,
+		.irq = 48,	/* channel 0 IRQ is also used for shared IRQs */
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.irq = 49,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.irq = 50,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.irq = 51,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.irq = 76,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.irq = 77,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_channel sh7722_dmae1_channels[] = {
+	{
+		.offset = 0,
+		.irq = 40,	/* channel 0 IRQ is also used for shared IRQs */
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.irq = 41,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.irq = 42,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.irq = 43,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.irq = 72,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.irq = 73,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_pdata dma0_platform_data = {
+	.mode		= 0,
+	.channel	= sh7722_dmae0_channels,
+	.channel_num	= ARRAY_SIZE(sh7722_dmae0_channels),
+};
+
+static struct sh_dmae_pdata dma1_platform_data = {
+	.mode		= 0,
+	.channel	= sh7722_dmae1_channels,
+	.channel_num	= ARRAY_SIZE(sh7722_dmae1_channels),
+};
+
+static struct resource sh7722_dmae0_resources[] = {
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
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct resource sh7722_dmae1_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfdc08020,
+		.end	= 0xfdc0808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		/* DMARSx */
+		.start	= 0xfdc09000,
+		.end	= 0xfdc0900b,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ */
+		.start	= 74,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
-static struct platform_device dma_device = {
+static struct platform_device dma0_device = {
 	.name	= "sh-dma-engine",
-	.id		= -1,
+	.id		= 0,
+	.resource	= sh7722_dmae0_resources,
+	.num_resources	= ARRAY_SIZE(sh7722_dmae0_resources),
+	.dev	= {
+		.platform_data	= &dma0_platform_data,
+	},
+};
+
+static struct platform_device dma1_device = {
+	.name	= "sh-dma-engine",
+	.id		= 1,
+	.resource	= sh7722_dmae1_resources,
+	.num_resources	= ARRAY_SIZE(sh7722_dmae1_resources),
 	.dev	= {
-		.platform_data	= &dma_platform_data,
+		.platform_data	= &dma1_platform_data,
 	},
 };
 
@@ -663,7 +791,8 @@ static struct platform_device *sh7724_devices[] __initdata = {
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
index f8f2161..851de27 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7780.c
@@ -247,15 +247,128 @@ static struct platform_device rtc_device = {
 	.resource	= rtc_resources,
 };
 
-static struct sh_dmae_pdata dma_platform_data = {
-	.mode = (SHDMA_MIX_IRQ | SHDMA_DMAOR1),
+/* DMA */
+static struct sh_dmae_channel sh7780_dmae0_channels[] = {
+	{
+		.offset = 0,
+		.irq = 34,	/* channel 0 IRQ is also used for shared IRQs */
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.irq = 35,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.irq = 36,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.irq = 37,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.irq = 44,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.irq = 45,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_channel sh7780_dmae1_channels[] = {
+	{
+		.offset = 0,
+		.irq = 46,	/* channel 0 IRQ is also used for shared IRQs */
+	}, {
+		.offset = 0x10,
+		.irq = 47,
+	}, {
+		.offset = 0x20,
+		.irq = 92,
+	}, {
+		.offset = 0x30,
+		.irq = 93,
+	}, {
+		.offset = 0x50,
+		.irq = 94,
+	}, {
+		.offset = 0x60,
+		.irq = 95,
+	}
+};
+
+static struct sh_dmae_pdata dma0_platform_data = {
+	.mode		= SHDMA_MIX_IRQ,
+	.channel	= sh7780_dmae0_channels,
+	.channel_num	= ARRAY_SIZE(sh7780_dmae0_channels),
+};
+
+static struct sh_dmae_pdata dma1_platform_data = {
+	.mode		= SHDMA_MIX_IRQ,
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
+		/* DMA error IRQ */
+		.start	= 38,
+		.end	= 38,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
-static struct platform_device dma_device = {
+static struct resource sh7780_dmae1_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfc818020,
+		.end	= 0xfc81808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ - shared with DMAC0 */
+		.start	= 38,
+		.end	= 38,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
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
 
@@ -269,7 +382,8 @@ static struct platform_device *sh7780_devices[] __initdata = {
 	&tmu4_device,
 	&tmu5_device,
 	&rtc_device,
-	&dma_device,
+	&dma0_device,
+	&dma1_device,
 };
 
 static int __init sh7780_devices_setup(void)
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
index 23448d8..e3abc2d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7785.c
@@ -295,15 +295,128 @@ static struct platform_device tmu5_device = {
 	.num_resources	= ARRAY_SIZE(tmu5_resources),
 };
 
-static struct sh_dmae_pdata dma_platform_data = {
-	.mode = (SHDMA_MIX_IRQ | SHDMA_DMAOR1),
+/* DMA */
+static struct sh_dmae_channel sh7785_dmae0_channels[] = {
+	{
+		.offset = 0,
+		.irq = 33,	/* channel 0 IRQ is also used for shared IRQs */
+		.dmars = 0,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x10,
+		.irq = 34,
+		.dmars = 0,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x20,
+		.irq = 35,
+		.dmars = 4,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x30,
+		.irq = 36,
+		.dmars = 4,
+		.dmars_bit = 8,
+	}, {
+		.offset = 0x50,
+		.irq = 37,
+		.dmars = 8,
+		.dmars_bit = 0,
+	}, {
+		.offset = 0x60,
+		.irq = 38,
+		.dmars = 8,
+		.dmars_bit = 8,
+	}
+};
+
+static struct sh_dmae_channel sh7785_dmae1_channels[] = {
+	{
+		.offset = 0,
+		.irq = 52,	/* channel 0 IRQ is also used for shared IRQs */
+	}, {
+		.offset = 0x10,
+		.irq = 53,
+	}, {
+		.offset = 0x20,
+		.irq = 54,
+	}, {
+		.offset = 0x30,
+		.irq = 55,
+	}, {
+		.offset = 0x50,
+		.irq = 56,
+	}, {
+		.offset = 0x60,
+		.irq = 57,
+	}
+};
+
+static struct sh_dmae_pdata dma0_platform_data = {
+	.mode		= SHDMA_MIX_IRQ,
+	.channel	= sh7785_dmae0_channels,
+	.channel_num	= ARRAY_SIZE(sh7785_dmae0_channels),
+};
+
+static struct sh_dmae_pdata dma1_platform_data = {
+	.mode		= SHDMA_MIX_IRQ,
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
+		/* DMA error IRQ */
+		.start	= 39,
+		.end	= 39,
+		.flags	= IORESOURCE_IRQ,
+	},
 };
 
-static struct platform_device dma_device = {
+static struct resource sh7785_dmae1_resources[] = {
+	[0] = {
+		/* Channel registers and DMAOR */
+		.start	= 0xfcc08020,
+		.end	= 0xfcc0808f,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		/* DMA error IRQ - shared with DMAC0 */
+		.start	= 58,
+		.end	= 58,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
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
 
@@ -320,7 +433,8 @@ static struct platform_device *sh7785_devices[] __initdata = {
 	&tmu3_device,
 	&tmu4_device,
 	&tmu5_device,
-	&dma_device,
+	&dma0_device,
+	&dma1_device,
 };
 
 static int __init sh7785_devices_setup(void)
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index b75ce8b..7242776 100644
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
 
-	dmaor &= ~(DMAOR_NMIF | DMAOR_AE);
-	dmaor_write_reg(id, dmaor);
+	dmaor_write(shdev, dmaor & ~(DMAOR_NMIF | DMAOR_AE));
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
 		pr_warning(KERN_ERR "dma-sh: Can't initialize DMAOR.\n");
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
@@ -736,33 +733,19 @@ static irqreturn_t sh_dmae_err(int irq, void *data)
 	struct sh_dmae_device *shdev = (struct sh_dmae_device *)data;
 
 	/* IRQ Multi */
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
-		int __maybe_unused cnt = 0;
-		switch (irq) {
-#if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
-		case DMTE6_IRQ:
-			cnt++;
-#endif
-		case DMTE0_IRQ:
-			if (dmaor_read_reg(cnt) & (DMAOR_NMIF | DMAOR_AE)) {
-				disable_irq(irq);
-				return IRQ_HANDLED;
-			}
-		default:
-			return IRQ_NONE;
+	if (shdev->pdata->mode & SHDMA_MIX_IRQ) {
+		if (irq = shdev->pdata->channel[0].irq &&
+		    dmaor_read(shdev) & (DMAOR_NMIF | DMAOR_AE)) {
+			disable_irq(irq);
+			return IRQ_HANDLED;
 		}
+
+		return IRQ_NONE;
 	} else {
 		/* reset dma controller */
-		err = sh_dmae_rst(0);
+		err = sh_dmae_rst(shdev);
 		if (err)
 			return err;
-#ifdef SH_DMAC_BASE1
-		if (shdev->pdata.mode & SHDMA_DMAOR1) {
-			err = sh_dmae_rst(1);
-			if (err)
-				return err;
-		}
-#endif
 		disable_irq(irq);
 		return IRQ_HANDLED;
 	}
@@ -796,18 +779,12 @@ static void dmae_do_tasklet(unsigned long data)
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
 static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
 {
 	int err;
-	unsigned int irq = get_dmae_irq(id);
+	struct sh_dmae_channel *chan_pdata = &shdev->pdata->channel[id];
+	struct platform_device *pdev = to_platform_device(shdev->common.dev);
+	unsigned int irq = chan_pdata->irq;
 	unsigned long irqflags = IRQF_DISABLED;
 	struct sh_dmae_chan *new_sh_chan;
 
@@ -821,6 +798,7 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
 
 	new_sh_chan->dev = shdev->common.dev;
 	new_sh_chan->id = id;
+	new_sh_chan->base = shdev->chan_reg + chan_pdata->offset / sizeof(u32);
 
 	/* Init DMA tasklet */
 	tasklet_init(&new_sh_chan->tasklet, dmae_do_tasklet,
@@ -843,18 +821,17 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id)
 			&shdev->common.channels);
 	shdev->common.chancnt++;
 
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
+	if (shdev->pdata->mode & SHDMA_MIX_IRQ) {
 		irqflags = IRQF_SHARED;
-#if defined(DMTE6_IRQ)
-		if (irq >= DMTE6_IRQ)
-			irq = DMTE6_IRQ;
-		else
-#endif
-			irq = DMTE0_IRQ;
+		irq = shdev->pdata->channel[0].irq;
 	}
 
-	snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
-		 "sh-dmae%d", new_sh_chan->id);
+	if (pdev->id >= 0)
+		snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
+			 "sh-dmae%d.%d", pdev->id, new_sh_chan->id);
+	else
+		snprintf(new_sh_chan->dev_id, sizeof(new_sh_chan->dev_id),
+			 "sh-dma%d", new_sh_chan->id);
 
 	/* set up channel irq */
 	err = request_irq(irq, &sh_dmae_interrupt, irqflags,
@@ -882,8 +859,9 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
 	for (i = shdev->common.chancnt - 1 ; i >= 0 ; i--) {
 		if (shdev->chan[i]) {
 			struct sh_dmae_chan *shchan = shdev->chan[i];
-			if (!(shdev->pdata.mode & SHDMA_MIX_IRQ))
-				free_irq(dmte_irq_map[i], shchan);
+			struct sh_dmae_channel *chan_pdata = &shdev->pdata->channel[i];
+
+			free_irq(chan_pdata->irq, shchan);
 
 			list_del(&shchan->common.device_node);
 			kfree(shchan);
@@ -895,47 +873,64 @@ static void sh_dmae_chan_remove(struct sh_dmae_device *shdev)
 
 static int __init sh_dmae_probe(struct platform_device *pdev)
 {
-	int err = 0, cnt, ecnt;
+	int err = 0, cnt;
 	unsigned long irqflags = IRQF_DISABLED;
-#if defined(CONFIG_CPU_SH4)
-	int eirq[] = { DMAE0_IRQ,
-#if defined(DMAE1_IRQ)
-			DMAE1_IRQ
-#endif
-		};
-#endif
 	struct sh_dmae_device *shdev;
+	struct resource *chan, *dmars;
+	int errirq;
+	struct sh_dmae_pdata *pdata = pdev->dev.platform_data;
 
 	/* get platform data */
-	if (!pdev->dev.platform_data)
+	if (!pdata || !pdata->channel_num)
+		return -ENODEV;
+
+	chan = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	/* DMARS area is optional, if absent, this controller cannot do slave DMA */
+	dmars = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	errirq = platform_get_irq(pdev, 0);
+	if (!chan || errirq < 0)
 		return -ENODEV;
 
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
@@ -954,28 +949,23 @@ static int __init sh_dmae_probe(struct platform_device *pdev)
 
 #if defined(CONFIG_CPU_SH4)
 	/* Non Mix IRQ mode SH7722/SH7730 etc... */
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
+	if (pdata->mode & SHDMA_MIX_IRQ) {
 		irqflags = IRQF_SHARED;
-		eirq[0] = DMTE0_IRQ;
-#if defined(DMTE6_IRQ) && defined(DMAE1_IRQ)
-		eirq[1] = DMTE6_IRQ;
-#endif
+		errirq = pdata->channel[0].irq;
 	}
 
-	for (ecnt = 0 ; ecnt < ARRAY_SIZE(eirq); ecnt++) {
-		err = request_irq(eirq[ecnt], sh_dmae_err, irqflags,
-				  "DMAC Address Error", shdev);
-		if (err) {
-			dev_err(&pdev->dev, "DMA device request_irq"
-				"error (irq %d) with return %d\n",
-				eirq[ecnt], err);
-			goto eirq_err;
-		}
+	err = request_irq(errirq, sh_dmae_err, irqflags,
+			  "DMAC Address Error", shdev);
+	if (err) {
+		dev_err(&pdev->dev,
+			"DMA failed requesting irq #%d, error %d\n",
+			errirq, err);
+		goto eirq_err;
 	}
 #endif /* CONFIG_CPU_SH4 */
 
 	/* Create DMA Channel */
-	for (cnt = 0 ; cnt < MAX_DMA_CHANNELS ; cnt++) {
+	for (cnt = 0 ; cnt < pdata->channel_num ; cnt++) {
 		err = sh_dmae_chan_probe(shdev, cnt);
 		if (err)
 			goto chan_probe_err;
@@ -990,11 +980,20 @@ chan_probe_err:
 	sh_dmae_chan_remove(shdev);
 
 eirq_err:
-	for (ecnt-- ; ecnt >= 0; ecnt--)
-		free_irq(eirq[ecnt], shdev);
+	free_irq(errirq, shdev);
 
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
@@ -1002,36 +1001,41 @@ rst_err:
 static int __exit sh_dmae_remove(struct platform_device *pdev)
 {
 	struct sh_dmae_device *shdev = platform_get_drvdata(pdev);
+	struct resource *res;
 
 	dma_async_device_unregister(&shdev->common);
 
-	if (shdev->pdata.mode & SHDMA_MIX_IRQ) {
-		free_irq(DMTE0_IRQ, shdev);
-#if defined(DMTE6_IRQ)
-		free_irq(DMTE6_IRQ, shdev);
-#endif
+	if (shdev->pdata->mode & SHDMA_MIX_IRQ) {
+		free_irq(shdev->pdata->channel[0].irq, shdev);
+	} else {
+		int errirq = platform_get_irq(pdev, 0);
+		if (errirq > 0)
+			free_irq(errirq, shdev);
 	}
 
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
index 7e227f3..a99c385 100644
--- a/drivers/dma/shdma.h
+++ b/drivers/dma/shdma.h
@@ -48,13 +48,16 @@ struct sh_dmae_chan {
 	int descs_allocated;		/* desc count */
 	int xmit_shift;			/* log_2(bytes_per_xfer) */
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

