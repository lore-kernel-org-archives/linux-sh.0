From: Alexander Duyck <alexander.h.duyck@intel.com>
Date: Wed, 02 Nov 2016 11:15:27 +0000
Subject: [mm PATCH v2 19/26] arch/sh: Add option to skip DMA sync as a part of mapping
Message-Id: <20161102111524.79519.9840.stgit@ahduyck-blue-test.jf.intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20161102111031.79519.14741.stgit@ahduyck-blue-test.jf.intel.com>
In-Reply-To: <20161102111031.79519.14741.stgit@ahduyck-blue-test.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org, akpm@linux-foundation.org
Cc: netdev@vger.kernel.org, Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org

This change allows us to pass DMA_ATTR_SKIP_CPU_SYNC which allows us to
avoid invoking cache line invalidation if the driver will just handle it
via a sync_for_cpu or sync_for_device call.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
---
 arch/sh/kernel/dma-nommu.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/sh/kernel/dma-nommu.c b/arch/sh/kernel/dma-nommu.c
index eadb669..47fee3b 100644
--- a/arch/sh/kernel/dma-nommu.c
+++ b/arch/sh/kernel/dma-nommu.c
@@ -18,7 +18,9 @@ static dma_addr_t nommu_map_page(struct device *dev, struct page *page,
 	dma_addr_t addr = page_to_phys(page) + offset;
 
 	WARN_ON(size = 0);
-	dma_cache_sync(dev, page_address(page) + offset, size, dir);
+
+	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+		dma_cache_sync(dev, page_address(page) + offset, size, dir);
 
 	return addr;
 }
@@ -35,7 +37,8 @@ static int nommu_map_sg(struct device *dev, struct scatterlist *sg,
 	for_each_sg(sg, s, nents, i) {
 		BUG_ON(!sg_page(s));
 
-		dma_cache_sync(dev, sg_virt(s), s->length, dir);
+		if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
+			dma_cache_sync(dev, sg_virt(s), s->length, dir);
 
 		s->dma_address = sg_phys(s);
 		s->dma_length = s->length;

