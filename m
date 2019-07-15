From: Fuqian Huang <huangfq.daxian@gmail.com>
Date: Mon, 15 Jul 2019 03:16:54 +0000
Subject: [PATCH v3 01/24] sh: mm: Remove call to memset after dma_alloc_coherent
Message-Id: <20190715031654.6223-1-huangfq.daxian@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Fuqian Huang <huangfq.daxian@gmail.com>

In commit 518a2f1925c3
("dma-mapping: zero memory returned from dma_alloc_*"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
Changes in v3:
  - Use actual commit rather than the merge commit in the commit message

 arch/sh/mm/consistent.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f36129062..b09510adfae9 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -58,8 +58,6 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
2.11.0
