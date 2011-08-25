From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Aug 2011 04:05:03 +0000
Subject: [PATCH 2/7] fbdev: sh_mipi_dsi: tidyup VMCTR2 parameter expression
Message-Id: <87zkiyt9uc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

VMCTR2 parameter will be supported more in the future.
1 << xx style is easy to understand.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 8f17efc..3b408b7 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -316,9 +316,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 * HSA period allowed, no commands in LP
 	 */
 	if (pdata->flags & SH_MIPI_DSI_HSABM)
-		vmctr2 |= 0x20;
+		vmctr2 |= 1 << 5;
 	if (pdata->flags & SH_MIPI_DSI_HBPBM)
-		vmctr2 |= 0x10;
+		vmctr2 |= 1 << 4;
 	iowrite32(vmctr2, mipi->linkbase + VMCTR2);
 
 	/*
-- 
1.7.4.1

