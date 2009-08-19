From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Wed, 19 Aug 2009 10:24:15 +0000
Subject: [PATCH] sh: Add SH7724 support to NR_ONCHIP_DMA_CHANNELS
Message-Id: <uocqc5cfk.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch also update help comment

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/drivers/dma/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/drivers/dma/Kconfig b/arch/sh/drivers/dma/Kconfig
index 63e9dd3..b91fa8d 100644
--- a/arch/sh/drivers/dma/Kconfig
+++ b/arch/sh/drivers/dma/Kconfig
@@ -27,12 +27,12 @@ config NR_ONCHIP_DMA_CHANNELS
 	default "8" if CPU_SUBTYPE_SH7750R || CPU_SUBTYPE_SH7751R || \
 		       CPU_SUBTYPE_SH7760
 	default "12" if CPU_SUBTYPE_SH7723 || CPU_SUBTYPE_SH7780  || \
-			CPU_SUBTYPE_SH7785
+			CPU_SUBTYPE_SH7785 || CPU_SUBTYPE_SH7724
 	default "6"
 	help
 	  This allows you to specify the number of channels that the on-chip
-	  DMAC supports. This will be 4 for SH7091/SH7750/SH7751 and 8 for the
-	  SH7750R/SH7751R.
+	  DMAC supports. This will be 4 for SH7750/SH7751/Sh7750S/SH7091 and 8 for the
+	  SH7750R/SH7751R/SH7760, 12 for the SH7723/SH7780/SH7785/SH7724, default is 6.
 
 config NR_DMA_CHANNELS_BOOL
 	depends on SH_DMA
-- 
1.6.0.4

