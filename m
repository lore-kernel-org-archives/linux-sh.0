From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 02 Aug 2013 14:50:38 +0000
Subject: [PATCH v5 3/7] DMA: shdma: add a header with common for ARM SoCs defines
Message-Id: <1375455042-24093-4-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1375455042-24093-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Vinod Koul <vinod.koul@intel.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

All shdma DMACs on ARM SoCs share certain register layout patterns, which
are currently defined in arch/arm/mach-shmobile/include/mach/dma-register.h.
That header is included by SoC-specific setup-*.c files to be used in DMAC
platform data. That header, however, cannot be directly used by the driver.
This patch copies those defines into a driver-local header to be used by
Device Tree configurations.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 drivers/dma/sh/shdma-arm.h |   51 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 drivers/dma/sh/shdma-arm.h

diff --git a/drivers/dma/sh/shdma-arm.h b/drivers/dma/sh/shdma-arm.h
new file mode 100644
index 0000000..a2b8258
--- /dev/null
+++ b/drivers/dma/sh/shdma-arm.h
@@ -0,0 +1,51 @@
+/*
+ * Renesas SuperH DMA Engine support
+ *
+ * Copyright (C) 2013 Renesas Electronics, Inc.
+ *
+ * This is free software; you can redistribute it and/or modify it under the
+ * terms of version 2 the GNU General Public License as published by the Free
+ * Software Foundation.
+ */
+
+#ifndef SHDMA_ARM_H
+#define SHDMA_ARM_H
+
+#include "shdma.h"
+
+/* Transmit sizes and respective CHCR register values */
+enum {
+	XMIT_SZ_8BIT		= 0,
+	XMIT_SZ_16BIT		= 1,
+	XMIT_SZ_32BIT		= 2,
+	XMIT_SZ_64BIT		= 7,
+	XMIT_SZ_128BIT		= 3,
+	XMIT_SZ_256BIT		= 4,
+	XMIT_SZ_512BIT		= 5,
+};
+
+/* log2(size / 8) - used to calculate number of transfers */
+#define SH_DMAE_TS_SHIFT {		\
+	[XMIT_SZ_8BIT]		= 0,	\
+	[XMIT_SZ_16BIT]		= 1,	\
+	[XMIT_SZ_32BIT]		= 2,	\
+	[XMIT_SZ_64BIT]		= 3,	\
+	[XMIT_SZ_128BIT]	= 4,	\
+	[XMIT_SZ_256BIT]	= 5,	\
+	[XMIT_SZ_512BIT]	= 6,	\
+}
+
+#define TS_LOW_BIT	0x3 /* --xx */
+#define TS_HI_BIT	0xc /* xx-- */
+
+#define TS_LOW_SHIFT	(3)
+#define TS_HI_SHIFT	(20 - 2)	/* 2 bits for shifted low TS */
+
+#define TS_INDEX2VAL(i) \
+	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
+	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
+
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+
+#endif
-- 
1.7.2.5

