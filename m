From: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date: Sun, 28 Oct 2018 07:10:56 +0000
Subject: [PATCH] arch/sh/mm/consistent.c: Use dma_zalloc_coherent
Message-Id: <5bd55e34.1c69fb81.b2503.b6f5@mx.google.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org, thomas.petazzoni@free-electrons.com, robin.murphy@arm.com, jacopo+renesas@jmondi.org
Cc: jrdr.linux@gmail.com, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com

Replaced dma_alloc_coherent + memset with dma_zalloc_coherant

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/sh/mm/consistent.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sh/mm/consistent.c b/arch/sh/mm/consistent.c
index 792f361..fc8d235 100644
--- a/arch/sh/mm/consistent.c
+++ b/arch/sh/mm/consistent.c
@@ -52,13 +52,12 @@ int __init platform_resource_setup_memory(struct platform_device *pdev,
 	if (!memsize)
 		return 0;
 
-	buf = dma_alloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
+	buf = dma_zalloc_coherent(&pdev->dev, memsize, &dma_handle, GFP_KERNEL);
 	if (!buf) {
 		pr_warning("%s: unable to allocate memory\n", name);
 		return -ENOMEM;
 	}
 
-	memset(buf, 0, memsize);
 
 	r->flags = IORESOURCE_MEM;
 	r->start = dma_handle;
-- 
2.7.4
