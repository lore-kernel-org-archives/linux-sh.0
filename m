From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 06 Feb 2008 15:19:29 +0000
Subject: [PATCH] sh: trapped io support
Message-Id: <20080206151929.27099.5627.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds trapped io support.

The idea is that we want to get rid of the in/out/readb/writeb callbacks from
the machvec and replace that with simple inline read and write operations to
memory. Fast and simple for most hardware devices (think pci).

Some devices require special treatment though - like 16-bit only CF devices -
so we need to have some method to hook in callbacks.

This patch makes it possible to add a per-device trap generating filter. This
way we can get maximum performance of sane hardware - which doesn't need this
filter - and crappy hardware works but gets punished by a performance hit.

So build better hardware or use register_trapped_io_handler() if you must.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig             |    3 
 arch/sh/kernel/Makefile_32  |    1 
 arch/sh/kernel/Makefile_64  |    1 
 arch/sh/kernel/io.c         |    8 +
 arch/sh/kernel/io_trapped.c |  274 +++++++++++++++++++++++++++++++++++++++++++
 arch/sh/kernel/traps_32.c   |   81 ++++++++----
 arch/sh/mm/fault_32.c       |    3 
 include/asm-sh/io.h         |    9 +
 include/asm-sh/io_trapped.h |   59 +++++++++
 include/asm-sh/system.h     |    5 
 include/asm-sh/system_32.h  |    3 
 11 files changed, 420 insertions(+), 27 deletions(-)

--- 0001/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-02-06 22:57:22.000000000 +0900
@@ -324,6 +324,9 @@ source "arch/sh/Kconfig.cpu"
 
 menu "Board support"
 
+config IO_TRAPPED
+	bool
+
 config SOLUTION_ENGINE
 	bool
 
--- 0001/arch/sh/kernel/Makefile_32
+++ work/arch/sh/kernel/Makefile_32	2008-02-06 22:57:22.000000000 +0900
@@ -22,5 +22,6 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_BINFMT_ELF)	+= dump_task.o
+obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 
 EXTRA_CFLAGS += -Werror
--- 0001/arch/sh/kernel/Makefile_64
+++ work/arch/sh/kernel/Makefile_64	2008-02-06 22:57:22.000000000 +0900
@@ -18,5 +18,6 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_BINFMT_ELF)	+= dump_task.o
+obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 
 EXTRA_CFLAGS += -Werror
--- 0001/arch/sh/kernel/io.c
+++ work/arch/sh/kernel/io.c	2008-02-06 22:57:22.000000000 +0900
@@ -63,6 +63,14 @@ EXPORT_SYMBOL(memset_io);
 
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
+	void __iomem *ret;
+
+	if (nr > 4) {
+		ret = ioremap_trapped(port, nr, IORESOURCE_IO);
+		if (ret)
+			return ret;
+	}
+
 	return sh_mv.mv_ioport_map(port, nr);
 }
 EXPORT_SYMBOL(ioport_map);
--- /dev/null
+++ work/arch/sh/kernel/io_trapped.c	2008-02-06 23:38:28.000000000 +0900
@@ -0,0 +1,274 @@
+/*
+ * Trapped io support
+ *
+ * Copyright (C) 2008 Magnus Damm
+ *
+ * Provide hooks to intercept io operations by trapping.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/mm.h>
+#include <linux/bitops.h>
+#include <linux/vmalloc.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/io_trapped.h>
+
+unsigned int trapped_ioread8(void __iomem *addr)
+{
+	return ctrl_inb((unsigned long __force)addr);
+}
+
+unsigned int trapped_ioread16(void __iomem *addr)
+{
+	return ctrl_inw((unsigned long __force)addr);
+}
+
+unsigned int trapped_ioread32(void __iomem *addr)
+{
+	return ctrl_inl((unsigned long __force)addr);
+}
+
+void trapped_iowrite8(unsigned int data, void __iomem *addr)
+{
+	ctrl_outb(data, (unsigned long __force)addr);
+}
+
+void trapped_iowrite16(unsigned int data, void __iomem *addr)
+{
+	ctrl_outw(data, (unsigned long __force)addr);
+}
+
+void trapped_iowrite32(unsigned int data, void __iomem *addr)
+{
+	ctrl_outl(data, (unsigned long __force)addr);
+}
+
+LIST_HEAD(trapped_io);
+LIST_HEAD(trapped_mem);
+static DEFINE_SPINLOCK(trapped_lock);
+
+#define TRAPPED_PAGES_MAX 16
+
+void __init register_trapped_io_handler(struct trapped_io *tiop)
+{
+	struct resource *res;
+	unsigned long len = 0, flags = 0;
+	struct page *pages[TRAPPED_PAGES_MAX];
+	int k, n;
+
+	for (k = 0; k < tiop->num_resources; k++) {
+		res = tiop->resource + k;
+		len += roundup((res->end - res->start) + 1, PAGE_SIZE);
+		flags |= res->flags;
+	}
+
+	BUG_ON(hweight_long(flags) != 1); /* IORESOURCE_IO or MEM, not both */
+	BUG_ON((unsigned long)tiop & (PAGE_SIZE - 1));
+	n = len >> PAGE_SHIFT;
+	BUG_ON(n >= TRAPPED_PAGES_MAX);
+
+	for (k = 0; k < n; k++)
+		pages[k] = virt_to_page(tiop);
+
+	tiop->virt_base = vmap(pages, n, VM_MAP, PAGE_NONE);
+	BUG_ON(!tiop->virt_base);
+
+	len = 0;
+	for (k = 0; k < tiop->num_resources; k++) {
+		res = tiop->resource + k;
+		printk(KERN_INFO "trapped io 0x%08lx overrides %s 0x%08lx\n",
+		       (unsigned long)(tiop->virt_base + len),
+		       res->flags & IORESOURCE_IO ? "io" : "mmio",
+		       (unsigned long)res->start);
+		len += roundup((res->end - res->start) + 1, PAGE_SIZE);
+	}
+
+	tiop->magic = IO_TRAPPED_MAGIC;
+	INIT_LIST_HEAD(&tiop->list);
+	spin_lock_irq(&trapped_lock);
+	if (flags & IORESOURCE_IO)
+		list_add(&tiop->list, &trapped_io);
+	if (flags & IORESOURCE_MEM)
+		list_add(&tiop->list, &trapped_mem);
+	spin_unlock_irq(&trapped_lock);
+}
+
+void __iomem *match_trapped_io_handler(struct list_head *list,
+				       unsigned long offset,
+				       unsigned long size)
+{
+	unsigned long voffs;
+	struct trapped_io *tiop;
+	struct resource *res;
+	int k, len;
+
+	spin_lock_irq(&trapped_lock);
+	list_for_each_entry(tiop, list, list) {
+		voffs = 0;
+		for (k = 0; k < tiop->num_resources; k++) {
+			res = tiop->resource + k;
+			if (res->start = offset) {
+				spin_unlock_irq(&trapped_lock);
+				return tiop->virt_base + voffs;
+			}
+
+			len = (res->end - res->start) + 1;
+			voffs += roundup(len, PAGE_SIZE);
+		}
+	}
+	spin_unlock_irq(&trapped_lock);
+	return NULL;
+}
+
+static struct trapped_io *lookup_tiop(unsigned long address)
+{
+	pgd_t *pgd_k;
+	pud_t *pud_k;
+	pmd_t *pmd_k;
+	pte_t *pte_k;
+	pte_t entry;
+
+	pgd_k = swapper_pg_dir + pgd_index(address);
+	if (!pgd_present(*pgd_k))
+		return NULL;
+
+	pud_k = pud_offset(pgd_k, address);
+	if (!pud_present(*pud_k))
+		return NULL;
+
+	pmd_k = pmd_offset(pud_k, address);
+	if (!pmd_present(*pmd_k))
+		return NULL;
+
+	pte_k = pte_offset_kernel(pmd_k, address);
+	entry = *pte_k;
+
+	return pfn_to_kaddr(pte_pfn(entry));
+}
+
+static unsigned long lookup_address(struct trapped_io *tiop,
+				    unsigned long address)
+{
+	struct resource *res;
+	unsigned long vaddr = (unsigned long)tiop->virt_base;
+	unsigned long len;
+	int k;
+
+	for (k = 0; k < tiop->num_resources; k++) {
+		res = tiop->resource + k;
+		len = roundup((res->end - res->start) + 1, PAGE_SIZE);
+		if (address < (vaddr + len))
+			return res->start + (address - vaddr);
+		vaddr += len;
+	}
+	BUG();
+	return 0;
+}
+
+static int from_device(void *dst, void *src, int cnt)
+{
+	struct trapped_io *tiop;
+	unsigned long addr = (unsigned long)src;
+	unsigned int tmp = 0;
+
+	tiop = lookup_tiop(addr);
+	BUG_ON(!tiop);
+	BUG_ON(tiop->magic != IO_TRAPPED_MAGIC);
+
+	addr = lookup_address(tiop, addr);
+#ifdef DEBUG
+	printk(KERN_DEBUG "trapped io read! 0x%08x, %d",
+	       (unsigned int)src, cnt);
+#endif
+	switch (cnt) {
+	case 1:
+		tmp = tiop->read8((void __iomem *)addr);
+		*(unsigned char *)dst = tmp & 0xff;
+		break;
+	case 2:
+		tmp = tiop->read16((void __iomem *)addr);
+		*(unsigned short *)dst = tmp & 0xffff;
+		break;
+	case 4:
+		tmp = tiop->read32((void __iomem *)addr);
+		*(unsigned int *)dst = tmp;
+		break;
+	default:
+		BUG();
+	}
+#ifdef DEBUG
+	printk(" -> 0x%08x 0x%08x\n", (unsigned int)addr, (unsigned int)tmp);
+#endif
+	return 0;
+}
+
+static int to_device(void *dst, void *src, int cnt)
+{
+	struct trapped_io *tiop;
+	unsigned long addr = (unsigned long)dst;
+	unsigned int tmp = 0;
+
+	tiop = lookup_tiop(addr);
+	BUG_ON(!tiop);
+	BUG_ON(tiop->magic != IO_TRAPPED_MAGIC);
+
+	addr = lookup_address(tiop, addr);
+#ifdef DEBUG
+	printk(KERN_DEBUG "trapped io write! 0x%08x, %d",
+	       (unsigned int)dst, cnt);
+#endif
+	switch (cnt) {
+	case 1:
+		tmp = *(unsigned char *)src;
+		tiop->write8(tmp, (void __iomem *)addr);
+		break;
+	case 2:
+		tmp = *(unsigned short *)src;
+		tiop->write16(tmp, (void __iomem *)addr);
+		break;
+	case 4:
+		tmp = *(unsigned int *)src;
+		tiop->write32(tmp, (void __iomem *)addr);
+		break;
+	default:
+		BUG();
+	}
+#ifdef DEBUG
+	printk("-> 0x%08x 0x%08x\n", (unsigned int)addr, (unsigned int)tmp);
+#endif
+	return 0;
+}
+
+static struct mem_access trapped_mem_access = {
+	from_device,
+	to_device,
+};
+
+int handle_trapped_io(struct pt_regs *regs, unsigned long address)
+{
+	mm_segment_t oldfs;
+	u16 instruction;
+	int tmp;
+
+	if (!lookup_tiop(address))
+		return 0;
+
+	BUG_ON(user_mode(regs));
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	if (copy_from_user(&instruction, (u16 *)(regs->pc), 2)) {
+		set_fs(oldfs);
+		BUG();
+		return 0;
+	}
+
+	tmp = handle_unaligned_access(instruction, regs, &trapped_mem_access);
+	set_fs(oldfs);
+	return !tmp;
+}
--- 0005/arch/sh/kernel/traps_32.c
+++ work/arch/sh/kernel/traps_32.c	2008-02-06 22:57:22.000000000 +0900
@@ -150,18 +150,43 @@ static int die_if_no_fixup(const char * 
 static inline void sign_extend(unsigned int count, unsigned char *dst)
 {
 #ifdef __LITTLE_ENDIAN__
+	if ((count = 1) && dst[0] & 0x80) {
+		dst[1] = 0xff;
+		dst[2] = 0xff;
+		dst[3] = 0xff;
+	}
 	if ((count = 2) && dst[1] & 0x80) {
 		dst[2] = 0xff;
 		dst[3] = 0xff;
 	}
 #else
-	if ((count = 2) && dst[2] & 0x80) {
+	if ((count = 1) && dst[3] & 0x80) {
+		dst[2] = 0xff;
+		dst[1] = 0xff;
 		dst[0] = 0xff;
+	}
+	if ((count = 2) && dst[2] & 0x80) {
 		dst[1] = 0xff;
+		dst[0] = 0xff;
 	}
 #endif
 }
 
+static int from_user(void *dst, void *src, int cnt)
+{
+	return copy_from_user(dst, src, cnt);
+}
+
+static int to_user(void *dst, void *src, int cnt)
+{
+	return copy_to_user(dst, src, cnt);
+}
+
+static struct mem_access user_mem_access = {
+	from_user,
+	to_user,
+};
+
 /*
  * handle an instruction that does an unaligned memory access by emulating the
  * desired behaviour
@@ -169,7 +194,8 @@ static inline void sign_extend(unsigned 
  *   (if that instruction is in a branch delay slot)
  * - return 0 if emulation okay, -EFAULT on existential error
  */
-static int handle_unaligned_ins(u16 instruction, struct pt_regs *regs)
+static int handle_unaligned_ins(u16 instruction, struct pt_regs *regs,
+				struct mem_access *ma)
 {
 	int ret, index, count;
 	unsigned long *rm, *rn;
@@ -196,7 +222,7 @@ static int handle_unaligned_ins(u16 inst
 #if !defined(__LITTLE_ENDIAN__)
 			dst += 4-count;
 #endif
-			if (copy_from_user(dst, src, count))
+			if (ma->from(dst, src, count))
 				goto fetch_fault;
 
 			sign_extend(count, dst);
@@ -209,7 +235,7 @@ static int handle_unaligned_ins(u16 inst
 			dst = (unsigned char*) *rn;
 			dst += regs->regs[0];
 
-			if (copy_to_user(dst, src, count))
+			if (ma->to(dst, src, count))
 				goto fetch_fault;
 		}
 		ret = 0;
@@ -220,7 +246,7 @@ static int handle_unaligned_ins(u16 inst
 		dst = (unsigned char*) *rn;
 		dst += (instruction&0x000F)<<2;
 
-		if (copy_to_user(dst,src,4))
+		if (ma->to(dst, src, 4))
 			goto fetch_fault;
 		ret = 0;
 		break;
@@ -233,7 +259,7 @@ static int handle_unaligned_ins(u16 inst
 #if !defined(__LITTLE_ENDIAN__)
 		src += 4-count;
 #endif
-		if (copy_to_user(dst, src, count))
+		if (ma->to(dst, src, count))
 			goto fetch_fault;
 		ret = 0;
 		break;
@@ -244,7 +270,7 @@ static int handle_unaligned_ins(u16 inst
 		dst = (unsigned char*) rn;
 		*(unsigned long*)dst = 0;
 
-		if (copy_from_user(dst,src,4))
+		if (ma->from(dst, src, 4))
 			goto fetch_fault;
 		ret = 0;
 		break;
@@ -259,7 +285,7 @@ static int handle_unaligned_ins(u16 inst
 #if !defined(__LITTLE_ENDIAN__)
 		dst += 4-count;
 #endif
-		if (copy_from_user(dst, src, count))
+		if (ma->from(dst, src, count))
 			goto fetch_fault;
 		sign_extend(count, dst);
 		ret = 0;
@@ -275,7 +301,7 @@ static int handle_unaligned_ins(u16 inst
 			dst = (unsigned char*) *rm; /* called Rn in the spec */
 			dst += (instruction&0x000F)<<1;
 
-			if (copy_to_user(dst, src, 2))
+			if (ma->to(dst, src, 2))
 				goto fetch_fault;
 			ret = 0;
 			break;
@@ -289,7 +315,7 @@ static int handle_unaligned_ins(u16 inst
 #if !defined(__LITTLE_ENDIAN__)
 			dst += 2;
 #endif
-			if (copy_from_user(dst, src, 2))
+			if (ma->from(dst, src, 2))
 				goto fetch_fault;
 			sign_extend(2, dst);
 			ret = 0;
@@ -310,7 +336,8 @@ static int handle_unaligned_ins(u16 inst
  * emulate the instruction in the delay slot
  * - fetches the instruction from PC+2
  */
-static inline int handle_unaligned_delayslot(struct pt_regs *regs)
+static inline int handle_unaligned_delayslot(struct pt_regs *regs,
+					     struct mem_access *ma)
 {
 	u16 instruction;
 
@@ -324,7 +351,7 @@ static inline int handle_unaligned_delay
 		    regs, 0);
 	}
 
-	return handle_unaligned_ins(instruction,regs);
+	return handle_unaligned_ins(instruction, regs, ma);
 }
 
 /*
@@ -347,10 +374,10 @@ static inline int handle_unaligned_delay
  * XXX: SH-2A needs this too, but it needs an overhaul thanks to mixed 32-bit
  * opcodes..
  */
-#ifndef CONFIG_CPU_SH2A
 static int handle_unaligned_notify_count = 10;
 
-static int handle_unaligned_access(u16 instruction, struct pt_regs *regs)
+int handle_unaligned_access(u16 instruction, struct pt_regs *regs,
+			    struct mem_access *ma)
 {
 	u_int rm;
 	int ret, index;
@@ -373,19 +400,19 @@ static int handle_unaligned_access(u16 i
 	case 0x0000:
 		if (instruction=0x000B) {
 			/* rts */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, ma);
 			if (ret=0)
 				regs->pc = regs->pr;
 		}
 		else if ((instruction&0x00FF)=0x0023) {
 			/* braf @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, ma);
 			if (ret=0)
 				regs->pc += rm + 4;
 		}
 		else if ((instruction&0x00FF)=0x0003) {
 			/* bsrf @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, ma);
 			if (ret=0) {
 				regs->pr = regs->pc + 4;
 				regs->pc += rm + 4;
@@ -406,13 +433,13 @@ static int handle_unaligned_access(u16 i
 	case 0x4000:
 		if ((instruction&0x00FF)=0x002B) {
 			/* jmp @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, ma);
 			if (ret=0)
 				regs->pc = rm;
 		}
 		else if ((instruction&0x00FF)=0x000B) {
 			/* jsr @Rm */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, ma);
 			if (ret=0) {
 				regs->pr = regs->pc + 4;
 				regs->pc = rm;
@@ -439,7 +466,7 @@ static int handle_unaligned_access(u16 i
 		case 0x0B00: /* bf   lab - no delayslot*/
 			break;
 		case 0x0F00: /* bf/s lab */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, ma);
 			if (ret=0) {
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SH7705_CACHE_32KB)
 				if ((regs->sr & 0x00000001) != 0)
@@ -452,7 +479,7 @@ static int handle_unaligned_access(u16 i
 		case 0x0900: /* bt   lab - no delayslot */
 			break;
 		case 0x0D00: /* bt/s lab */
-			ret = handle_unaligned_delayslot(regs);
+			ret = handle_unaligned_delayslot(regs, ma);
 			if (ret=0) {
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SH7705_CACHE_32KB)
 				if ((regs->sr & 0x00000001) = 0)
@@ -466,13 +493,13 @@ static int handle_unaligned_access(u16 i
 		break;
 
 	case 0xA000: /* bra label */
-		ret = handle_unaligned_delayslot(regs);
+		ret = handle_unaligned_delayslot(regs, ma);
 		if (ret=0)
 			regs->pc += SH_PC_12BIT_OFFSET(instruction);
 		break;
 
 	case 0xB000: /* bsr label */
-		ret = handle_unaligned_delayslot(regs);
+		ret = handle_unaligned_delayslot(regs, ma);
 		if (ret=0) {
 			regs->pr = regs->pc + 4;
 			regs->pc += SH_PC_12BIT_OFFSET(instruction);
@@ -483,12 +510,11 @@ static int handle_unaligned_access(u16 i
 
 	/* handle non-delay-slot instruction */
  simple:
-	ret = handle_unaligned_ins(instruction,regs);
+	ret = handle_unaligned_ins(instruction, regs, ma);
 	if (ret=0)
 		regs->pc += instruction_size(instruction);
 	return ret;
 }
-#endif /* CONFIG_CPU_SH2A */
 
 #ifdef CONFIG_CPU_HAS_SR_RB
 #define lookup_exception_vector(x)	\
@@ -549,7 +575,8 @@ asmlinkage void do_address_error(struct 
 			goto uspace_segv;
 		}
 
-		tmp = handle_unaligned_access(instruction, regs);
+		tmp = handle_unaligned_access(instruction, regs,
+					      &user_mem_access);
 		set_fs(oldfs);
 
 		if (tmp=0)
@@ -580,7 +607,7 @@ uspace_segv:
 			die("insn faulting in do_address_error", regs, 0);
 		}
 
-		handle_unaligned_access(instruction, regs);
+		handle_unaligned_access(instruction, regs, &user_mem_access);
 		set_fs(oldfs);
 #else
 		printk(KERN_NOTICE "Killing process \"%s\" due to unaligned "
--- 0001/arch/sh/mm/fault_32.c
+++ work/arch/sh/mm/fault_32.c	2008-02-06 22:57:22.000000000 +0900
@@ -15,6 +15,7 @@
 #include <linux/mm.h>
 #include <linux/hardirq.h>
 #include <linux/kprobes.h>
+#include <asm/io_trapped.h>
 #include <asm/system.h>
 #include <asm/mmu_context.h>
 #include <asm/tlbflush.h>
@@ -163,6 +164,8 @@ no_context:
 	if (fixup_exception(regs))
 		return;
 
+	if (handle_trapped_io(regs, address))
+		return;
 /*
  * Oops. The kernel tried to access some bad page. We'll have to
  * terminate things with extreme prejudice.
--- 0001/include/asm-sh/io.h
+++ work/include/asm-sh/io.h	2008-02-06 22:57:22.000000000 +0900
@@ -38,6 +38,7 @@
  */
 #define __IO_PREFIX	generic
 #include <asm/io_generic.h>
+#include <asm/io_trapped.h>
 
 #define maybebadio(port) \
   printk(KERN_ERR "bad PC-like io %s:%u for port 0x%lx at 0x%08x\n", \
@@ -309,7 +310,15 @@ __ioremap_mode(unsigned long offset, uns
 {
 #ifdef CONFIG_SUPERH32
 	unsigned long last_addr = offset + size - 1;
+#endif
+	void __iomem *ret = NULL;
+
+	if (!(flags & _PAGE_CACHABLE))
+		ret = ioremap_trapped(offset, size, IORESOURCE_MEM);
+	if (ret)
+		return ret;
 
+#ifdef CONFIG_SUPERH32
 	/*
 	 * For P1 and P2 space this is trivial, as everything is already
 	 * mapped. Uncached access for P1 addresses are done through P2.
--- /dev/null
+++ work/include/asm-sh/io_trapped.h	2008-02-06 23:34:23.000000000 +0900
@@ -0,0 +1,59 @@
+#ifndef __ASM_SH_IO_TRAPPED_H
+#define __ASM_SH_IO_TRAPPED_H
+
+#include <linux/list.h>
+#include <linux/ioport.h>
+#include <asm/page.h>
+
+#define IO_TRAPPED_MAGIC 0xfeedbeef
+
+struct trapped_io {
+	unsigned int magic;
+	struct resource *resource;
+	unsigned int num_resources;
+	struct list_head list;
+	void __iomem *virt_base;
+	unsigned int (*read8)(void __iomem *addr);
+	unsigned int (*read16)(void __iomem *addr);
+	unsigned int (*read32)(void __iomem *addr);
+	void (*write8)(unsigned int data, void __iomem *addr);
+	void (*write16)(unsigned int data, void __iomem *addr);
+	void (*write32)(unsigned int data, void __iomem *addr);
+} __attribute__ ((aligned(PAGE_SIZE)));;
+
+unsigned int trapped_ioread8(void __iomem *addr);
+unsigned int trapped_ioread16(void __iomem *addr);
+unsigned int trapped_ioread32(void __iomem *addr);
+void trapped_iowrite8(unsigned int data, void __iomem *addr);
+void trapped_iowrite16(unsigned int data, void __iomem *addr);
+void trapped_iowrite32(unsigned int data, void __iomem *addr);
+
+#ifdef CONFIG_IO_TRAPPED
+void __init register_trapped_io_handler(struct trapped_io *tiop);
+int handle_trapped_io(struct pt_regs *regs, unsigned long address);
+#else
+#define register_trapped_io_handler(tiop) while (0)
+#define handle_trapped_io(tiop, address) 0
+#endif
+
+void __iomem *match_trapped_io_handler(struct list_head *list,
+				       unsigned long offset,
+				       unsigned long size);
+
+extern struct list_head trapped_io;
+extern struct list_head trapped_mem;
+
+static inline void __iomem *
+ioremap_trapped(unsigned long offset, unsigned long size, unsigned long flags)
+{
+#ifdef CONFIG_IO_TRAPPED
+	if (flags & IORESOURCE_IO)
+		return match_trapped_io_handler(&trapped_io, offset, size);
+
+	if (flags & IORESOURCE_MEM)
+		return match_trapped_io_handler(&trapped_mem, offset, size);
+#endif
+	return NULL;
+}
+
+#endif /* __ASM_SH_IO_TRAPPED_H */
--- 0001/include/asm-sh/system.h
+++ work/include/asm-sh/system.h	2008-02-06 22:57:22.000000000 +0900
@@ -182,6 +182,11 @@ BUILD_TRAP_HANDLER(fpu_state_restore);
 
 #define arch_align_stack(x) (x)
 
+struct mem_access {
+	int (*from)(void *dst, void *src, int cnt);
+	int (*to)(void *dst, void *src, int cnt);
+};
+
 #ifdef CONFIG_SUPERH32
 # include "system_32.h"
 #else
--- 0001/include/asm-sh/system_32.h
+++ work/include/asm-sh/system_32.h	2008-02-06 22:57:22.000000000 +0900
@@ -96,4 +96,7 @@ do {							\
 		: "=&r" (__dummy));			\
 } while (0)
 
+int handle_unaligned_access(u16 instruction, struct pt_regs *regs,
+			    struct mem_access *ma);
+
 #endif /* __ASM_SH_SYSTEM_32_H */
