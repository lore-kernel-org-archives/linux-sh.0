From: Christoph Hellwig <hch@lst.de>
Date: Tue, 14 Jul 2020 12:18:53 +0000
Subject: [PATCH 07/10] sh: unexport register_trapped_io and match_trapped_io_handler
Message-Id: <20200714121856.955680-8-hch@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
In-Reply-To: <20200714121856.955680-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Both functions are only used by compiled in core code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/sh/kernel/io_trapped.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index 037aab2708b7ac..004ad0130b1038 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -102,7 +102,6 @@ int register_trapped_io(struct trapped_io *tiop)
 	pr_warn("unable to install trapped io filter\n");
 	return -1;
 }
-EXPORT_SYMBOL_GPL(register_trapped_io);
 
 void __iomem *match_trapped_io_handler(struct list_head *list,
 				       unsigned long offset,
@@ -131,7 +130,6 @@ void __iomem *match_trapped_io_handler(struct list_head *list,
 	spin_unlock_irqrestore(&trapped_lock, flags);
 	return NULL;
 }
-EXPORT_SYMBOL_GPL(match_trapped_io_handler);
 
 static struct trapped_io *lookup_tiop(unsigned long address)
 {
-- 
2.26.2
