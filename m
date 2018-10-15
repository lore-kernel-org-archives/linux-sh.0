From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 15 Oct 2018 17:57:01 +0000
Subject: [PATCH v2 5/6] sh: mm: make use of new memblocks_present() helper
Message-Id: <20181015175702.9036-6-logang@deltatee.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20181015175702.9036-1-logang@deltatee.com>
In-Reply-To: <20181015175702.9036-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Cleanup the open coded for_each_memblock() loop that is equivalent
to the new memblocks_present() helper.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Rob Herring <robh@kernel.org>
---
 arch/sh/mm/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index 7713c084d040..f601f96408ee 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -235,12 +235,7 @@ static void __init do_init_bootmem(void)
 
 	plat_mem_setup();
 
-	for_each_memblock(memory, reg) {
-		int nid = memblock_get_region_node(reg);
-
-		memory_present(nid, memblock_region_memory_base_pfn(reg),
-			memblock_region_memory_end_pfn(reg));
-	}
+	memblocks_present();
 	sparse_init();
 }
 
-- 
2.19.0
