From: zhong jiang <zhongjiang@huawei.com>
Date: Mon, 10 Sep 2018 02:55:04 +0000
Subject: [PATCH] sh: mm: Use dma_zalloc_coherent instead of dma_alloc_coherent + memset
Message-Id: <1536548104-57453-1-git-send-email-zhongjiang@huawei.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dalias@libc.org, ysato@users.sourceforge.jp
Cc: robin.murphy@arm.com, thomas.petazzoni@free-electrons.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

dma_zalloc_coherent has taken the dma_alloc_coherent() and memset() into
account. Therefore, just use dma_zalloc_coherent to replace the open code.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
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
1.7.12.4
