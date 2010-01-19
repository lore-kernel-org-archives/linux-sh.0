From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 19 Jan 2010 08:09:06 +0000
Subject: [PATCH 3/4] sh: add DMA slave definitions and SIU platform data to
Message-Id: <Pine.LNX.4.64.1001190903500.4607@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: Kuninori Morimoto <morimoto.kuninori@renesas.com>, Magnus Damm <damm@opensource.se>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-sh@vger.kernel.org

This patch is required to use the SIU ASoC driver on sh7722 systems.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |  103 ++++++++++++++++++++++++++++++--
 1 files changed, 97 insertions(+), 6 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index adb65a9..5c6a40d 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -18,8 +18,77 @@
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 #include <asm/dma-sh.h>
+#include <asm/siu.h>
 #include <cpu/sh7722.h>
 
+static struct sh_dmae_slave_config sh7722_dmae_slaves[] = {
+	{
+		.slave_id	= SHDMA_SLAVE_SCIF0_TX,
+		.addr		= 0xffe0000c,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x21,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF0_RX,
+		.addr		= 0xffe00014,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x22,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_TX,
+		.addr		= 0xffe1000c,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x25,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF1_RX,
+		.addr		= 0xffe10014,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x26,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_TX,
+		.addr		= 0xffe2000c,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x29,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SCIF2_RX,
+		.addr		= 0xffe20014,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x2a,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SIUA_TX,
+		.addr		= 0xa454c098,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb1,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SIUA_RX,
+		.addr		= 0xa454c090,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb2,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SIUB_TX,
+		.addr		= 0xa454c09c,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb5,
+	}, {
+		.slave_id	= SHDMA_SLAVE_SIUB_RX,
+		.addr		= 0xa454c094,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_32BIT),
+		.mid_rid	= 0xb6,
+	},
+};
+
+static struct sh_dmae_pdata dma_platform_data = {
+	.mode		= 0,
+	.config		= sh7722_dmae_slaves,
+	.config_num	= ARRAY_SIZE(sh7722_dmae_slaves),
+};
+
+struct platform_device dma_device = {
+	.name		= "sh-dma-engine",
+	.id		= -1,
+	.dev		= {
+		.platform_data	= &dma_platform_data,
+	},
+};
+
 /* Serial */
 static struct plat_sci_port scif0_platform_data = {
 	.mapbase        = 0xffe00000,
@@ -388,15 +457,36 @@ static struct platform_device tmu2_device = {
 	},
 };
 
-static struct sh_dmae_pdata dma_platform_data = {
-	.mode = 0,
+static struct siu_platform siu_platform_data = {
+	.dma_dev	= &dma_device.dev,
+	.dma_slave_tx_a	= SHDMA_SLAVE_SIUA_TX,
+	.dma_slave_rx_a	= SHDMA_SLAVE_SIUA_RX,
+	.dma_slave_tx_b	= SHDMA_SLAVE_SIUB_TX,
+	.dma_slave_rx_b	= SHDMA_SLAVE_SIUB_RX,
 };
 
-static struct platform_device dma_device = {
-	.name		= "sh-dma-engine",
+static struct resource siu_resources[] = {
+	[0] = {
+		.start	= 0xa4540000,
+		.end	= 0xa454c10f,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= 108,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device siu_device = {
+	.name		= "sh_siu",
 	.id		= -1,
-	.dev		= {
-		.platform_data	= &dma_platform_data,
+	.dev = {
+		.platform_data	= &siu_platform_data,
+	},
+	.resource	= siu_resources,
+	.num_resources	= ARRAY_SIZE(siu_resources),
+	.archdata = {
+		.hwblk_id = HWBLK_SIU,
 	},
 };
 
@@ -414,6 +504,7 @@ static struct platform_device *sh7722_devices[] __initdata = {
 	&vpu_device,
 	&veu_device,
 	&jpu_device,
+	&siu_device,
 	&dma_device,
 };
 
-- 
1.6.2.4

