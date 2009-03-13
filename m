From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Fri, 13 Mar 2009 04:31:34 +0000
Subject: [PATCH] sh: Fix problem that get_dma_error_irq is compiled in SH3
Message-Id: <49B9E1A6.2010602@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

get_dma_error_irq() used in dma-sh is function for exclusive use of SH4.
SH3 doesn't have DMA Error interrupt.
This fixes it to compile it only in SH4.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/drivers/dma/dma-sh.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index ab7b18d..31c2930 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -280,6 +280,7 @@ static struct dma_info sh_dmac_info = {
 	.flags		= DMAC_CHANNELS_TEI_CAPABLE,
 };

+#ifdef CONFIG_CPU_SH4
 static unsigned int get_dma_error_irq(int n)
 {
 #if defined(DMAC_IRQ_MULTI)
@@ -293,6 +294,7 @@ static unsigned int get_dma_error_irq(int n)
 #endif
 #endif
 }
+#endif

 static int __init sh_dmac_init(void)
 {
-- 
1.6.2

