From: Adrian Bunk <bunk@kernel.org>
Date: Sun, 27 Jul 2008 13:04:38 +0000
Subject: [2.6 patch] mm/hugetlb.c must #include <asm/io.h>
Message-Id: <20080727130438.GJ9301@cs181140183.pp.htv.fi>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <ak@suse.de>, Nick Piggin <npiggin@suse.de>, Andrew Morton <akpm@linux-foundation.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org

This patch fixes the following build error on sh caused by
commit aa888a74977a8f2120ae9332376e179c39a6b07d
(hugetlb: support larger than MAX_ORDER):

<--  snip  -->

...
  CC      mm/hugetlb.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/mm/hugetlb.c: In function 'alloc_bootmem_huge_page':
/home/bunk/linux/kernel-2.6/git/linux-2.6/mm/hugetlb.c:958: error: implicit declaration of function 'virt_to_phys'
make[2]: *** [mm/hugetlb.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
98c5be88abb276588ea1f377f08726308765aa3c 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a8bf4ab..6101012 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -19,6 +19,7 @@
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
+#include <asm/io.h>
 
 #include <linux/hugetlb.h>
 #include "internal.h"

