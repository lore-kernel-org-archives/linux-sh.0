From: Thomas Schwinge <thomas@codesourcery.com>
Date: Fri, 09 Mar 2012 16:38:48 +0000
Subject: [PATCH 2/7] SH: heartbeat: restore big-endian operation.
Message-Id: <1331311133-26937-2-git-send-email-thomas@codesourcery.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the
endianess-agnostic I/O accessor functions.

I have not tested this -- the board is situated in a remote data center.

Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/drivers/heartbeat.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/drivers/heartbeat.c b/arch/sh/drivers/heartbeat.c
index 7efc9c3..b8803fd 100644
--- a/arch/sh/drivers/heartbeat.c
+++ b/arch/sh/drivers/heartbeat.c
@@ -45,16 +45,16 @@ static inline void heartbeat_toggle_bit(struct heartbeat_data *hd,
 
 	switch (hd->regsize) {
 	case 32:
-		new |= ioread32(hd->base) & ~hd->mask;
-		iowrite32(new, hd->base);
+		new |= __raw_readl(hd->base) & ~hd->mask;
+		__raw_writel(new, hd->base);
 		break;
 	case 16:
-		new |= ioread16(hd->base) & ~hd->mask;
-		iowrite16(new, hd->base);
+		new |= __raw_readw(hd->base) & ~hd->mask;
+		__raw_writew(new, hd->base);
 		break;
 	default:
-		new |= ioread8(hd->base) & ~hd->mask;
-		iowrite8(new, hd->base);
+		new |= __raw_readb(hd->base) & ~hd->mask;
+		__raw_writeb(new, hd->base);
 		break;
 	}
 }
-- 
1.7.4.1

