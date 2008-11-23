From: Steve Glendinning <steve.glendinning@smsc.com>
Date: Sun, 23 Nov 2008 15:00:31 +0000
Subject: [PATCH] sh: add SH DMAC burst mode constant
Message-Id: <1227452431-16324-1-git-send-email-steve.glendinning@smsc.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The SH7709 datasheet defines bit 5 as set for burst mode, clear for
cycle-steal mode.

Signed-off-by: Steve Glendinning <steve.glendinning@smsc.com>
---
 arch/sh/drivers/dma/dma-sh.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/drivers/dma/dma-sh.h b/arch/sh/drivers/dma/dma-sh.h
index b05af34..05fecd5 100644
--- a/arch/sh/drivers/dma/dma-sh.h
+++ b/arch/sh/drivers/dma/dma-sh.h
@@ -29,6 +29,7 @@
 #define RS_IN	0x00000200
 #define RS_OUT	0x00000300
 #define TS_BLK	0x00000040
+#define TM_BUR	0x00000020
 #define CHCR_DE 0x00000001
 #define CHCR_TE 0x00000002
 #define CHCR_IE 0x00000004
-- 
1.5.6.5

