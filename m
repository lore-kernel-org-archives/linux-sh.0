From: Hideo Saito <saito@densan.co.jp>
Date: Fri, 15 Feb 2008 00:52:54 +0000
Subject: needs writeback on ptrace
Message-Id: <20080215.095254.68562685.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

When I test gdb on linux-2.6.24 for SH7780, the gdb can't step the program.
I think inserted breakpoints can't write back to the physical memory.

Following changes is available for this problem.

--- ./arch/sh/mm/pg-sh4.c.org	2008-01-25 07:58:37.000000000 +0900
+++ ./arch/sh/mm/pg-sh4.c	2008-02-06 17:19:58.000000000 +0900
@@ -87,18 +109,21 @@ void copy_to_user_page(struct vm_area_st
 	void *vto;
 
 	__set_bit(PG_mapped, &page->flags);
 
 	vto = kmap_coherent(page, vaddr) + (vaddr & ~PAGE_MASK);
 	memcpy(vto, src, len);
 	kunmap_coherent(vto);
 
-	if (vma->vm_flags & VM_EXEC)
-		flush_cache_page(vma, vaddr, page_to_pfn(page));
+	if (vma->vm_flags & VM_EXEC) {
+		extern void __flush_invalidate_region_icache(void *start, int size);
+		__flush_wback_region(vto, len);
+		__flush_invalidate_region_icache(vto, len);
+	}
 }
 
 void copy_from_user_page(struct vm_area_struct *vma, struct page *page,
 			 unsigned long vaddr, void *dst, const void *src,
 			 unsigned long len)
 {
 	void *vfrom;
 
