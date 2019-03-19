From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 19 Mar 2019 18:09:30 +0000
Subject: [PATCH] sh: mm: make use of new memblocks_present() helper
Message-Id: <20190319180930.8231-1-logang@deltatee.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190115173711.16974-1-logang@deltatee.com>
In-Reply-To: <20190115173711.16974-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Michal Hocko <mhocko@suse.com>, Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>

Cleanup the open coded for_each_memblock() loop that is equivalent
to the new memblocks_present() helper.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
---
 arch/sh/mm/init.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

This is just a resend

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index a8e5c0e00fca..dc0ff41d602d 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -234,12 +234,7 @@ static void __init do_init_bootmem(void)

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
