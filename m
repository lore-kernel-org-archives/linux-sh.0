From: Joe Perches <joe@perches.com>
Date: Sun, 15 Jun 2014 20:37:31 +0000
Subject: [PATCH -next 02/26] sh: Use dma_zalloc_coherent
Message-Id: <a2cbba7f6f113ab867a42069ada3d30faeb5e12a.1402863905.git.joe@perches.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1402863904.git.joe@perches.com>
In-Reply-To: <cover.1402863904.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Use the zeroing function instead of dma_alloc_coherent & memset(,0,)

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/sh/mm/consistent.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index b81d9db..3d710da 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -143,14 +143,12 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 	if (!memsize)
 		return 0;
 
-	buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
+	buf = dma_zalloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
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
1.8.1.2.459.gbcd45b4.dirty

