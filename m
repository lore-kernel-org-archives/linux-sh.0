From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 07 Feb 2008 11:18:21 +0000
Subject: [PATCH] sh: trapped io support V2
Message-Id: <20080207111821.9715.41817.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The idea is that we want to get rid of the in/out/readb/writeb callbacks from
the machvec and replace that with simple inline read and write operations to
memory. Fast and simple for most hardware devices (think pci).

Some devices require special treatment though - like 16-bit only CF devices -
so we need to have some method to hook in callbacks.

This patch makes it possible to add a per-device trap generating filter. This
way we can get maximum performance of sane hardware - which doesn't need this
filter - and crappy hardware works but gets punished by a performance hit.

V2 changes things around a bit and replaces io access callbacks with a
simple minimum_bus_width value. In the future we can add stride as well.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/Kconfig             |    3 
 arch/sh/kernel/Makefile_32  |    1 
 arch/sh/kernel/Makefile_64  |    1 
 arch/sh/kernel/io.c         |    8 +
 arch/sh/kernel/io_generic.c |   24 +--
 arch/sh/kernel/io_trapped.c |  269 +++++++++++++++++++++++++++++++++++++++++++
 arch/sh/kernel/traps_32.c   |   59 +++++----
 arch/sh/mm/fault_32.c       |    3 
 include/asm-sh/io.h         |   10 +
 include/asm-sh/io_trapped.h |   58 +++++++++
 include/asm-sh/system.h     |    5 
 include/asm-sh/system_32.h  |    3 
 12 files changed, 406 insertions(+), 38 deletions(-)

--- 0006/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2008-02-07 18:54:11.000000000 +0900
@@ -89,6 +89,9 @@ config ARCH_HAS_ILOG2_U64
 config ARCH_NO_VIRT_TO_BUS
 	def_bool y
 
+config IO_TRAPPED
+	bool
+
 source "init/Kconfig"
 
 menu "System type"
--- 0001/arch/sh/kernel/Makefile_32
+++ work/arch/sh/kernel/Makefile_32	2008-02-07 18:54:11.000000000 +0900
@@ -22,5 +22,6 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_BINFMT_ELF)	+= dump_task.o
+obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 
 EXTRA_CFLAGS += -Werror
--- 0001/arch/sh/kernel/Makefile_64
+++ work/arch/sh/kernel/Makefile_64	2008-02-07 18:54:11.000000000 +0900
@@ -18,5 +18,6 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_BINFMT_ELF)	+= dump_task.o
+obj-$(CONFIG_IO_TRAPPED)	+= io_trapped.o
 
 EXTRA_CFLAGS += -Werror
--- 0001/arch/sh/kernel/io.c
+++ work/arch/sh/kernel/io.c	2008-02-07 18:54:11.000000000 +0900
@@ -63,7 +63,13 @@ EXPORT_SYMBOL(memset_io);
 
 void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
-	return sh_mv.mv_ioport_map(port, nr);
+	void __iomem *ret;
+
+	ret = __ioport_map_trapped(port, nr);
+	if (ret)
+		return ret;
+
+	return __ioport_map(port, nr);
 }
 EXPORT_SYMBOL(ioport_map);
 
--- 0001/arch/sh/kernel/io_generic.c
+++ work/arch/sh/kernel/io_generic.c	2008-02-07 18:54:11.000000000 +0900
@@ -33,17 +33,17 @@ static inline void delay(void)
 
 u8 generic_inb(unsigned long port)
 {
-	return ctrl_inb((unsigned long __force)ioport_map(port, 1));
+	return ctrl_inb((unsigned long __force)__ioport_map(port, 1));
 }
 
 u16 generic_inw(unsigned long port)
 {
-	return ctrl_inw((unsigned long __force)ioport_map(port, 2));
+	return ctrl_inw((unsigned long __force)__ioport_map(port, 2));
 }
 
 u32 generic_inl(unsigned long port)
 {
-	return ctrl_inl((unsigned long __force)ioport_map(port, 4));
+	return ctrl_inl((unsigned long __force)__ioport_map(port, 4));
 }
 
 u8 generic_inb_p(unsigned long port)
@@ -81,7 +81,7 @@ void generic_insb(unsigned long port, vo
 	volatile u8 *port_addr;
 	u8 *buf = dst;
 
-	port_addr = (volatile u8 *)ioport_map(port, 1);
+	port_addr = (volatile u8 *)__ioport_map(port, 1);
 	while (count--)
 		*buf++ = *port_addr;
 }
@@ -91,7 +91,7 @@ void generic_insw(unsigned long port, vo
 	volatile u16 *port_addr;
 	u16 *buf = dst;
 
-	port_addr = (volatile u16 *)ioport_map(port, 2);
+	port_addr = (volatile u16 *)__ioport_map(port, 2);
 	while (count--)
 		*buf++ = *port_addr;
 
@@ -103,7 +103,7 @@ void generic_insl(unsigned long port, vo
 	volatile u32 *port_addr;
 	u32 *buf = dst;
 
-	port_addr = (volatile u32 *)ioport_map(port, 4);
+	port_addr = (volatile u32 *)__ioport_map(port, 4);
 	while (count--)
 		*buf++ = *port_addr;
 
@@ -112,17 +112,17 @@ void generic_insl(unsigned long port, vo
 
 void generic_outb(u8 b, unsigned long port)
 {
-	ctrl_outb(b, (unsigned long __force)ioport_map(port, 1));
+	ctrl_outb(b, (unsigned long __force)__ioport_map(port, 1));
 }
 
 void generic_outw(u16 b, unsigned long port)
 {
-	ctrl_outw(b, (unsigned long __force)ioport_map(port, 2));
+	ctrl_outw(b, (unsigned long __force)__ioport_map(port, 2));
 }
 
 void generic_outl(u32 b, unsigned long port)
 {
-	ctrl_outl(b, (unsigned long __force)ioport_map(port, 4));
+	ctrl_outl(b, (unsigned long __force)__ioport_map(port, 4));
 }
 
 void generic_outb_p(u8 b, unsigned long port)
@@ -153,7 +153,7 @@ void generic_outsb(unsigned long port, c
 	volatile u8 *port_addr;
 	const u8 *buf = src;
 
-	port_addr = (volatile u8 __force *)ioport_map(port, 1);
+	port_addr = (volatile u8 __force *)__ioport_map(port, 1);
 
 	while (count--)
 		*port_addr = *buf++;
@@ -164,7 +164,7 @@ void generic_outsw(unsigned long port, c
 	volatile u16 *port_addr;
 	const u16 *buf = src;
 
-	port_addr = (volatile u16 __force *)ioport_map(port, 2);
+	port_addr = (volatile u16 __force *)__ioport_map(port, 2);
 
 	while (count--)
 		*port_addr = *buf++;
@@ -177,7 +177,7 @@ void generic_outsl(unsigned long port, c
 	volatile u32 *port_addr;
 	const u32 *buf = src;
 
-	port_addr = (volatile u32 __force *)ioport_map(port, 4);
+	port_addr = (volatile u32 __force *)__ioport_map(port, 4);
 	while (count--)
 		*port_addr = *buf++;
 
--- /dev/null
+++ work/arch/sh/kernel/io_trapped.c	2008-02-07 19:04:27.000000000 +0900
@@ -0,0 +1,269 @@
+/*
+ * Trapped io support
+ *
+ * Copyright (C) 2008 Magnus Damm
+ *
+ * Intercept io operations by trapping.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/bitops.h>
+#include <linux/vmalloc.h>
+#include <asm/system.h>
+#include <asm/mmu_context.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/io_trapped.h>
+
+#define TRAPPED_PAGES_MAX 16
+#define MAX(a, b) (((a) >= (b)) ? (a) : (b))
+
+#ifdef CONFIG_HAS_IOPORT
+LIST_HEAD(trapped_io);
+#endif
+#ifdef CONFIG_HAS_IOMEM
+LIST_HEAD(trapped_mem);
+#endif
+static DEFINE_SPINLOCK(trapped_lock);
+
+int __init register_trapped_io(struct trapped_io *tiop)
+{
+	struct resource *res;
+	unsigned long len = 0, flags = 0;
+	struct page *pages[TRAPPED_PAGES_MAX];
+	int k, n;
+
+	/* structure must be page aligned */
+	if ((unsigned long)tiop & (PAGE_SIZE - 1))
+		goto bad;
+
+	for (k = 0; k < tiop->num_resources; k++) {
+		res = tiop->resource + k;
+		len += roundup((res->end - res->start) + 1, PAGE_SIZE);
+		flags |= res->flags;
+	}
+
+	/* support IORESOURCE_IO _or_ MEM, not both */
+	if (hweight_long(flags) != 1)
+		goto bad;
+
+	n = len >> PAGE_SHIFT;
+
+	if (n >= TRAPPED_PAGES_MAX)
+		goto bad;
+
+	for (k = 0; k < n; k++)
+		pages[k] = virt_to_page(tiop);
+
+	tiop->virt_base = vmap(pages, n, VM_MAP, PAGE_NONE);
+	if (!tiop->virt_base)
+		goto bad;
+
+	len = 0;
+	for (k = 0; k < tiop->num_resources; k++) {
+		res = tiop->resource + k;
+		pr_info("trapped io 0x%08lx overrides %s 0x%08lx\n",
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
+
+	return 0;
+ bad:
+	pr_warning("unable to install trapped io filter\n");
+	return -1;
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
+	return 0;
+}
+
+static unsigned long long copy_word(unsigned long src_addr, int src_len,
+				    unsigned long dst_addr, int dst_len)
+{
+	unsigned long long tmp = 0;
+
+	switch (src_len) {
+	case 1:
+		tmp = ctrl_inb(src_addr);
+		break;
+	case 2:
+		tmp = ctrl_inw(src_addr);
+		break;
+	case 4:
+		tmp = ctrl_inl(src_addr);
+		break;
+	case 8:
+		tmp = ctrl_inq(src_addr);
+		break;
+	}
+
+	switch (dst_len) {
+	case 1:
+		ctrl_outb(tmp, dst_addr);
+		break;
+	case 2:
+		ctrl_outw(tmp, dst_addr);
+		break;
+	case 4:
+		ctrl_outl(tmp, dst_addr);
+		break;
+	case 8:
+		ctrl_outq(tmp, dst_addr);
+		break;
+	}
+
+	return tmp;
+}
+
+static unsigned long from_device(void *dst, const void *src, unsigned long cnt)
+{
+	struct trapped_io *tiop;
+	unsigned long src_addr = (unsigned long)src;
+	unsigned long long tmp;
+
+	pr_debug("trapped io read 0x%08lx (%ld)\n", src_addr, cnt);
+	tiop = lookup_tiop(src_addr);
+	WARN_ON(!tiop || (tiop->magic != IO_TRAPPED_MAGIC));
+
+	src_addr = lookup_address(tiop, src_addr);
+	if (!src_addr)
+		return cnt;
+
+	tmp = copy_word(src_addr, MAX(cnt, (tiop->minimum_bus_width / 8)),
+			(unsigned long)dst, cnt);
+
+	pr_debug("trapped io read 0x%08lx -> 0x%08llx\n", src_addr, tmp);
+	return 0;
+}
+
+static unsigned long to_device(void *dst, const void *src, unsigned long cnt)
+{
+	struct trapped_io *tiop;
+	unsigned long dst_addr = (unsigned long)dst;
+	unsigned long long tmp;
+
+	pr_debug("trapped io write 0x%08lx (%ld)\n", dst_addr, cnt);
+	tiop = lookup_tiop(dst_addr);
+	WARN_ON(!tiop || (tiop->magic != IO_TRAPPED_MAGIC));
+
+	dst_addr = lookup_address(tiop, dst_addr);
+	if (!dst_addr)
+		return cnt;
+
+	tmp = copy_word((unsigned long)src, cnt,
+			dst_addr, MAX(cnt, (tiop->minimum_bus_width / 8)));
+
+	pr_debug("trapped io write 0x%08lx -> 0x%08llx\n", dst_addr, tmp);
+	return 0;
+}
+
+static struct mem_access trapped_io_access = {
+	from_device,
+	to_device,
+};
+
+int handle_trapped_io(struct pt_regs *regs, unsigned long address)
+{
+	mm_segment_t oldfs;
+	opcode_t instruction;
+	int tmp;
+
+	if (!lookup_tiop(address))
+		return 0;
+
+	WARN_ON(user_mode(regs));
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	if (copy_from_user(&instruction, (void *)(regs->pc),
+			   sizeof(instruction))) {
+		set_fs(oldfs);
+		return 0;
+	}
+
+	tmp = handle_unaligned_access(instruction, regs, &trapped_io_access);
+	set_fs(oldfs);
+	return tmp = 0;
+}
--- 0004/arch/sh/kernel/traps_32.c
+++ work/arch/sh/kernel/traps_32.c	2008-02-07 18:54:11.000000000 +0900
@@ -172,6 +172,11 @@ static inline void sign_extend(unsigned 
 #endif
 }
 
+static struct mem_access user_mem_access = {
+	copy_from_user,
+	copy_to_user,
+};
+
 /*
  * handle an instruction that does an unaligned memory access by emulating the
  * desired behaviour
@@ -179,7 +184,8 @@ static inline void sign_extend(unsigned 
  *   (if that instruction is in a branch delay slot)
  * - return 0 if emulation okay, -EFAULT on existential error
  */
-static int handle_unaligned_ins(opcode_t instruction, struct pt_regs *regs)
+static int handle_unaligned_ins(opcode_t instruction, struct pt_regs *regs,
+				struct mem_access *ma)
 {
 	int ret, index, count;
 	unsigned long *rm, *rn;
@@ -206,7 +212,7 @@ static int handle_unaligned_ins(opcode_t
 #if !defined(__LITTLE_ENDIAN__)
 			dst += 4-count;
 #endif
-			if (copy_from_user(dst, src, count))
+			if (ma->from(dst, src, count))
 				goto fetch_fault;
 
 			sign_extend(count, dst);
@@ -219,7 +225,7 @@ static int handle_unaligned_ins(opcode_t
 			dst = (unsigned char*) *rn;
 			dst += regs->regs[0];
 
-			if (copy_to_user(dst, src, count))
+			if (ma->to(dst, src, count))
 				goto fetch_fault;
 		}
 		ret = 0;
@@ -230,7 +236,7 @@ static int handle_unaligned_ins(opcode_t
 		dst = (unsigned char*) *rn;
 		dst += (instruction&0x000F)<<2;
 
-		if (copy_to_user(dst,src,4))
+		if (ma->to(dst, src, 4))
 			goto fetch_fault;
 		ret = 0;
 		break;
@@ -243,7 +249,7 @@ static int handle_unaligned_ins(opcode_t
 #if !defined(__LITTLE_ENDIAN__)
 		src += 4-count;
 #endif
-		if (copy_to_user(dst, src, count))
+		if (ma->to(dst, src, count))
 			goto fetch_fault;
 		ret = 0;
 		break;
@@ -254,7 +260,7 @@ static int handle_unaligned_ins(opcode_t
 		dst = (unsigned char*) rn;
 		*(unsigned long*)dst = 0;
 
-		if (copy_from_user(dst,src,4))
+		if (ma->from(dst, src, 4))
 			goto fetch_fault;
 		ret = 0;
 		break;
@@ -269,7 +275,7 @@ static int handle_unaligned_ins(opcode_t
 #if !defined(__LITTLE_ENDIAN__)
 		dst += 4-count;
 #endif
-		if (copy_from_user(dst, src, count))
+		if (ma->from(dst, src, count))
 			goto fetch_fault;
 		sign_extend(count, dst);
 		ret = 0;
@@ -285,7 +291,7 @@ static int handle_unaligned_ins(opcode_t
 			dst = (unsigned char*) *rm; /* called Rn in the spec */
 			dst += (instruction&0x000F)<<1;
 
-			if (copy_to_user(dst, src, 2))
+			if (ma->to(dst, src, 2))
 				goto fetch_fault;
 			ret = 0;
 			break;
@@ -299,7 +305,7 @@ static int handle_unaligned_ins(opcode_t
 #if !defined(__LITTLE_ENDIAN__)
 			dst += 2;
 #endif
-			if (copy_from_user(dst, src, 2))
+			if (ma->from(dst, src, 2))
 				goto fetch_fault;
 			sign_extend(2, dst);
 			ret = 0;
@@ -320,8 +326,9 @@ static int handle_unaligned_ins(opcode_t
  * emulate the instruction in the delay slot
  * - fetches the instruction from PC+2
  */
-static inline int handle_unaligned_delayslot(struct pt_regs *regs,
-					     opcode_t old_instruction)
+static inline int handle_delayslot(struct pt_regs *regs,
+				   opcode_t old_instruction,
+				   struct mem_access *ma)
 {
 	opcode_t instruction;
 	void *addr = (void *)(regs->pc + instruction_size(old_instruction));
@@ -336,7 +343,7 @@ static inline int handle_unaligned_delay
 		    regs, 0);
 	}
 
-	return handle_unaligned_ins(instruction, regs);
+	return handle_unaligned_ins(instruction, regs, ma);
 }
 
 /*
@@ -362,7 +369,8 @@ static inline int handle_unaligned_delay
 
 static int handle_unaligned_notify_count = 10;
 
-static int handle_unaligned_access(opcode_t instruction, struct pt_regs *regs)
+int handle_unaligned_access(opcode_t instruction, struct pt_regs *regs,
+			    struct mem_access *ma)
 {
 	u_int rm;
 	int ret, index;
@@ -385,19 +393,19 @@ static int handle_unaligned_access(opcod
 	case 0x0000:
 		if (instruction=0x000B) {
 			/* rts */
-			ret = handle_unaligned_delayslot(regs, instruction);
+			ret = handle_delayslot(regs, instruction, ma);
 			if (ret=0)
 				regs->pc = regs->pr;
 		}
 		else if ((instruction&0x00FF)=0x0023) {
 			/* braf @Rm */
-			ret = handle_unaligned_delayslot(regs, instruction);
+			ret = handle_delayslot(regs, instruction, ma);
 			if (ret=0)
 				regs->pc += rm + 4;
 		}
 		else if ((instruction&0x00FF)=0x0003) {
 			/* bsrf @Rm */
-			ret = handle_unaligned_delayslot(regs, instruction);
+			ret = handle_delayslot(regs, instruction, ma);
 			if (ret=0) {
 				regs->pr = regs->pc + 4;
 				regs->pc += rm + 4;
@@ -418,13 +426,13 @@ static int handle_unaligned_access(opcod
 	case 0x4000:
 		if ((instruction&0x00FF)=0x002B) {
 			/* jmp @Rm */
-			ret = handle_unaligned_delayslot(regs, instruction);
+			ret = handle_delayslot(regs, instruction, ma);
 			if (ret=0)
 				regs->pc = rm;
 		}
 		else if ((instruction&0x00FF)=0x000B) {
 			/* jsr @Rm */
-			ret = handle_unaligned_delayslot(regs, instruction);
+			ret = handle_delayslot(regs, instruction, ma);
 			if (ret=0) {
 				regs->pr = regs->pc + 4;
 				regs->pc = rm;
@@ -451,7 +459,7 @@ static int handle_unaligned_access(opcod
 		case 0x0B00: /* bf   lab - no delayslot*/
 			break;
 		case 0x0F00: /* bf/s lab */
-			ret = handle_unaligned_delayslot(regs, instruction);
+			ret = handle_delayslot(regs, instruction, ma);
 			if (ret=0) {
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SH7705_CACHE_32KB)
 				if ((regs->sr & 0x00000001) != 0)
@@ -464,7 +472,7 @@ static int handle_unaligned_access(opcod
 		case 0x0900: /* bt   lab - no delayslot */
 			break;
 		case 0x0D00: /* bt/s lab */
-			ret = handle_unaligned_delayslot(regs, instruction);
+			ret = handle_delayslot(regs, instruction, ma);
 			if (ret=0) {
 #if defined(CONFIG_CPU_SH4) || defined(CONFIG_SH7705_CACHE_32KB)
 				if ((regs->sr & 0x00000001) = 0)
@@ -478,13 +486,13 @@ static int handle_unaligned_access(opcod
 		break;
 
 	case 0xA000: /* bra label */
-		ret = handle_unaligned_delayslot(regs, instruction);
+		ret = handle_delayslot(regs, instruction, ma);
 		if (ret=0)
 			regs->pc += SH_PC_12BIT_OFFSET(instruction);
 		break;
 
 	case 0xB000: /* bsr label */
-		ret = handle_unaligned_delayslot(regs, instruction);
+		ret = handle_delayslot(regs, instruction, ma);
 		if (ret=0) {
 			regs->pr = regs->pc + 4;
 			regs->pc += SH_PC_12BIT_OFFSET(instruction);
@@ -495,7 +503,7 @@ static int handle_unaligned_access(opcod
 
 	/* handle non-delay-slot instruction */
  simple:
-	ret = handle_unaligned_ins(instruction, regs);
+	ret = handle_unaligned_ins(instruction, regs, ma);
 	if (ret=0)
 		regs->pc += instruction_size(instruction);
 	return ret;
@@ -558,7 +566,8 @@ asmlinkage void do_address_error(struct 
 			goto uspace_segv;
 		}
 
-		tmp = handle_unaligned_access(instruction, regs);
+		tmp = handle_unaligned_access(instruction, regs,
+					      &user_mem_access);
 		set_fs(oldfs);
 
 		if (tmp=0)
@@ -587,7 +596,7 @@ uspace_segv:
 			die("insn faulting in do_address_error", regs, 0);
 		}
 
-		handle_unaligned_access(instruction, regs);
+		handle_unaligned_access(instruction, regs, &user_mem_access);
 		set_fs(oldfs);
 	}
 }
--- 0001/arch/sh/mm/fault_32.c
+++ work/arch/sh/mm/fault_32.c	2008-02-07 18:54:11.000000000 +0900
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
+++ work/include/asm-sh/io.h	2008-02-07 18:54:11.000000000 +0900
@@ -38,6 +38,7 @@
  */
 #define __IO_PREFIX	generic
 #include <asm/io_generic.h>
+#include <asm/io_trapped.h>
 
 #define maybebadio(port) \
   printk(KERN_ERR "bad PC-like io %s:%u for port 0x%lx at 0x%08x\n", \
@@ -207,6 +208,8 @@ static inline void __set_io_port_base(un
 	generic_io_base = pbase;
 }
 
+#define __ioport_map(p, n) sh_mv.mv_ioport_map((p), (n))
+
 /* We really want to try and get these to memcpy etc */
 extern void memcpy_fromio(void *, volatile void __iomem *, unsigned long);
 extern void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
@@ -309,7 +312,14 @@ __ioremap_mode(unsigned long offset, uns
 {
 #ifdef CONFIG_SUPERH32
 	unsigned long last_addr = offset + size - 1;
+#endif
+	void __iomem *ret;
 
+	ret = __ioremap_trapped(offset, size);
+	if (ret)
+		return ret;
+
+#ifdef CONFIG_SUPERH32
 	/*
 	 * For P1 and P2 space this is trivial, as everything is already
 	 * mapped. Uncached access for P1 addresses are done through P2.
--- /dev/null
+++ work/include/asm-sh/io_trapped.h	2008-02-07 18:54:11.000000000 +0900
@@ -0,0 +1,58 @@
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
+	unsigned int minimum_bus_width;
+	struct list_head list;
+	void __iomem *virt_base;
+} __aligned(PAGE_SIZE);
+
+#ifdef CONFIG_IO_TRAPPED
+int register_trapped_io(struct trapped_io *tiop);
+int handle_trapped_io(struct pt_regs *regs, unsigned long address);
+
+void __iomem *match_trapped_io_handler(struct list_head *list,
+				       unsigned long offset,
+				       unsigned long size);
+
+#ifdef CONFIG_HAS_IOMEM
+extern struct list_head trapped_mem;
+
+static inline void __iomem *
+__ioremap_trapped(unsigned long offset, unsigned long size)
+{
+	return match_trapped_io_handler(&trapped_mem, offset, size);
+}
+#else
+#define __ioremap_trapped(offset, size) NULL
+#endif
+
+#ifdef CONFIG_HAS_IOPORT
+extern struct list_head trapped_io;
+
+static inline void __iomem *
+__ioport_map_trapped(unsigned long offset, unsigned long size)
+{
+	return match_trapped_io_handler(&trapped_io, offset, size);
+}
+#else
+#define __ioport_map_trapped(offset, size) NULL
+#endif
+
+#else
+#define register_trapped_io(tiop) (-1)
+#define handle_trapped_io(tiop, address) 0
+#define __ioremap_trapped(offset, size) NULL
+#define __ioport_map_trapped(offset, size) NULL
+#endif
+
+#endif /* __ASM_SH_IO_TRAPPED_H */
--- 0001/include/asm-sh/system.h
+++ work/include/asm-sh/system.h	2008-02-07 18:54:11.000000000 +0900
@@ -182,6 +182,11 @@ BUILD_TRAP_HANDLER(fpu_state_restore);
 
 #define arch_align_stack(x) (x)
 
+struct mem_access {
+	unsigned long (*from)(void *dst, const void *src, unsigned long cnt);
+	unsigned long (*to)(void *dst, const void *src, unsigned long cnt);
+};
+
 #ifdef CONFIG_SUPERH32
 # include "system_32.h"
 #else
--- 0001/include/asm-sh/system_32.h
+++ work/include/asm-sh/system_32.h	2008-02-07 18:54:11.000000000 +0900
@@ -96,4 +96,7 @@ do {							\
 		: "=&r" (__dummy));			\
 } while (0)
 
+int handle_unaligned_access(opcode_t instruction, struct pt_regs *regs,
+			    struct mem_access *ma);
+
 #endif /* __ASM_SH_SYSTEM_32_H */
