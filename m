From: Hideo Saito <saito@densan.co.jp>
Date: Thu, 06 Mar 2008 04:49:27 +0000
Subject: a problem on copy_user_highpage
Message-Id: <20080306.134927.68563523.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

I have a problem on my platform using linux-2.6.24, but not linux-2.6.23.14, for SH7780.
When I mount NFS server as root, some processes causes a bus error frequently.

Following change is effective for this problem on my short testing, though I think this change is against the purpose of your change to copy_user_highpage().

--- ./arch/sh/mm/pg-sh4.c.org	2008-01-25 07:58:37.000000000 +0900
+++ ./arch/sh/mm/pg-sh4.c	2008-03-06 13:35:53.000000000 +0900
@@ -90,23 +90,20 @@ void copy_from_user_page(struct vm_area_
 void copy_user_highpage(struct page *to, struct page *from,
 			unsigned long vaddr, struct vm_area_struct *vma)
 {
 	void *vfrom, *vto;
 
 	__set_bit(PG_mapped, &to->flags);
 
 	vto = kmap_atomic(to, KM_USER1);
-	vfrom = kmap_coherent(from, vaddr);
+	vfrom = kmap_atomic(from, KM_USER0);
 	copy_page(vto, vfrom);
-	kunmap_coherent(vfrom);
-
-	if (((vaddr ^ (unsigned long)vto) & CACHE_ALIAS))
-		__flush_wback_region(vto, PAGE_SIZE);
 
+	kunmap_atomic(vfrom, KM_USER10);
 	kunmap_atomic(vto, KM_USER1);
 	/* Make sure this page is cleared on other CPU's too before using it */
 	smp_wmb();
 }
 EXPORT_SYMBOL(copy_user_highpage);
 
 /*
  * For SH-4, we have our own implementation for ptep_get_and_clear
