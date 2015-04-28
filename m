From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 28 Apr 2015 10:21:40 +0000
Subject: [PATCH] dmaengine: Remove Renesas Audio DMAC peri peri platform data
Message-Id: <1430216500-32173-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <87oao1sjzp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oao1sjzp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit 3cd44dcd35a6 ("dmaengine: remove Renesas Audio DMAC peri peri")
forgot to remove the header file with the platform data definitions.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/platform_data/dma-rcar-audmapp.h | 34 --------------------------
 1 file changed, 34 deletions(-)
 delete mode 100644 include/linux/platform_data/dma-rcar-audmapp.h

diff --git a/include/linux/platform_data/dma-rcar-audmapp.h b/include/linux/platform_data/dma-rcar-audmapp.h
deleted file mode 100644
index 471fffebbeb4cdbe..0000000000000000
--- a/include/linux/platform_data/dma-rcar-audmapp.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * This is for Renesas R-Car Audio-DMAC-peri-peri.
- *
- * Copyright (C) 2014 Renesas Electronics Corporation
- * Copyright (C) 2014 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
- *
- * This file is based on the include/linux/sh_dma.h
- *
- * Header for the new SH dmaengine driver
- *
- * Copyright (C) 2010 Guennadi Liakhovetski <g.liakhovetski@gmx.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-#ifndef SH_AUDMAPP_H
-#define SH_AUDMAPP_H
-
-#include <linux/dmaengine.h>
-
-struct audmapp_slave_config {
-	int		slave_id;
-	dma_addr_t	src;
-	dma_addr_t	dst;
-	u32		chcr;
-};
-
-struct audmapp_pdata {
-	struct audmapp_slave_config *slave;
-	int slave_num;
-};
-
-#endif /* SH_AUDMAPP_H */
-- 
1.9.1

