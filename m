From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Wed, 14 Nov 2012 05:24:16 +0000
Subject: [PATCH] sh: Remove start_addr of unused variable
Message-Id: <1352870656-11376-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This revises compile error following.

----
cc1: warnings being treated as errors
arch/sh/mm/mmap.c: In function 'arch_get_unmapped_area':
arch/sh/mm/mmap.c:38: error: unused variable 'start_addr'
make[1]: *** [arch/sh/mm/mmap.o] Error 1
make: *** [arch/sh/mm] Error 2
----

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/sh/mm/mmap.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index cb2d66f..6777177 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -35,7 +35,6 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	unsigned long start_addr;
 	int do_colour_align;
 	struct vm_unmapped_area_info info;
 
-- 
1.7.10.4

