From: Hideo Saito <saito@densan.co.jp>
Date: Fri, 15 Feb 2008 04:06:31 +0000
Subject: needs caching for fixmap
Message-Id: <20080215.130631.125129853.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

When I start up on linux-2.6.24 for SH7780, there are many assertion failed as follows although kernel doesn't hang up.
It seems that the failed address is fix-mapping pages and the entry on UTLB is replaced before using it at |copy_page_slow|.

[   17.667186] Unable to handle kernel paging request at virtual address dfff1400
[   17.718559] pc = 8804aba8
[   17.749845] *pde = 00000000
[   17.783201] Oops: 0000 [#1]
[   17.816551] Modules linked in:
[   17.853062] 
[   17.870799] Pid : 839, Comm:      default.hotplug
[   17.927145] PC is at copy_page_slow+0x10/0x4c
[   17.979295] PC  : 8804aba8 SP  : 8fafde60 SR  : 40008100 TEA : dfff1400    Not tainted
[   18.074226] R0  : 887353e0 R1  : 00000000 R2  : 0000000a R3  : 0000007b
[   18.153509] R4  : 00000028 R5  : 00000029 R6  : 0000003b R7  : 00000026
[   18.232795] R8  : dfff2000 R9  : 0fcbc53e R10 : 88735400 R11 : dfff1400
[   18.312076] R12 : 004b9108 R13 : 882c4140 R14 : 0fcbc55c
[   18.375712] MACH: 00000000 MACL: 00000000 GBR : 2976f658 PR  : 8804b794
[   18.454989] 
[   18.454996] Call trace: 
[   18.502980] [<88080f9e>] do_wp_page+0x28a/0x442
[   18.557227] [<88081fb8>] handle_mm_fault+0x538/0x5b0
[   18.616691] [<88061468>] __rcu_process_callbacks+0x144/0x206
[   18.684494] [<8804a7ee>] do_page_fault+0xa6/0x2c0
[   18.740829] [<8805637c>] __do_softirq+0x3c/0x98
[   18.795074] [<88056402>] do_softirq+0x2a/0x58
[   18.847234] [<880460e0>] ret_from_exception+0x0/0x8
[   18.905654] [<880460e0>] ret_from_exception+0x0/0x8
[   18.964075] [<8804e0bc>] schedule_tail+0x0/0x58
[   19.018319] [<8808efbc>] filp_close+0x30/0x68
[   19.070479] [<8808efce>] filp_close+0x42/0x68
[   19.122638] [<880460e0>] ret_from_exception+0x0/0x8
[   19.181058] [<880460e0>] ret_from_exception+0x0/0x8
[   19.239484] 

Following changes is available for this problem.

--- ./arch/sh/mm/pg-sh4.c.org	2008-01-25 07:58:37.000000000 +0900
+++ ./arch/sh/mm/pg-sh4.c	2008-02-06 17:19:58.000000000 +0900
@@ -11,27 +11,45 @@
 #include <linux/fs.h>
 #include <linux/highmem.h>
 #include <linux/module.h>
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 
 #define CACHE_ALIAS (current_cpu_data.dcache.alias_mask)
 
+pte_t fix_cmap_ptes[FIX_N_COLOURS];
+
+void put_fix_cmap_ptes(enum fixed_addresses idx, pte_t pte)
+{
+	fix_cmap_ptes[idx] = pte;
+}
+
+pte_t get_fix_cmap_ptes(unsigned long addr)
+{
+	int idx = __virt_to_fix(addr);
+	static pte_t null;
+
+	if (idx > 0 && idx <= FIX_N_COLOURS)
+		return fix_cmap_ptes[FIX_CMAP_END - idx];
+	return null;
+}
+
 static inline void *kmap_coherent(struct page *page, unsigned long addr)
 {
 	enum fixed_addresses idx;
 	unsigned long vaddr, flags;
 	pte_t pte;
 
 	inc_preempt_count();
 
 	idx = (addr & current_cpu_data.dcache.alias_mask) >> PAGE_SHIFT;
 	vaddr = __fix_to_virt(FIX_CMAP_END - idx);
 	pte = mk_pte(page, PAGE_KERNEL);
+	put_fix_cmap_ptes(idx, pte);
 
 	local_irq_save(flags);
 	flush_tlb_one(get_asid(), vaddr);
 	local_irq_restore(flags);
 
 	update_mmu_cache(NULL, vaddr, pte);
 
 	return (void *)vaddr;
--- ./arch/sh/mm/fault.c.org	2008-01-25 07:58:37.000000000 +0900
+++ ./arch/sh/mm/fault.c	2008-02-15 12:00:43.000000000 +0900
@@ -266,16 +266,25 @@ asmlinkage int __kprobes __do_page_fault
 
 	/*
 	 * We don't take page faults for P1, P2, and parts of P4, these
 	 * are always mapped, whether it be due to legacy behaviour in
 	 * 29-bit mode, or due to PMB configuration in 32-bit mode.
 	 */
 	if (address >= P3SEG && address < P3_ADDR_MAX) {
 		pgd = pgd_offset_k(address);
+		if (*(int *) pgd = 0) {
+			pte_t get_fix_cmap_ptes(unsigned long addr);
+
+			entry = get_fix_cmap_ptes(address);
+			if (!pte_none(entry)) {
+				update_mmu_cache(NULL, address, entry);
+				return 0;
+			}
+		}
 	} else {
 		if (unlikely(address >= TASK_SIZE || !current->mm))
 			return 1;
 
 		pgd = pgd_offset(current->mm, address);
 	}
 
 	pud = pud_offset(pgd, address);
