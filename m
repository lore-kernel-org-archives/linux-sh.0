From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 22 Jan 2010 18:09:03 +0000
Subject: [PATCH 2a/4 v2] ASoC: add DAI and platform / DMA drivers for SH SIU
Message-Id: <Pine.LNX.4.64.1001221900030.4652@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1001190839110.4607@axis700.grange>
 <Pine.LNX.4.64.1001190902000.4607@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1001190902000.4607@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: alsa-devel@alsa-project.org
Cc: linux-sh@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Magnus Damm <damm@opensource.se>

Several SuperH platforms, including sh7722, sh7343, sh7354, sh7367 include 
a Sound Interface Unit (SIU). This patch adds DAI and platform / DMA 
drivers for this interface.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v1 -> v2:

1. splitted off board support into a separate patch
2. made SND_SOC_SH4_SIU a hidden Kconfig variable
3. SND_SOC_SH4_SIU now can be selected on other SuperH platforms, not only 
   on sh7722
4. moved many defines, that are only used in one of .c-files in those 
   files
5. prefixed remaining defines in the header with SIU_
6. clarification: "only fixed Left-upper, Left-lower, Right-upper, 
   Right-lower packing is supported" means - only this byte order is 
   hard-coded without support for other possible byte-orders
7. clk_put() doesn't mind getting an error code as its argument, but moved 
   it under the respective "if" just in case;)
8. removed mono-emulation via data-copying. Looking for a recipe to achive 
   this via alsa-configuration, anyone?

diff --git a/arch/sh/include/asm/siu.h b/arch/sh/include/asm/siu.h
new file mode 100644
index 0000000..57565a3
--- /dev/null
+++ b/arch/sh/include/asm/siu.h
@@ -0,0 +1,26 @@
+/*
+ * platform header for the SIU ASoC driver
+ *
+ * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef ASM_SIU_H
+#define ASM_SIU_H
+
+#include <asm/dma-sh.h>
+
+struct device;
+
+struct siu_platform {
+	struct device *dma_dev;
+	enum sh_dmae_slave_chan_id dma_slave_tx_a;
+	enum sh_dmae_slave_chan_id dma_slave_rx_a;
+	enum sh_dmae_slave_chan_id dma_slave_tx_b;
+	enum sh_dmae_slave_chan_id dma_slave_rx_b;
+};
+
+#endif /* ASM_SIU_H */
diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index 8072a6d..a86696b 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -26,6 +26,12 @@ config SND_SOC_SH4_FSI
 	help
 	  This option enables FSI sound support
 
+config SND_SOC_SH4_SIU
+	tristate
+	depends on (SUPERH || ARCH_SHMOBILE) && HAVE_CLK
+	select DMADEVICES
+	select SH_DMAE
+
 ##
 ## Boards
 ##
diff --git a/sound/soc/sh/Makefile b/sound/soc/sh/Makefile
index 1d0ec0a..8a5a192 100644
--- a/sound/soc/sh/Makefile
+++ b/sound/soc/sh/Makefile
@@ -6,9 +6,11 @@ obj-$(CONFIG_SND_SOC_PCM_SH7760)	+= snd-soc-dma-sh7760.o
 snd-soc-hac-objs	:= hac.o
 snd-soc-ssi-objs	:= ssi.o
 snd-soc-fsi-objs	:= fsi.o
+snd-soc-siu-objs	:= siu_pcm.o siu_dai.o
 obj-$(CONFIG_SND_SOC_SH4_HAC)	+= snd-soc-hac.o
 obj-$(CONFIG_SND_SOC_SH4_SSI)	+= snd-soc-ssi.o
 obj-$(CONFIG_SND_SOC_SH4_FSI)	+= snd-soc-fsi.o
+obj-$(CONFIG_SND_SOC_SH4_SIU)	+= snd-soc-siu.o
 
 ## boards
 snd-soc-sh7760-ac97-objs	:= sh7760-ac97.o
diff --git a/sound/soc/sh/siu.h b/sound/soc/sh/siu.h
new file mode 100644
index 0000000..9cc04ab
--- /dev/null
+++ b/sound/soc/sh/siu.h
@@ -0,0 +1,193 @@
+/*
+ * siu.h - ALSA SoC driver for Renesas SH7343, SH7722 SIU peripheral.
+ *
+ * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#ifndef SIU_H
+#define SIU_H
+
+/* Common kernel and user-space firmware-building defines and types */
+
+#define YRAM0_SIZE		(0x0040 / 4)		/* 16 */
+#define YRAM1_SIZE		(0x0080 / 4)		/* 32 */
+#define YRAM2_SIZE		(0x0040 / 4)		/* 16 */
+#define YRAM3_SIZE		(0x0080 / 4)		/* 32 */
+#define YRAM4_SIZE		(0x0080 / 4)		/* 32 */
+#define YRAM_DEF_SIZE		(YRAM0_SIZE + YRAM1_SIZE + YRAM2_SIZE + \
+				 YRAM3_SIZE + YRAM4_SIZE)
+#define YRAM_FIR_SIZE		(0x0400 / 4)		/* 256 */
+#define YRAM_IIR_SIZE		(0x0200 / 4)		/* 128 */
+
+#define XRAM0_SIZE		(0x0400 / 4)		/* 256 */
+#define XRAM1_SIZE		(0x0200 / 4)		/* 128 */
+#define XRAM2_SIZE		(0x0200 / 4)		/* 128 */
+
+/* PRAM program array size */
+#define PRAM0_SIZE		(0x0100 / 4)		/* 64 */
+#define PRAM1_SIZE		((0x2000 - 0x0100) / 4)	/* 1984 */
+
+#include <linux/types.h>
+
+struct siu_spb_param {
+	__u32	ab1a;	/* input FIFO address */
+	__u32	ab0a;	/* output FIFO address */
+	__u32	dir;	/* 0=the ather except CPUOUTPUT, 1=CPUINPUT */
+	__u32	event;	/* SPB program starting conditions */
+	__u32	stfifo;	/* STFIFO register setting value */
+	__u32	trdat;	/* TRDAT register setting value */
+};
+
+struct siu_firmware {
+	__u32			yram_fir_coeff[YRAM_FIR_SIZE];
+	__u32			pram0[PRAM0_SIZE];
+	__u32			pram1[PRAM1_SIZE];
+	__u32			yram0[YRAM0_SIZE];
+	__u32			yram1[YRAM1_SIZE];
+	__u32			yram2[YRAM2_SIZE];
+	__u32			yram3[YRAM3_SIZE];
+	__u32			yram4[YRAM4_SIZE];
+	__u32			spbpar_num;
+	struct siu_spb_param	spbpar[32];
+};
+
+#ifdef __KERNEL__
+
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+
+#include <asm/dma-sh.h>
+
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc-dai.h>
+
+#define SIU_PERIOD_BYTES_MAX	8192		/* DMA transfer/period size */
+#define SIU_PERIOD_BYTES_MIN	256		/* DMA transfer/period size */
+#define SIU_PERIODS_MAX		64		/* Max periods in buffer */
+#define SIU_PERIODS_MIN		4		/* Min periods in buffer */
+#define SIU_BUFFER_BYTES_MAX	(SIU_PERIOD_BYTES_MAX * SIU_PERIODS_MAX)
+
+/* SIU ports: only one can be used at a time */
+enum {
+	SIU_PORT_A,
+	SIU_PORT_B,
+	SIU_PORT_NUM,
+};
+
+/* SIU clock configuration */
+enum {
+	SIU_CLKA_PLL,
+	SIU_CLKA_EXT,
+	SIU_CLKB_PLL,
+	SIU_CLKB_EXT
+};
+
+struct siu_info {
+	int			port_id;
+	u32 __iomem		*pram;
+	u32 __iomem		*xram;
+	u32 __iomem		*yram;
+	u32 __iomem		*reg;
+	struct siu_firmware	fw;
+};
+
+struct siu_stream {
+	struct tasklet_struct		tasklet;
+	struct snd_pcm_substream	*substream;
+	snd_pcm_format_t		format;
+	size_t				buf_bytes;
+	size_t				period_bytes;
+	int				cur_period;	/* Period currently in dma */
+	u32				volume;
+	snd_pcm_sframes_t		xfer_cnt;	/* Number of frames */
+	u8				rw_flg;		/* transfer status */
+	/* DMA status */
+	struct dma_chan			*chan;		/* DMA channel */
+	struct dma_async_tx_descriptor	*tx_desc;
+	dma_cookie_t			cookie;
+	struct sh_dmae_slave		param;
+};
+
+struct siu_port {
+	unsigned long		play_cap;	/* Used to track full duplex */
+	struct snd_pcm		*pcm;
+	struct siu_stream	playback;
+	struct siu_stream	capture;
+	u32			stfifo;		/* STFIFO value from firmware */
+	u32			trdat;		/* TRDAT value from firmware */
+};
+
+extern struct siu_port *siu_ports[SIU_PORT_NUM];
+
+static inline struct siu_port *siu_port_info(struct snd_pcm_substream *substream)
+{
+	struct platform_device *pdev +		to_platform_device(substream->pcm->card->dev);
+	return siu_ports[pdev->id];
+}
+
+/* Register access */
+static inline void siu_write32(u32 __iomem *addr, u32 val)
+{
+	__raw_writel(val, addr);
+}
+
+static inline u32 siu_read32(u32 __iomem *addr)
+{
+	return __raw_readl(addr);
+}
+
+/* SIU registers */
+#define SIU_IFCTL	(0x000 / sizeof(u32))
+#define SIU_SRCTL	(0x004 / sizeof(u32))
+#define SIU_SFORM	(0x008 / sizeof(u32))
+#define SIU_CKCTL	(0x00c / sizeof(u32))
+#define SIU_TRDAT	(0x010 / sizeof(u32))
+#define SIU_STFIFO	(0x014 / sizeof(u32))
+#define SIU_DPAK	(0x01c / sizeof(u32))
+#define SIU_CKREV	(0x020 / sizeof(u32))
+#define SIU_EVNTC	(0x028 / sizeof(u32))
+#define SIU_SBCTL	(0x040 / sizeof(u32))
+#define SIU_SBPSET	(0x044 / sizeof(u32))
+#define SIU_SBFSTS	(0x068 / sizeof(u32))
+#define SIU_SBDVCA	(0x06c / sizeof(u32))
+#define SIU_SBDVCB	(0x070 / sizeof(u32))
+#define SIU_SBACTIV	(0x074 / sizeof(u32))
+#define SIU_DMAIA	(0x090 / sizeof(u32))
+#define SIU_DMAIB	(0x094 / sizeof(u32))
+#define SIU_DMAOA	(0x098 / sizeof(u32))
+#define SIU_DMAOB	(0x09c / sizeof(u32))
+#define SIU_DMAML	(0x0a0 / sizeof(u32))
+#define SIU_SPSTS	(0x0cc / sizeof(u32))
+#define SIU_SPCTL	(0x0d0 / sizeof(u32))
+#define SIU_BRGASEL	(0x100 / sizeof(u32))
+#define SIU_BRRA	(0x104 / sizeof(u32))
+#define SIU_BRGBSEL	(0x108 / sizeof(u32))
+#define SIU_BRRB	(0x10c / sizeof(u32))
+
+extern struct snd_soc_platform siu_platform;
+extern struct snd_soc_dai siu_i2s_dai;
+
+int siu_init_port(int port, struct siu_port **port_info, struct snd_card *card);
+void siu_free_port(struct siu_port *port_info);
+
+#endif
+
+#endif /* SIU_H */
diff --git a/sound/soc/sh/siu_dai.c b/sound/soc/sh/siu_dai.c
new file mode 100644
index 0000000..5452d19
--- /dev/null
+++ b/sound/soc/sh/siu_dai.c
@@ -0,0 +1,847 @@
+/*
+ * siu_dai.c - ALSA SoC driver for Renesas SH7343, SH7722 SIU peripheral.
+ *
+ * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/pm_runtime.h>
+
+#include <asm/clock.h>
+#include <asm/siu.h>
+
+#include <sound/control.h>
+#include <sound/soc-dai.h>
+
+#include "siu.h"
+
+/* Board specifics */
+#if defined(CONFIG_CPU_SUBTYPE_SH7722)
+# define SIU_MAX_VOLUME		0x1000
+#else
+# define SIU_MAX_VOLUME		0x7fff
+#endif
+
+#define PRAM_SIZE	0x2000
+#define XRAM_SIZE	0x800
+#define YRAM_SIZE	0x800
+
+#define XRAM_OFFSET	0x4000
+#define YRAM_OFFSET	0x6000
+#define REG_OFFSET	0xc000
+
+#define PLAYBACK_ENABLED	1
+#define CAPTURE_ENABLED		2
+
+#define VOLUME_CAPTURE		0
+#define VOLUME_PLAYBACK		1
+#define DFLT_VOLUME_LEVEL	0x08000800
+
+/*
+ * SPDIF is only available on port A and on some SIU implementations it is only
+ * available for input. Due to the lack of hardware to test it, SPDIF is left
+ * disabled in this driver version
+ */
+struct format_flag {
+	u32	i2s;
+	u32	pcm;
+	u32	spdif;
+	u32	mask;
+};
+
+struct port_flag {
+	struct format_flag	playback;
+	struct format_flag	capture;
+};
+
+static struct port_flag siu_flags[SIU_PORT_NUM] = {
+	[SIU_PORT_A] = {
+		.playback = {
+			.i2s	= 0x50000000,
+			.pcm	= 0x40000000,
+			.spdif	= 0x80000000,	/* not on all SIU versions */
+			.mask	= 0xd0000000,
+		},
+		.capture = {
+			.i2s	= 0x05000000,
+			.pcm	= 0x04000000,
+			.spdif	= 0x08000000,
+			.mask	= 0x0d000000,
+		},
+	},
+	[SIU_PORT_B] = {
+		.playback = {
+			.i2s	= 0x00500000,
+			.pcm	= 0x00400000,
+			.spdif	= 0,		/* impossible - turn off */
+			.mask	= 0x00500000,
+		},
+		.capture = {
+			.i2s	= 0x00050000,
+			.pcm	= 0x00040000,
+			.spdif	= 0,		/* impossible - turn off */
+			.mask	= 0x00050000,
+		},
+	},
+};
+
+static void siu_dai_start(struct siu_port *port_info)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+
+	dev_dbg(port_info->pcm->card->dev, "%s\n", __func__);
+
+	/* Turn on SIU clock */
+	pm_runtime_get_sync(siu_i2s_dai.dev);
+
+	/* Issue software reset to siu */
+	siu_write32(base + SIU_SRCTL, 0);
+
+	/* Wait for the reset to take effect */
+	udelay(1);
+
+	port_info->stfifo = 0;
+	port_info->trdat = 0;
+
+	/* portA, portB, SIU operate */
+	siu_write32(base + SIU_SRCTL, 0x301);
+
+	/* portA%6fs, portB%6fs */
+	siu_write32(base + SIU_CKCTL, 0x40400000);
+
+	/* portA's BRG does not divide SIUCKA */
+	siu_write32(base + SIU_BRGASEL, 0);
+	siu_write32(base + SIU_BRRA, 0);
+
+	/* portB's BRG divides SIUCKB by half */
+	siu_write32(base + SIU_BRGBSEL, 1);
+	siu_write32(base + SIU_BRRB, 0);
+
+	siu_write32(base + SIU_IFCTL, 0x44440000);
+
+	/* portA: 32 bit/fs, master; portB: 32 bit/fs, master */
+	siu_write32(base + SIU_SFORM, 0x0c0c0000);
+
+	/*
+	 * Volume levels: looks like the DSP firmware implements volume controls
+	 * differently from what's described in the datasheet
+	 */
+	siu_write32(base + SIU_SBDVCA, port_info->playback.volume);
+	siu_write32(base + SIU_SBDVCB, port_info->capture.volume);
+}
+
+static void siu_dai_stop(void)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+
+	/* SIU software reset */
+	siu_write32(base + SIU_SRCTL, 0);
+
+	/* Turn off SIU clock */
+	pm_runtime_put_sync(siu_i2s_dai.dev);
+}
+
+static void siu_dai_spbAselect(struct siu_port *port_info)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_firmware *fw = &info->fw;
+	u32 *ydef = fw->yram0;
+	u32 idx;
+
+	/* path A use */
+	if (!info->port_id)
+		idx = 1;		/* portA */
+	else
+		idx = 2;		/* portB */
+
+	ydef[0] = (fw->spbpar[idx].ab1a << 16) |
+		(fw->spbpar[idx].ab0a << 8) |
+		(fw->spbpar[idx].dir << 7) | 3;
+	ydef[1] = fw->yram0[1];	/* 0x03000300 */
+	ydef[2] = (16 / 2) << 24;
+	ydef[3] = fw->yram0[3];	/* 0 */
+	ydef[4] = fw->yram0[4];	/* 0 */
+	ydef[7] = fw->spbpar[idx].event;
+	port_info->stfifo |= fw->spbpar[idx].stfifo;
+	port_info->trdat |= fw->spbpar[idx].trdat;
+}
+
+static void siu_dai_spbBselect(struct siu_port *port_info)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_firmware *fw = &info->fw;
+	u32 *ydef = fw->yram0;
+	u32 idx;
+
+	/* path B use */
+	if (!info->port_id)
+		idx = 7;		/* portA */
+	else
+		idx = 8;		/* portB */
+
+	ydef[5] = (fw->spbpar[idx].ab1a << 16) |
+		(fw->spbpar[idx].ab0a << 8) | 1;
+	ydef[6] = fw->spbpar[idx].event;
+	port_info->stfifo |= fw->spbpar[idx].stfifo;
+	port_info->trdat |= fw->spbpar[idx].trdat;
+}
+
+static void siu_dai_open(struct siu_stream *siu_stream)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	u32 srctl, ifctl;
+
+	srctl = siu_read32(base + SIU_SRCTL);
+	ifctl = siu_read32(base + SIU_IFCTL);
+
+	switch (info->port_id) {
+	case SIU_PORT_A:
+		/* portA operates */
+		srctl |= 0x200;
+		ifctl &= ~0xc2;
+		break;
+	case SIU_PORT_B:
+		/* portB operates */
+		srctl |= 0x100;
+		ifctl &= ~0x31;
+		break;
+	}
+
+	siu_write32(base + SIU_SRCTL, srctl);
+	/* Unmute and configure portA */
+	siu_write32(base + SIU_IFCTL, ifctl);
+}
+
+/*
+ * At the moment only fixed Left-upper, Left-lower, Right-upper, Right-lower
+ * packing is supported
+ */
+static void siu_dai_pcmdatapack(struct siu_stream *siu_stream)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	u32 dpak;
+
+	dpak = siu_read32(base + SIU_DPAK);
+
+	switch (info->port_id) {
+	case SIU_PORT_A:
+		dpak &= ~0xc0000000;
+		break;
+	case SIU_PORT_B:
+		dpak &= ~0x00c00000;
+		break;
+	}
+
+	siu_write32(base + SIU_DPAK, dpak);
+}
+
+static int siu_dai_spbstart(struct siu_port *port_info)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	struct siu_firmware *fw = &info->fw;
+	u32 *ydef = fw->yram0;
+	int cnt;
+	u32 __iomem *add;
+	u32 *ptr;
+
+	/* Load SPB Program in PRAM */
+	ptr = fw->pram0;
+	add = info->pram;
+	for (cnt = 0; cnt < PRAM0_SIZE; cnt++, add++, ptr++)
+		siu_write32(add, *ptr);
+
+	ptr = fw->pram1;
+	add = info->pram + (0x0100 / sizeof(u32));
+	for (cnt = 0; cnt < PRAM1_SIZE; cnt++, add++, ptr++)
+		siu_write32(add, *ptr);
+
+	/* XRAM initialization */
+	add = info->xram;
+	for (cnt = 0; cnt < XRAM0_SIZE + XRAM1_SIZE + XRAM2_SIZE; cnt++, add++)
+		siu_write32(add, 0);
+
+	/* YRAM variable area initialization */
+	add = info->yram;
+	for (cnt = 0; cnt < YRAM_DEF_SIZE; cnt++, add++)
+		siu_write32(add, ydef[cnt]);
+
+	/* YRAM FIR coefficient area initialization */
+	add = info->yram + (0x0200 / sizeof(u32));
+	for (cnt = 0; cnt < YRAM_FIR_SIZE; cnt++, add++)
+		siu_write32(add, fw->yram_fir_coeff[cnt]);
+
+	/* YRAM IIR coefficient area initialization */
+	add = info->yram + (0x0600 / sizeof(u32));
+	for (cnt = 0; cnt < YRAM_IIR_SIZE; cnt++, add++)
+		siu_write32(add, 0);
+
+	siu_write32(base + SIU_TRDAT, port_info->trdat);
+	port_info->trdat = 0x0;
+
+
+	/* SPB start condition: software */
+	siu_write32(base + SIU_SBACTIV, 0);
+	/* Start SPB */
+	siu_write32(base + SIU_SBCTL, 0xc0000000);
+	/* Wait for program to halt */
+	cnt = 0x10000;
+	while (--cnt && siu_read32(base + SIU_SBCTL) != 0x80000000)
+		cpu_relax();
+
+	if (!cnt)
+		return -EBUSY;
+
+	/* SPB program start address setting */
+	siu_write32(base + SIU_SBPSET, 0x00400000);
+	/* SPB hardware start(FIFOCTL source) */
+	siu_write32(base + SIU_SBACTIV, 0xc0000000);
+
+	return 0;
+}
+
+static void siu_dai_spbstop(struct siu_port *port_info)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+
+	siu_write32(base + SIU_SBACTIV, 0);
+	/* SPB stop */
+	siu_write32(base + SIU_SBCTL, 0);
+
+	port_info->stfifo = 0;
+}
+
+/*		API functions		*/
+
+/* Playback and capture hardware properties are identical */
+static struct snd_pcm_hardware siu_dai_pcm_hw = {
+	.info			= SNDRV_PCM_INFO_INTERLEAVED,
+	.formats		= SNDRV_PCM_FMTBIT_S16,
+	.rates			= SNDRV_PCM_RATE_8000_48000,
+	.rate_min		= 8000,
+	.rate_max		= 48000,
+	.channels_min		= 2,
+	.channels_max		= 2,
+	.buffer_bytes_max	= SIU_BUFFER_BYTES_MAX,
+	.period_bytes_min	= SIU_PERIOD_BYTES_MIN,
+	.period_bytes_max	= SIU_PERIOD_BYTES_MAX,
+	.periods_min		= SIU_PERIODS_MIN,
+	.periods_max		= SIU_PERIODS_MAX,
+};
+
+static int siu_dai_info_volume(struct snd_kcontrol *kctrl,
+			       struct snd_ctl_elem_info *uinfo)
+{
+	struct siu_port *port_info = snd_kcontrol_chip(kctrl);
+
+	dev_dbg(port_info->pcm->card->dev, "%s\n", __func__);
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
+	uinfo->count = 2;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = SIU_MAX_VOLUME;
+
+	return 0;
+}
+
+static int siu_dai_get_volume(struct snd_kcontrol *kctrl,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct siu_port *port_info = snd_kcontrol_chip(kctrl);
+	struct device *dev = port_info->pcm->card->dev;
+	u32 vol;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	switch (kctrl->private_value) {
+	case VOLUME_PLAYBACK:
+		/* Playback is always on port 0 */
+		vol = port_info->playback.volume;
+		ucontrol->value.integer.value[0] = vol & 0xffff;
+		ucontrol->value.integer.value[1] = vol >> 16 & 0xffff;
+		break;
+	case VOLUME_CAPTURE:
+		/* Capture is always on port 1 */
+		vol = port_info->capture.volume;
+		ucontrol->value.integer.value[0] = vol & 0xffff;
+		ucontrol->value.integer.value[1] = vol >> 16 & 0xffff;
+		break;
+	default:
+		dev_err(dev, "%s() invalid private_value=%ld\n",
+			__func__, kctrl->private_value);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int siu_dai_put_volume(struct snd_kcontrol *kctrl,
+			      struct snd_ctl_elem_value *ucontrol)
+{
+	struct siu_port *port_info = snd_kcontrol_chip(kctrl);
+	struct device *dev = port_info->pcm->card->dev;
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	u32 new_vol;
+	u32 cur_vol;
+
+	dev_dbg(dev, "%s\n", __func__);
+
+	if (ucontrol->value.integer.value[0] < 0 ||
+	    ucontrol->value.integer.value[0] > SIU_MAX_VOLUME ||
+	    ucontrol->value.integer.value[1] < 0 ||
+	    ucontrol->value.integer.value[1] > SIU_MAX_VOLUME)
+		return -EINVAL;
+
+	new_vol = ucontrol->value.integer.value[0] |
+		ucontrol->value.integer.value[1] << 16;
+
+	/* See comment above - DSP firmware implementation */
+	switch (kctrl->private_value) {
+	case VOLUME_PLAYBACK:
+		/* Playback is always on port 0 */
+		cur_vol = port_info->playback.volume;
+		siu_write32(base + SIU_SBDVCA, new_vol);
+		port_info->playback.volume = new_vol;
+		break;
+	case VOLUME_CAPTURE:
+		/* Capture is always on port 1 */
+		cur_vol = port_info->capture.volume;
+		siu_write32(base + SIU_SBDVCB, new_vol);
+		port_info->capture.volume = new_vol;
+		break;
+	default:
+		dev_err(dev, "%s() invalid private_value=%ld\n",
+			__func__, kctrl->private_value);
+		return -EINVAL;
+	}
+
+	if (cur_vol != new_vol)
+		return 1;
+
+	return 0;
+}
+
+static struct snd_kcontrol_new playback_controls = {
+	.iface		= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		= "PCM Playback Volume",
+	.index		= 0,
+	.info		= siu_dai_info_volume,
+	.get		= siu_dai_get_volume,
+	.put		= siu_dai_put_volume,
+	.private_value	= VOLUME_PLAYBACK,
+};
+
+static struct snd_kcontrol_new capture_controls = {
+	.iface		= SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name		= "PCM Capture Volume",
+	.index		= 0,
+	.info		= siu_dai_info_volume,
+	.get		= siu_dai_get_volume,
+	.put		= siu_dai_put_volume,
+	.private_value	= VOLUME_CAPTURE,
+};
+
+int siu_init_port(int port, struct siu_port **port_info, struct snd_card *card)
+{
+	struct device *dev = card->dev;
+	struct snd_kcontrol *kctrl;
+	int ret;
+
+	*port_info = kzalloc(sizeof(**port_info), GFP_KERNEL);
+	if (!*port_info)
+		return -ENOMEM;
+
+	dev_dbg(dev, "%s: port #%d@%p\n", __func__, port, *port_info);
+
+	(*port_info)->playback.volume = DFLT_VOLUME_LEVEL;
+	(*port_info)->capture.volume = DFLT_VOLUME_LEVEL;
+
+	/*
+	 * Add mixer support. The SPB is used to change the volume. Both
+	 * ports use the same SPB. Therefore, we only register one
+	 * control instance since it will be used by both channels.
+	 * In error case we continue without controls.
+	 */
+	kctrl = snd_ctl_new1(&playback_controls, *port_info);
+	ret = snd_ctl_add(card, kctrl);
+	if (ret < 0)
+		dev_err(dev,
+			"failed to add playback controls %p port=%d err=%d\n",
+			kctrl, port, ret);
+
+	kctrl = snd_ctl_new1(&capture_controls, *port_info);
+	ret = snd_ctl_add(card, kctrl);
+	if (ret < 0)
+		dev_err(dev,
+			"failed to add capture controls %p port=%d err=%d\n",
+			kctrl, port, ret);
+
+	return 0;
+}
+
+void siu_free_port(struct siu_port *port_info)
+{
+	kfree(port_info);
+}
+
+static int siu_dai_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct siu_port	*port_info = siu_port_info(substream);
+	int ret;
+
+	dev_dbg(substream->pcm->card->dev, "%s: port=%d@%p\n", __func__,
+		info->port_id, port_info);
+
+	snd_soc_set_runtime_hwparams(substream, &siu_dai_pcm_hw);
+
+	ret = snd_pcm_hw_constraint_integer(rt, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (unlikely(ret < 0))
+		return ret;
+
+	siu_dai_start(port_info);
+
+	return 0;
+}
+
+static void siu_dai_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_port	*port_info = siu_port_info(substream);
+
+	dev_dbg(substream->pcm->card->dev, "%s: port=%d@%p\n", __func__,
+		info->port_id, port_info);
+
+	if (substream->stream = SNDRV_PCM_STREAM_PLAYBACK)
+		port_info->play_cap &= ~PLAYBACK_ENABLED;
+	else
+		port_info->play_cap &= ~CAPTURE_ENABLED;
+
+	/* Stop the siu if the other stream is not using it */
+	if (!port_info->play_cap) {
+		/* during stmread or stmwrite ? */
+		BUG_ON(port_info->playback.rw_flg || port_info->capture.rw_flg);
+		siu_dai_spbstop(port_info);
+		siu_dai_stop();
+	}
+}
+
+/* PCM part of siu_dai_playback_prepare() / siu_dai_capture_prepare() */
+static int siu_dai_prepare(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct siu_port *port_info = siu_port_info(substream);
+	struct siu_stream *siu_stream;
+	int self, ret;
+
+	dev_dbg(substream->pcm->card->dev,
+		"%s: port %d, active streams %lx, %d channels\n",
+		__func__, info->port_id, port_info->play_cap, rt->channels);
+
+	if (substream->stream = SNDRV_PCM_STREAM_PLAYBACK) {
+		self = PLAYBACK_ENABLED;
+		siu_stream = &port_info->playback;
+	} else {
+		self = CAPTURE_ENABLED;
+		siu_stream = &port_info->capture;
+	}
+
+	/* Set up the siu if not already done */
+	if (!port_info->play_cap) {
+		siu_stream->rw_flg = 0;	/* stream-data transfer flag */
+
+		siu_dai_spbAselect(port_info);
+		siu_dai_spbBselect(port_info);
+
+		siu_dai_open(siu_stream);
+
+		siu_dai_pcmdatapack(siu_stream);
+
+		ret = siu_dai_spbstart(port_info);
+		if (ret < 0)
+			goto fail;
+	}
+
+	port_info->play_cap |= self;
+
+fail:
+	return ret;
+}
+
+/*
+ * SIU can set bus format to I2S / PCM / SPDIF independently for playback and
+ * capture, however, the current API sets the bus format globally for a DAI.
+ */
+static int siu_dai_set_fmt(struct snd_soc_dai *dai,
+			   unsigned int fmt)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	u32 ifctl;
+
+	dev_dbg(dai->dev, "%s: fmt 0x%x on port %d\n",
+		__func__, fmt, info->port_id);
+
+	if (info->port_id < 0)
+		return -ENODEV;
+
+	/* Here select between I2S / PCM / SPDIF */
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_I2S:
+		ifctl = siu_flags[info->port_id].playback.i2s |
+			siu_flags[info->port_id].capture.i2s;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		ifctl = siu_flags[info->port_id].playback.pcm |
+			siu_flags[info->port_id].capture.pcm;
+		break;
+	/* SPDIF disabled - see comment at the top */
+	default:
+		return -EINVAL;
+	}
+
+	ifctl |= ~(siu_flags[info->port_id].playback.mask |
+		   siu_flags[info->port_id].capture.mask) &
+		siu_read32(base + SIU_IFCTL);
+	siu_write32(base + SIU_IFCTL, ifctl);
+
+	return 0;
+}
+
+static int siu_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+			      unsigned int freq, int dir)
+{
+	struct clk *siu_clk, *parent_clk;
+	char *siu_name, *parent_name;
+	int ret;
+
+	if (dir != SND_SOC_CLOCK_IN)
+		return -EINVAL;
+
+	dev_dbg(dai->dev, "%s: using clock %d\n", __func__, clk_id);
+
+	switch (clk_id) {
+	case SIU_CLKA_PLL:
+		siu_name = "siua_clk";
+		parent_name = "pll_clk";
+		break;
+	case SIU_CLKA_EXT:
+		siu_name = "siua_clk";
+		parent_name = "siumcka_clk";
+		break;
+	case SIU_CLKB_PLL:
+		siu_name = "siub_clk";
+		parent_name = "pll_clk";
+		break;
+	case SIU_CLKB_EXT:
+		siu_name = "siub_clk";
+		parent_name = "siumckb_clk";
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	siu_clk = clk_get(siu_i2s_dai.dev, siu_name);
+	if (IS_ERR(siu_clk))
+		return PTR_ERR(siu_clk);
+
+	parent_clk = clk_get(siu_i2s_dai.dev, parent_name);
+	if (!IS_ERR(parent_clk)) {
+		ret = clk_set_parent(siu_clk, parent_clk);
+		if (!ret)
+			clk_set_rate(siu_clk, freq);
+		clk_put(parent_clk);
+	}
+
+	clk_put(siu_clk);
+
+	return 0;
+}
+
+static struct snd_soc_dai_ops siu_dai_ops = {
+	.startup	= siu_dai_startup,
+	.shutdown	= siu_dai_shutdown,
+	.prepare	= siu_dai_prepare,
+	.set_sysclk	= siu_dai_set_sysclk,
+	.set_fmt	= siu_dai_set_fmt,
+};
+
+struct snd_soc_dai siu_i2s_dai = {
+	.name = "sh-siu",
+	.id = 0,
+	.playback = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.formats = SNDRV_PCM_FMTBIT_S16,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.formats = SNDRV_PCM_FMTBIT_S16,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+	 },
+	.ops = &siu_dai_ops,
+};
+EXPORT_SYMBOL_GPL(siu_i2s_dai);
+
+static int __devinit siu_probe(struct platform_device *pdev)
+{
+	const struct firmware *fw_entry;
+	struct resource *res, *region;
+	struct siu_info *info;
+	int ret;
+
+	info = kmalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = request_firmware(&fw_entry, "siu_spb.bin", &pdev->dev);
+	if (ret)
+		goto ereqfw;
+
+	/*
+	 * Loaded firmware is "const" - read only, but we have to modify it in
+	 * snd_siu_sh7343_spbAselect() and snd_siu_sh7343_spbBselect()
+	 */
+	memcpy(&info->fw, fw_entry->data, fw_entry->size);
+
+	release_firmware(fw_entry);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -ENODEV;
+		goto egetres;
+	}
+
+	region = request_mem_region(res->start, resource_size(res),
+				    pdev->name);
+	if (!region) {
+		dev_err(&pdev->dev, "SIU region already claimed\n");
+		ret = -EBUSY;
+		goto ereqmemreg;
+	}
+
+	ret = -ENOMEM;
+	info->pram = ioremap(res->start, PRAM_SIZE);
+	if (!info->pram)
+		goto emappram;
+	info->xram = ioremap(res->start + XRAM_OFFSET, XRAM_SIZE);
+	if (!info->xram)
+		goto emapxram;
+	info->yram = ioremap(res->start + YRAM_OFFSET, YRAM_SIZE);
+	if (!info->yram)
+		goto emapyram;
+	info->reg = ioremap(res->start + REG_OFFSET, resource_size(res) -
+			    REG_OFFSET);
+	if (!info->reg)
+		goto emapreg;
+
+	siu_i2s_dai.dev = &pdev->dev;
+	siu_i2s_dai.private_data = info;
+
+	ret = snd_soc_register_dais(&siu_i2s_dai, 1);
+	if (ret < 0)
+		goto edaiinit;
+
+	ret = snd_soc_register_platform(&siu_platform);
+	if (ret < 0)
+		goto esocregp;
+
+	pm_runtime_enable(&pdev->dev);
+
+	return ret;
+
+esocregp:
+	snd_soc_unregister_dais(&siu_i2s_dai, 1);
+edaiinit:
+	iounmap(info->reg);
+emapreg:
+	iounmap(info->yram);
+emapyram:
+	iounmap(info->xram);
+emapxram:
+	iounmap(info->pram);
+emappram:
+	release_mem_region(res->start, resource_size(res));
+ereqmemreg:
+egetres:
+ereqfw:
+	kfree(info);
+
+	return ret;
+}
+
+static int __devexit siu_remove(struct platform_device *pdev)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct resource *res;
+
+	pm_runtime_disable(&pdev->dev);
+
+	snd_soc_unregister_platform(&siu_platform);
+	snd_soc_unregister_dais(&siu_i2s_dai, 1);
+
+	iounmap(info->reg);
+	iounmap(info->yram);
+	iounmap(info->xram);
+	iounmap(info->pram);
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res)
+		release_mem_region(res->start, resource_size(res));
+	kfree(info);
+
+	return 0;
+}
+
+static struct platform_driver siu_driver = {
+	.driver 	= {
+		.name	= "sh_siu",
+	},
+	.probe		= siu_probe,
+	.remove		= __devexit_p(siu_remove),
+};
+
+static int __init siu_init(void)
+{
+	return platform_driver_register(&siu_driver);
+}
+
+static void __exit siu_exit(void)
+{
+	platform_driver_unregister(&siu_driver);
+}
+
+module_init(siu_init)
+module_exit(siu_exit)
+
+MODULE_AUTHOR("Carlos Munoz <carlos@kenati.com>");
+MODULE_DESCRIPTION("ALSA SoC SH7722 SIU driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/sh/siu_pcm.c b/sound/soc/sh/siu_pcm.c
new file mode 100644
index 0000000..c5efc30
--- /dev/null
+++ b/sound/soc/sh/siu_pcm.c
@@ -0,0 +1,616 @@
+/*
+ * siu_pcm.c - ALSA driver for Renesas SH7343, SH7722 SIU peripheral.
+ *
+ * Copyright (C) 2009-2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
+ * Copyright (C) 2006 Carlos Munoz <carlos@kenati.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include <sound/control.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc-dai.h>
+
+#include <asm/dma-sh.h>
+#include <asm/siu.h>
+
+#include "siu.h"
+
+#define GET_MAX_PERIODS(buf_bytes, period_bytes) \
+				((buf_bytes) / (period_bytes))
+#define PERIOD_OFFSET(buf_addr, period_num, period_bytes) \
+				((buf_addr) + ((period_num) * (period_bytes)))
+
+#define RWF_STM_RD		0x01		/* Read in progress */
+#define RWF_STM_WT		0x02		/* Write in progress */
+
+struct siu_port *siu_ports[SIU_PORT_NUM];
+
+/* transfersize is number of u32 dma transfers per period */
+static int siu_pcm_stmwrite_stop(struct siu_port *port_info)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	struct siu_stream *siu_stream = &port_info->playback;
+	u32 stfifo;
+
+	if (!siu_stream->rw_flg)
+		return -EPERM;
+
+	/* output FIFO disable */
+	stfifo = siu_read32(base + SIU_STFIFO);
+	siu_write32(base + SIU_STFIFO, stfifo & ~0x0c180c18);
+	pr_debug("%s: STFIFO %x -> %x\n", __func__,
+		 stfifo, stfifo & ~0x0c180c18);
+
+	/* during stmwrite clear */
+	siu_stream->rw_flg = 0;
+
+	return 0;
+}
+
+static int siu_pcm_stmwrite_start(struct siu_port *port_info)
+{
+	struct siu_stream *siu_stream = &port_info->playback;
+
+	if (siu_stream->rw_flg)
+		return -EPERM;
+
+	/* Current period in buffer */
+	port_info->playback.cur_period = 0;
+
+	/* during stmwrite flag set */
+	siu_stream->rw_flg = RWF_STM_WT;
+
+	/* DMA transfer start */
+	tasklet_schedule(&siu_stream->tasklet);
+
+	return 0;
+}
+
+static void siu_dma_tx_complete(void *arg)
+{
+	struct siu_stream *siu_stream = arg;
+
+	if (!siu_stream->rw_flg)
+		return;
+
+	/* Update completed period count */
+	if (++siu_stream->cur_period >+	    GET_MAX_PERIODS(siu_stream->buf_bytes,
+			    siu_stream->period_bytes))
+		siu_stream->cur_period = 0;
+
+	pr_debug("%s: done period #%d (%u/%u bytes), cookie %d\n",
+		__func__, siu_stream->cur_period,
+		siu_stream->cur_period * siu_stream->period_bytes,
+		siu_stream->buf_bytes, siu_stream->cookie);
+
+	tasklet_schedule(&siu_stream->tasklet);
+
+	/* Notify alsa: a period is done */
+	snd_pcm_period_elapsed(siu_stream->substream);
+}
+
+static int siu_pcm_wr_set(struct siu_port *port_info,
+			  dma_addr_t buff, u32 size)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	struct siu_stream *siu_stream = &port_info->playback;
+	struct snd_pcm_substream *substream = siu_stream->substream;
+	struct device *dev = substream->pcm->card->dev;
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	struct scatterlist sg;
+	u32 stfifo;
+
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, pfn_to_page(PFN_DOWN(buff)),
+		    size, offset_in_page(buff));
+	sg_dma_address(&sg) = buff;
+
+	desc = siu_stream->chan->device->device_prep_slave_sg(siu_stream->chan,
+		&sg, 1, DMA_TO_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(dev, "Failed to allocate a dma descriptor\n");
+		return -ENOMEM;
+	}
+
+	desc->callback = siu_dma_tx_complete;
+	desc->callback_param = siu_stream;
+	cookie = desc->tx_submit(desc);
+	if (cookie < 0) {
+		dev_err(dev, "Failed to submit a dma transfer\n");
+		return cookie;
+	}
+
+	siu_stream->tx_desc = desc;
+	siu_stream->cookie = cookie;
+
+	dma_async_issue_pending(siu_stream->chan);
+
+	/* only output FIFO enable */
+	stfifo = siu_read32(base + SIU_STFIFO);
+	siu_write32(base + SIU_STFIFO, stfifo | (port_info->stfifo & 0x0c180c18));
+	dev_dbg(dev, "%s: STFIFO %x -> %x\n", __func__,
+		stfifo, stfifo | (port_info->stfifo & 0x0c180c18));
+
+	return 0;
+}
+
+static int siu_pcm_rd_set(struct siu_port *port_info,
+			  dma_addr_t buff, size_t size)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	struct siu_stream *siu_stream = &port_info->capture;
+	struct snd_pcm_substream *substream = siu_stream->substream;
+	struct device *dev = substream->pcm->card->dev;
+	struct dma_async_tx_descriptor *desc;
+	dma_cookie_t cookie;
+	struct scatterlist sg;
+	u32 stfifo;
+
+	dev_dbg(dev, "%s: %u@%llx\n", __func__, size, (unsigned long long)buff);
+
+	sg_init_table(&sg, 1);
+	sg_set_page(&sg, pfn_to_page(PFN_DOWN(buff)),
+		    size, offset_in_page(buff));
+	sg_dma_address(&sg) = buff;
+
+	desc = siu_stream->chan->device->device_prep_slave_sg(siu_stream->chan,
+		&sg, 1, DMA_FROM_DEVICE, DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		dev_err(dev, "Failed to allocate dma descriptor\n");
+		return -ENOMEM;
+	}
+
+	desc->callback = siu_dma_tx_complete;
+	desc->callback_param = siu_stream;
+	cookie = desc->tx_submit(desc);
+	if (cookie < 0) {
+		dev_err(dev, "Failed to submit dma descriptor\n");
+		return cookie;
+	}
+
+	siu_stream->tx_desc = desc;
+	siu_stream->cookie = cookie;
+
+	dma_async_issue_pending(siu_stream->chan);
+
+	/* only input FIFO enable */
+	stfifo = siu_read32(base + SIU_STFIFO);
+	siu_write32(base + SIU_STFIFO, siu_read32(base + SIU_STFIFO) |
+		    (port_info->stfifo & 0x13071307));
+	dev_dbg(dev, "%s: STFIFO %x -> %x\n", __func__,
+		stfifo, stfifo | (port_info->stfifo & 0x13071307));
+
+	return 0;
+}
+
+static void siu_io_tasklet(unsigned long data)
+{
+	struct siu_stream *siu_stream = (struct siu_stream *)data;
+	struct snd_pcm_substream *substream = siu_stream->substream;
+	struct device *dev = substream->pcm->card->dev;
+	struct snd_pcm_runtime *rt = substream->runtime;
+	struct siu_port *port_info = siu_port_info(substream);
+
+	dev_dbg(dev, "%s: flags %x\n", __func__, siu_stream->rw_flg);
+
+	if (!siu_stream->rw_flg) {
+		dev_dbg(dev, "%s: stream inactive\n", __func__);
+		return;
+	}
+
+	if (substream->stream = SNDRV_PCM_STREAM_CAPTURE) {
+		dma_addr_t buff;
+		size_t count;
+		u8 *virt;
+
+		buff = (dma_addr_t)PERIOD_OFFSET(rt->dma_addr,
+						siu_stream->cur_period,
+						siu_stream->period_bytes);
+		virt = PERIOD_OFFSET(rt->dma_area,
+				     siu_stream->cur_period,
+				     siu_stream->period_bytes);
+		count = siu_stream->period_bytes;
+
+		/* DMA transfer start */
+		siu_pcm_rd_set(port_info, buff, count);
+	} else {
+		siu_pcm_wr_set(port_info,
+			       (dma_addr_t)PERIOD_OFFSET(rt->dma_addr,
+						siu_stream->cur_period,
+						siu_stream->period_bytes),
+			       siu_stream->period_bytes);
+	}
+}
+
+/* Capture */
+static int siu_pcm_stmread_start(struct siu_port *port_info)
+{
+	struct siu_stream *siu_stream = &port_info->capture;
+
+	if (siu_stream->xfer_cnt > 0x1000000)
+		return -EINVAL;
+	if (siu_stream->rw_flg)
+		return -EPERM;
+
+	/* Current period in buffer */
+	siu_stream->cur_period = 0;
+
+	/* during stmread flag set */
+	siu_stream->rw_flg = RWF_STM_RD;
+
+	tasklet_schedule(&siu_stream->tasklet);
+
+	return 0;
+}
+
+static int siu_pcm_stmread_stop(struct siu_port *port_info)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	struct siu_stream *siu_stream = &port_info->capture;
+	struct device *dev = siu_stream->substream->pcm->card->dev;
+	u32 stfifo;
+
+	if (!siu_stream->rw_flg)
+		return -EPERM;
+
+	/* input FIFO disable */
+	stfifo = siu_read32(base + SIU_STFIFO);
+	siu_write32(base + SIU_STFIFO, stfifo & ~0x13071307);
+	dev_dbg(dev, "%s: STFIFO %x -> %x\n", __func__,
+		stfifo, stfifo & ~0x13071307);
+
+	/* during stmread flag clear */
+	siu_stream->rw_flg = 0;
+
+	return 0;
+}
+
+static int siu_pcm_hw_params(struct snd_pcm_substream *ss,
+			     struct snd_pcm_hw_params *hw_params)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct device *dev = ss->pcm->card->dev;
+	int ret;
+
+	dev_dbg(dev, "%s: port=%d\n", __func__, info->port_id);
+
+	ret = snd_pcm_lib_malloc_pages(ss, params_buffer_bytes(hw_params));
+	if (ret < 0)
+		dev_err(dev, "snd_pcm_lib_malloc_pages() failed\n");
+
+	return ret;
+}
+
+static int siu_pcm_hw_free(struct snd_pcm_substream *ss)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_port	*port_info = siu_port_info(ss);
+	struct device *dev = ss->pcm->card->dev;
+	struct siu_stream *siu_stream;
+
+	if (ss->stream = SNDRV_PCM_STREAM_PLAYBACK)
+		siu_stream = &port_info->playback;
+	else
+		siu_stream = &port_info->capture;
+
+	dev_dbg(dev, "%s: port=%d\n", __func__, info->port_id);
+
+	return snd_pcm_lib_free_pages(ss);
+}
+
+static bool filter(struct dma_chan *chan, void *slave)
+{
+	struct sh_dmae_slave *param = slave;
+
+	pr_debug("%s: slave ID %d\n", __func__, param->slave_id);
+
+	if (unlikely(param->dma_dev != chan->device->dev))
+		return false;
+
+	chan->private = param;
+	return true;
+}
+
+static int siu_pcm_open(struct snd_pcm_substream *ss)
+{
+	/* Playback / Capture */
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_port *port_info = siu_port_info(ss);
+	struct siu_stream *siu_stream;
+	u32 port = info->port_id;
+	struct siu_platform *pdata = siu_i2s_dai.dev->platform_data;
+	struct device *dev = ss->pcm->card->dev;
+	dma_cap_mask_t mask;
+	struct sh_dmae_slave *param;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	dev_dbg(dev, "%s, port=%d@%p\n", __func__, port, port_info);
+
+	if (ss->stream = SNDRV_PCM_STREAM_PLAYBACK) {
+		siu_stream = &port_info->playback;
+		param = &siu_stream->param;
+		param->slave_id = port ? SHDMA_SLAVE_SIUB_TX :
+			SHDMA_SLAVE_SIUA_TX;
+	} else {
+		siu_stream = &port_info->capture;
+		param = &siu_stream->param;
+		param->slave_id = port ? SHDMA_SLAVE_SIUB_RX :
+			SHDMA_SLAVE_SIUA_RX;
+	}
+
+	param->dma_dev = pdata->dma_dev;
+	/* Get DMA channel */
+	siu_stream->chan = dma_request_channel(mask, filter, param);
+	if (!siu_stream->chan) {
+		dev_err(dev, "DMA channel allocation failed!\n");
+		return -EBUSY;
+	}
+
+	siu_stream->substream = ss;
+
+	return 0;
+}
+
+static int siu_pcm_close(struct snd_pcm_substream *ss)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct device *dev = ss->pcm->card->dev;
+	struct siu_port *port_info = siu_port_info(ss);
+	struct siu_stream *siu_stream;
+
+	dev_dbg(dev, "%s: port=%d\n", __func__, info->port_id);
+
+	if (ss->stream = SNDRV_PCM_STREAM_PLAYBACK)
+		siu_stream = &port_info->playback;
+	else
+		siu_stream = &port_info->capture;
+
+	dma_release_channel(siu_stream->chan);
+	siu_stream->chan = NULL;
+
+	siu_stream->substream = NULL;
+
+	return 0;
+}
+
+static int siu_pcm_prepare(struct snd_pcm_substream *ss)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct siu_port *port_info = siu_port_info(ss);
+	struct device *dev = ss->pcm->card->dev;
+	struct snd_pcm_runtime 	*rt = ss->runtime;
+	struct siu_stream *siu_stream;
+	snd_pcm_sframes_t xfer_cnt;
+
+	if (ss->stream = SNDRV_PCM_STREAM_PLAYBACK)
+		siu_stream = &port_info->playback;
+	else
+		siu_stream = &port_info->capture;
+
+	rt = siu_stream->substream->runtime;
+
+	siu_stream->buf_bytes = snd_pcm_lib_buffer_bytes(ss);
+	siu_stream->period_bytes = snd_pcm_lib_period_bytes(ss);
+
+	dev_dbg(dev, "%s: port=%d, %d channels, period=%u bytes\n", __func__,
+		info->port_id, rt->channels, siu_stream->period_bytes);
+
+	/* We only support buffers that are multiples of the period */
+	if (siu_stream->buf_bytes % siu_stream->period_bytes) {
+		dev_err(dev, "%s() - buffer=%d not multiple of period=%d\n",
+		       __func__, siu_stream->buf_bytes,
+		       siu_stream->period_bytes);
+		return -EINVAL;
+	}
+
+	xfer_cnt = bytes_to_frames(rt, siu_stream->period_bytes);
+	if (!xfer_cnt || xfer_cnt > 0x1000000)
+		return -EINVAL;
+
+	siu_stream->format = rt->format;
+	siu_stream->xfer_cnt = xfer_cnt;
+
+	dev_dbg(dev, "port=%d buf=%lx buf_bytes=%d period_bytes=%d "
+		"format=%d channels=%d xfer_cnt=%d\n", info->port_id,
+		(unsigned long)rt->dma_addr, siu_stream->buf_bytes,
+		siu_stream->period_bytes,
+		siu_stream->format, rt->channels, (int)xfer_cnt);
+
+	return 0;
+}
+
+static int siu_pcm_trigger(struct snd_pcm_substream *ss, int cmd)
+{
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct device *dev = ss->pcm->card->dev;
+	struct siu_port *port_info = siu_port_info(ss);
+	int ret;
+
+	dev_dbg(dev, "%s: port=%d@%p, cmd=%d\n", __func__,
+		info->port_id, port_info, cmd);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+		if (ss->stream = SNDRV_PCM_STREAM_PLAYBACK)
+			ret = siu_pcm_stmwrite_start(port_info);
+		else
+			ret = siu_pcm_stmread_start(port_info);
+
+		if (ret < 0)
+			dev_warn(dev, "%s: start failed on port=%d\n",
+				 __func__, info->port_id);
+
+		break;
+	case SNDRV_PCM_TRIGGER_STOP:
+		if (ss->stream = SNDRV_PCM_STREAM_PLAYBACK)
+			siu_pcm_stmwrite_stop(port_info);
+		else
+			siu_pcm_stmread_stop(port_info);
+		ret = 0;
+
+		break;
+	default:
+		dev_err(dev, "%s() unsupported cmd=%d\n", __func__, cmd);
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+/*
+ * So far only resolution of one period is supported, subject to extending the
+ * dmangine API
+ */
+static snd_pcm_uframes_t siu_pcm_pointer_dma(struct snd_pcm_substream *ss)
+{
+	struct device *dev = ss->pcm->card->dev;
+	struct siu_info *info = siu_i2s_dai.private_data;
+	u32 __iomem *base = info->reg;
+	struct siu_port *port_info = siu_port_info(ss);
+	struct snd_pcm_runtime *rt = ss->runtime;
+	size_t ptr;
+	struct siu_stream *siu_stream;
+
+	if (ss->stream = SNDRV_PCM_STREAM_PLAYBACK)
+		siu_stream = &port_info->playback;
+	else
+		siu_stream = &port_info->capture;
+
+	/*
+	 * ptr is the offset into the buffer where the dma is currently at. We
+	 * check if the dma buffer has just wrapped.
+	 */
+	ptr = PERIOD_OFFSET(rt->dma_addr,
+			    siu_stream->cur_period,
+			    siu_stream->period_bytes) - rt->dma_addr;
+
+	dev_dbg(dev,
+		"%s: port=%d, events %x, FSTS %x, xferred %u/%u, cookie %d\n",
+		__func__, info->port_id, siu_read32(base + SIU_EVNTC),
+		siu_read32(base + SIU_SBFSTS), ptr, siu_stream->buf_bytes,
+		siu_stream->cookie);
+
+	if (ptr >= siu_stream->buf_bytes)
+		ptr = 0;
+
+	return bytes_to_frames(ss->runtime, ptr);
+}
+
+static int siu_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+		       struct snd_pcm *pcm)
+{
+	/* card->dev = socdev->dev, see snd_soc_new_pcms() */
+	struct siu_info *info = siu_i2s_dai.private_data;
+	struct platform_device *pdev = to_platform_device(card->dev);
+	int ret;
+	int i;
+
+	/* pdev->id selects between SIUA and SIUB */
+	if (pdev->id < 0 || pdev->id >= SIU_PORT_NUM)
+		return -EINVAL;
+
+	info->port_id = pdev->id;
+
+	/*
+	 * While the siu has 2 ports, only one port can be on at a time (only 1
+	 * SPB). So far all the boards using the siu had only one of the ports
+	 * wired to a codec. To simplify things, we only register one port with
+	 * alsa. In case both ports are needed, it should be changed here
+	 */
+	for (i = pdev->id; i < pdev->id + 1; i++) {
+		struct siu_port **port_info = &siu_ports[i];
+
+		ret = siu_init_port(i, port_info, card);
+		if (ret < 0)
+			return ret;
+
+		ret = snd_pcm_lib_preallocate_pages_for_all(pcm,
+				SNDRV_DMA_TYPE_DEV, NULL,
+				SIU_BUFFER_BYTES_MAX, SIU_BUFFER_BYTES_MAX);
+		if (ret < 0) {
+			dev_err(card->dev,
+			       "snd_pcm_lib_preallocate_pages_for_all() err=%d",
+				ret);
+			goto fail;
+		}
+
+		(*port_info)->pcm = pcm;
+
+		/* IO tasklets */
+		tasklet_init(&(*port_info)->playback.tasklet, siu_io_tasklet,
+			     (unsigned long)&(*port_info)->playback);
+		tasklet_init(&(*port_info)->capture.tasklet, siu_io_tasklet,
+			     (unsigned long)&(*port_info)->capture);
+	}
+
+	dev_info(card->dev, "SuperH SIU driver initialized.\n");
+	return 0;
+
+fail:
+	siu_free_port(siu_ports[pdev->id]);
+	dev_err(card->dev, "SIU: failed to initialize.\n");
+	return ret;
+}
+
+static void siu_pcm_free(struct snd_pcm *pcm)
+{
+	struct platform_device *pdev = to_platform_device(pcm->card->dev);
+	struct siu_port *port_info = siu_ports[pdev->id];
+
+	tasklet_kill(&port_info->capture.tasklet);
+	tasklet_kill(&port_info->playback.tasklet);
+
+	siu_free_port(port_info);
+	snd_pcm_lib_preallocate_free_for_all(pcm);
+
+	dev_dbg(pcm->card->dev, "%s\n", __func__);
+}
+
+static struct snd_pcm_ops siu_pcm_ops = {
+	.open		= siu_pcm_open,
+	.close		= siu_pcm_close,
+	.ioctl		= snd_pcm_lib_ioctl,
+	.hw_params	= siu_pcm_hw_params,
+	.hw_free	= siu_pcm_hw_free,
+	.prepare	= siu_pcm_prepare,
+	.trigger	= siu_pcm_trigger,
+	.pointer	= siu_pcm_pointer_dma,
+};
+
+struct snd_soc_platform siu_platform = {
+	.name		= "siu-audio",
+	.pcm_ops 	= &siu_pcm_ops,
+	.pcm_new	= siu_pcm_new,
+	.pcm_free	= siu_pcm_free,
+};
+EXPORT_SYMBOL_GPL(siu_platform);
