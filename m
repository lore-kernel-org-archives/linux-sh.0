From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Sun, 23 Nov 2008 14:27:22 +0000
Subject: [PATCH] sh: fix DMAOR register access on SH7709
Message-Id: <1227450442-31915-2-git-send-email-steve.glendinning@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh7709 hardware manual says DMAOR is 16 bits long on this platform.

Tested and working with a modified smsc911x ethernet driver (sh-dma
support patch for this driver is coming soon).

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 arch/sh/drivers/dma/dma-sh.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.c b/arch/sh/drivers/dma/dma-sh.c
index b2ffe64..50887a5 100644
--- a/arch/sh/drivers/dma/dma-sh.c
+++ b/arch/sh/drivers/dma/dma-sh.c
@@ -205,7 +205,8 @@ static int sh_dmac_get_dma_residue(struct dma_channel *chan)
 
 #if defined(CONFIG_CPU_SUBTYPE_SH7720) || \
     defined(CONFIG_CPU_SUBTYPE_SH7721) || \
-    defined(CONFIG_CPU_SUBTYPE_SH7780)
+    defined(CONFIG_CPU_SUBTYPE_SH7780) || \
+    defined(CONFIG_CPU_SUBTYPE_SH7709)
 #define dmaor_read_reg()	ctrl_inw(DMAOR)
 #define dmaor_write_reg(data)	ctrl_outw(data, DMAOR)
 #else
-- 
1.5.6.5

