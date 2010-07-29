From: Andrew Murray <amurray@mpcdata.com>
Date: Thu, 29 Jul 2010 11:50:59 +0000
Subject: [PATCH] sh: Remove memset from coherent memory allocator (for
Message-Id: <AANLkTi=0=kR49SHE8mistKJ0hPpjwUk=xXSMw=K_i9Ne@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Andrew Murray <amurray@mpc-data.co.uk>

This patch removes unnecessary memset in coherent memory allocator.

Signed-off-by: Andrew Murray <amurray@mpc-data.co.uk>
---
--- linux-2.6-old/arch/sh/mm/consistent.c       2010-07-25
05:01:33.813493496 +0100
+++ linux-2.6/arch/sh/mm/consistent.c   2010-07-25 05:03:42.763055056 +0100
@@ -42,7 +42,6 @@ void *dma_generic_alloc_coherent(struct
        if (!ret)
                return NULL;

-       memset(ret, 0, size);
        /*
         * Pages from the page allocator may have data present in
         * cache. So flush the cache before using uncached memory.
@@ -141,7 +140,7 @@ int __init platform_resource_setup_memor
        if (!memsize)
                return 0;

-       buf = dma_alloc_coherent(NULL, memsize, &dma_handle, GFP_KERNEL);
+       buf = dma_alloc_coherent(NULL, memsize, &dma_handle,
GFP_KERNEL | __GFP_ZERO);
        if (!buf) {
                pr_warning("%s: unable to allocate memory\n", name);
                return -ENOMEM;
