From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Aug 2013 14:50:39 +0000
Subject: [PATCH v5 4/7] DMA: shdma: add r8a73a4 DMAC data to the device ID table
Message-Id: <1375455042-24093-5-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

This configuration data will be used, when DMAC DT support is added to
r8a73a4.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

v5:
1. don't include mach/*.h headers
2. don't change the C-case
3. don't include unrelated patches
4. include only one architecture
5. don't use slave addresses and IDs in slave lists

 drivers/dma/sh/Kconfig         |    4 ++
 drivers/dma/sh/Makefile        |    3 ++
 drivers/dma/sh/shdma-r8a73a4.c |   77 ++++++++++++++++++++++++++++++++++++++++
 drivers/dma/sh/shdma.h         |    7 ++++
 drivers/dma/sh/shdmac.c        |    1 +
 5 files changed, 92 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/sh/shdma-r8a73a4.c

diff --git a/drivers/dma/sh/Kconfig b/drivers/dma/sh/Kconfig
index 5c1dee2..d0924b6 100644
--- a/drivers/dma/sh/Kconfig
+++ b/drivers/dma/sh/Kconfig
@@ -22,3 +22,7 @@ config SUDMAC
 	depends on SH_DMAE_BASE
 	help
 	  Enable support for the Renesas SUDMAC controllers.
+
+config SHDMA_R8A73A4
+	def_bool y
+	depends on ARCH_R8A73A4 && SH_DMAE != n
diff --git a/drivers/dma/sh/Makefile b/drivers/dma/sh/Makefile
index 893ee09..05a31d4 100644
--- a/drivers/dma/sh/Makefile
+++ b/drivers/dma/sh/Makefile
@@ -1,5 +1,8 @@
 obj-$(CONFIG_SH_DMAE_BASE) += shdma-base.o shdma-of.o
 obj-$(CONFIG_SH_DMAE) += shdma.o
 shdma-y := shdmac.o
+ifeq ($(CONFIG_OF),y)
+shdma-$(CONFIG_SHDMA_R8A73A4) += shdma-r8a73a4.o
+endif
 shdma-objs := $(shdma-y)
 obj-$(CONFIG_SUDMAC) += sudmac.o
diff --git a/drivers/dma/sh/shdma-r8a73a4.c b/drivers/dma/sh/shdma-r8a73a4.c
new file mode 100644
index 0000000..7cad656
--- /dev/null
+++ b/drivers/dma/sh/shdma-r8a73a4.c
@@ -0,0 +1,77 @@
+/*
+ * Renesas SuperH DMA Engine support for r8a73a4 (APE6) SoCs
+ *
+ * Copyright (C) 2013 Renesas Electronics, Inc.
+ *
+ * This is free software; you can redistribute it and/or modify it under the
+ * terms of version 2 the GNU General Public License as published by the Free
+ * Software Foundation.
+ */
+#include <linux/sh_dma.h>
+
+#include "shdma-arm.h"
+
+const unsigned int dma_ts_shift[] = SH_DMAE_TS_SHIFT;
+
+static const struct sh_dmae_slave_config dma_slaves[] = {
+	{
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd1,		/* MMC0 Tx */
+	}, {
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xd2,		/* MMC0 Rx */
+	}, {
+		.chcr		= CHCR_TX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xe1,		/* MMC1 Tx */
+	}, {
+		.chcr		= CHCR_RX(XMIT_SZ_32BIT),
+		.mid_rid	= 0xe2,		/* MMC1 Rx */
+	},
+};
+
+#define DMAE_CHANNEL(a, b)				\
+	{						\
+		.offset         = (a) - 0x20,		\
+		.dmars          = (a) - 0x20 + 0x40,	\
+		.chclr_bit	= (b),			\
+		.chclr_offset	= 0x80 - 0x20,		\
+	}
+
+static const struct sh_dmae_channel dma_channels[] = {
+	DMAE_CHANNEL(0x8000, 0),
+	DMAE_CHANNEL(0x8080, 1),
+	DMAE_CHANNEL(0x8100, 2),
+	DMAE_CHANNEL(0x8180, 3),
+	DMAE_CHANNEL(0x8200, 4),
+	DMAE_CHANNEL(0x8280, 5),
+	DMAE_CHANNEL(0x8300, 6),
+	DMAE_CHANNEL(0x8380, 7),
+	DMAE_CHANNEL(0x8400, 8),
+	DMAE_CHANNEL(0x8480, 9),
+	DMAE_CHANNEL(0x8500, 10),
+	DMAE_CHANNEL(0x8580, 11),
+	DMAE_CHANNEL(0x8600, 12),
+	DMAE_CHANNEL(0x8680, 13),
+	DMAE_CHANNEL(0x8700, 14),
+	DMAE_CHANNEL(0x8780, 15),
+	DMAE_CHANNEL(0x8800, 16),
+	DMAE_CHANNEL(0x8880, 17),
+	DMAE_CHANNEL(0x8900, 18),
+	DMAE_CHANNEL(0x8980, 19),
+};
+
+const struct sh_dmae_pdata r8a73a4_dma_pdata = {
+	.slave		= dma_slaves,
+	.slave_num	= ARRAY_SIZE(dma_slaves),
+	.channel	= dma_channels,
+	.channel_num	= ARRAY_SIZE(dma_channels),
+	.ts_low_shift	= TS_LOW_SHIFT,
+	.ts_low_mask	= TS_LOW_BIT << TS_LOW_SHIFT,
+	.ts_high_shift	= TS_HI_SHIFT,
+	.ts_high_mask	= TS_HI_BIT << TS_HI_SHIFT,
+	.ts_shift	= dma_ts_shift,
+	.ts_shift_num	= ARRAY_SIZE(dma_ts_shift),
+	.dmaor_init     = DMAOR_DME,
+	.chclr_present	= 1,
+	.chclr_bitwise	= 1,
+};
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index ff2f93b..5210900 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -62,4 +62,11 @@ struct sh_dmae_desc {
 #define to_sh_dev(chan) container_of(chan->shdma_chan.dma_chan.device,\
 				     struct sh_dmae_device, shdma_dev.dma_dev)
 
+#ifdef CONFIG_SHDMA_R8A73A4
+extern const struct sh_dmae_pdata r8a73a4_dma_pdata;
+#define r8a73a4_shdma_devid &r8a73a4_dma_pdata
+#else
+#define r8a73a4_shdma_devid NULL
+#endif
+
 #endif	/* __DMA_SHDMA_H */
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 4412cad..bf16b3d 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -677,6 +677,7 @@ static const struct shdma_ops sh_dmae_shdma_ops = {
 };
 
 static const struct of_device_id sh_dmae_of_match[] = {
+	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
 	{}
 };
 MODULE_DEVICE_TABLE(of, sh_dmae_of_match);
-- 
1.7.2.5

