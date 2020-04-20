From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 20 Apr 2020 06:59:50 +0000
Subject: [PATCH] sh/mm: Fix a build failure via adding a missing bracket
Message-Id: <1587365270-5046-1-git-send-email-anshuman.khandual@arm.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Logan Gunthorpe <logang@deltatee.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

This just adds a missing round bracket. Earlier it had caused the following
build failure.

arch/sh/mm/init.c: In function 'arch_add_memory':
arch/sh/mm/init.c:416:3: error: expected ')' before 'return'
   return -EINVAL;

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/sh/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
index b9de2d4..8d2a68a 100644
--- a/arch/sh/mm/init.c
+++ b/arch/sh/mm/init.c
@@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
 	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
-	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
+	if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
 		return -EINVAL;
 
 	/* We only have ZONE_NORMAL, so this is easy.. */
-- 
2.7.4
