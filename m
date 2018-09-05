From: Ding Xiang <dingxiang@cmss.chinamobile.com>
Date: Wed, 05 Sep 2018 07:38:46 +0000
Subject: [PATCH] arch: sh: Replace dma_alloc_coherent/memset with dma_zalloc_coherent
Message-Id: <1536133126-21017-1-git-send-email-dingxiang@cmss.chinamobile.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dingxiang@cmss.chinamobile.com

use dma_zalloc_coherent instead of dma_alloc_coherent/memset

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 arch/sh/mm/consistent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f361..aa4e450 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -52,14 +52,12 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 	if (!memsize)
 		return 0;
 
-	buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
+	buf = dma_zalloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
 		pr_warning("%s: unable to allocate memory\n", name);
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
-
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
 	r->end = r->start + memsize - 1;
-- 
1.9.1
