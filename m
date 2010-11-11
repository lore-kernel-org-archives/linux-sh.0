From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 11 Nov 2010 07:40:57 +0000
Subject: [PATCH 4/6] dma: shdma: increase the number of DMA descriptors and
Message-Id: <Pine.LNX.4.64.1011110834130.15747@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011110815070.15747@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-mmc@vger.kernel.org, Yusuke Goda <yusuke.goda.sx@renesas.com>, Dan Williams <dan.j.williams@intel.com>

Currently shdma only works, if it manages to allocate DMA descriptors for all
sg elements during the prepare stage. Allocation is carried out from a
static pool of 32 DMA descriptors. This is not enough for, e.g., MMC, where up
to 61 sg elements can be sent at once. Ideally we should be able to reuse
descriptors, while processing one request, but for now increase their number
to 64.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/dma/shdma.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index eb6b54d..85dd0ad 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -39,7 +39,7 @@ enum sh_dmae_desc_status {
 	DESC_WAITING,	/* callback called, waiting for ack / re-submit */
 };
 
-#define NR_DESCS_PER_CHANNEL 32
+#define NR_DESCS_PER_CHANNEL 64
 /* Default MEMCPY transfer size = 2^2 = 4 bytes */
 #define LOG2_DEFAULT_XFER_SIZE	2
 
@@ -1213,3 +1213,4 @@ module_exit(sh_dmae_exit);
 MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>");
 MODULE_DESCRIPTION("Renesas SH DMA Engine driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sh-dma-engine");
-- 
1.7.2.3

