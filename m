From: Hideo Saito <saito@densan.co.jp>
Date: Fri, 08 Feb 2008 05:10:34 +0000
Subject: multiple hit on TLB
Message-Id: <20080208.141034.46637747.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

On linux-2.6.24 for SH7780, I see a multiple hit in UTLB entries, for example, if |p->x| causes TLB miss exception in the following code.

a = p->x;  |do_page_fault| is called and UTLB is updated to read from |p->x|
p->x = b;  |__do_page_fault| is called and UTLB is updated to write to |p->x|

I think following code should not be removed for TLB miss optimizations.

--- ./arch/sh/mm/fault.c2	2008-02-05 14:11:44.000000000 +0900
+++ ./arch/sh/mm/fault.c	2008-02-08 11:30:37.000000000 +0900
@@ -300,13 +300,21 @@ asmlinkage int __kprobes __do_page_fault
 		return 1;
 	if (unlikely(writeaccess && !pte_write(entry)))
 		return 1;
 
 	if (writeaccess)
 		entry = pte_mkdirty(entry);
 	entry = pte_mkyoung(entry);
 
+#ifdef CONFIG_CPU_SH4
+	/*
+	 * ITLB is not affected by "ldtlb" instruction.
+	 * So, we need to flush the entry by ourselves.
+	 */
+	local_flush_tlb_one(get_asid(), address & PAGE_MASK);
+#endif
+
 	set_pte(pte, entry);
 	update_mmu_cache(NULL, address, entry);
 
 	return 0;
 }
