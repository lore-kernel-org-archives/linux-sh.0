From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Mar 2009 08:51:29 +0000
Subject: [PATCH] sh: add kexec jump support V2
Message-Id: <20090318085129.5943.83795.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add kexec jump support to the SuperH architecture V2.

Similar to the x86 implementation, with the following
exceptions:

- Instead of separating the assembly code flow into
two parts for regular kexec and kexec jump we use a
single code path. In the assembly snippet regular
kexec is just kexec jump that never comes back.

- Instead of using a swap page when moving data between
pages the page copy assembly routine has been modified
to exchange the data between the pages using registers.

- We walk the page list twice in machine_kexec() to
do and undo physical to virtual address conversion.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 Changes since V1:
 - rebased on top of new vbr and no segment patch
 - restore vbr
 - make sure exceptions are unblocked
 - added code to convert page list back to physical addresses

 Patches for kexec-tools have been merged earlier today.

 arch/sh/Kconfig                  |    7 +
 arch/sh/kernel/machine_kexec.c   |   32 +++++-
 arch/sh/kernel/relocate_kernel.S |  195 ++++++++++++++++++++++++++++++++------
 3 files changed, 202 insertions(+), 32 deletions(-)

--- 0004/arch/sh/Kconfig
+++ work/arch/sh/Kconfig	2009-03-18 16:39:39.000000000 +0900
@@ -558,6 +558,13 @@ config CRASH_DUMP
 
 	  For more details see Documentation/kdump/kdump.txt
 
+config KEXEC_JUMP
+	bool "kexec jump (EXPERIMENTAL)"
+	depends on SUPERH32 && KEXEC && HIBERNATION && EXPERIMENTAL
+	help
+	  Jump between original kernel and kexeced kernel and invoke
+	  code via KEXEC
+
 config SECCOMP
 	bool "Enable seccomp to safely compute untrusted bytecode"
 	depends on PROC_FS
--- 0006/arch/sh/kernel/machine_kexec.c
+++ work/arch/sh/kernel/machine_kexec.c	2009-03-18 17:30:23.000000000 +0900
@@ -14,20 +14,21 @@
 #include <linux/delay.h>
 #include <linux/reboot.h>
 #include <linux/numa.h>
+#include <linux/suspend.h>
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
 #include <asm/mmu_context.h>
 #include <asm/io.h>
 #include <asm/cacheflush.h>
 
-typedef NORET_TYPE void (*relocate_new_kernel_t)(
-				unsigned long indirection_page,
-				unsigned long reboot_code_buffer,
-				unsigned long start_address) ATTRIB_NORET;
+typedef void (*relocate_new_kernel_t)(unsigned long indirection_page,
+				      unsigned long reboot_code_buffer,
+				      unsigned long start_address);
 
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
 extern void *gdb_vbr_vector;
+extern void *vbr_base;
 
 void machine_shutdown(void)
 {
@@ -72,7 +73,6 @@ static void kexec_info(struct kimage *im
  */
 void machine_kexec(struct kimage *image)
 {
-
 	unsigned long page_list;
 	unsigned long reboot_code_buffer;
 	relocate_new_kernel_t rnk;
@@ -92,6 +92,11 @@ void machine_kexec(struct kimage *image)
 			*ptr = (unsigned long) phys_to_virt(*ptr);
 	}
 
+#ifdef CONFIG_KEXEC_JUMP
+	if (image->preserve_context)
+		save_processor_state();
+#endif
+
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
@@ -117,6 +122,23 @@ void machine_kexec(struct kimage *image)
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
 	(*rnk)(page_list, reboot_code_buffer, image->start);
+
+#ifdef CONFIG_KEXEC_JUMP
+	asm volatile("ldc %0, vbr" : : "r" (&vbr_base) : "memory");
+	local_irq_disable();
+	clear_bl_bit();
+	if (image->preserve_context)
+		restore_processor_state();
+
+	/* Convert page list back to physical addresses, what a mess. */
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE);
+	     ptr = (*ptr & IND_INDIRECTION) ?
+	       phys_to_virt(*ptr & PAGE_MASK) : ptr + 1) {
+		if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
+		    *ptr & IND_DESTINATION)
+			*ptr = virt_to_phys(*ptr);
+	}
+#endif
 }
 
 void arch_crash_save_vmcoreinfo(void)
--- 0006/arch/sh/kernel/relocate_kernel.S
+++ work/arch/sh/kernel/relocate_kernel.S	2009-03-18 16:39:39.000000000 +0900
@@ -4,6 +4,8 @@
  *
  * LANDISK/sh4 is supported. Maybe, SH archtecture works well.
  *
+ * 2009-03-18 Magnus Damm - Added Kexec Jump support
+ *
  * This source code is licensed under the GNU General Public License,
  * Version 2.  See the file COPYING for more details.
  */
@@ -17,14 +19,135 @@ relocate_new_kernel:
 	/* r5 = reboot_code_buffer */
 	/* r6 = start_address      */
 
-	mov.l	10f,r8	  /* PAGE_SIZE */
+	mov.l	10f, r0		/* PAGE_SIZE */
+	add	r5, r0		/* setup new stack at end of control page */
 
-	/*  stack setting */
-	add	r8,r5
-	mov	r5,r15
+	/* save r15->r8 to new stack */
+	mov.l	r15, @-r0
+	mov	r0, r15
+	mov.l	r14, @-r15
+	mov.l	r13, @-r15
+	mov.l	r12, @-r15
+	mov.l	r11, @-r15
+	mov.l	r10, @-r15
+	mov.l	r9, @-r15
+	mov.l	r8, @-r15
+
+	/* save other random registers */
+	sts.l	macl, @-r15
+	sts.l	mach, @-r15
+	stc.l	gbr, @-r15
+	stc.l	ssr, @-r15
+	stc.l	sr, @-r15
+	sts.l	pr, @-r15
+	stc.l	spc, @-r15
+
+	/* switch to bank1 and save r7->r0 */
+	mov.l	12f, r9
+	stc	sr, r8
+	or	r9, r8
+	ldc	r8, sr
+	mov.l	r7, @-r15
+	mov.l	r6, @-r15
+	mov.l	r5, @-r15
+	mov.l	r4, @-r15
+	mov.l	r3, @-r15
+	mov.l	r2, @-r15
+	mov.l	r1, @-r15
+	mov.l	r0, @-r15
+
+	/* switch to bank0 and save r7->r0 */
+	mov.l	12f, r9
+	not	r9, r9
+	stc	sr, r8
+	and	r9, r8
+	ldc	r8, sr
+	mov.l	r7, @-r15
+	mov.l	r6, @-r15
+	mov.l	r5, @-r15
+	mov.l	r4, @-r15
+	mov.l	r3, @-r15
+	mov.l	r2, @-r15
+	mov.l	r1, @-r15
+	mov.l	r0, @-r15
+
+	mov.l	r4, @-r15	/* save indirection page again */
+
+	bsr	swap_pages	/* swap pages before jumping to new kernel */
+	 nop
+
+	mova	11f, r0
+	mov.l	r15, @r0	/* save pointer to stack */
+
+	jsr	@r6		/* hand over control to new kernel */
+	 nop
+
+	mov.l	11f, r15	/* get pointer to stack */
+	mov.l	@r15+, r4	/* restore r4 to get indirection page */
+
+	bsr	swap_pages	/* swap pages back to previous state */
+	 nop
+
+	/* make sure bank0 is active and restore r0->r7 */
+	mov.l	12f, r9
+	not	r9, r9
+	stc	sr, r8
+	and	r9, r8
+	ldc	r8, sr
+	mov.l	@r15+, r0
+	mov.l	@r15+, r1
+	mov.l	@r15+, r2
+	mov.l	@r15+, r3
+	mov.l	@r15+, r4
+	mov.l	@r15+, r5
+	mov.l	@r15+, r6
+	mov.l	@r15+, r7
+
+	/* switch to bank1 and restore r0->r7 */
+	mov.l	12f, r9
+	stc	sr, r8
+	or	r9, r8
+	ldc	r8, sr
+	mov.l	@r15+, r0
+	mov.l	@r15+, r1
+	mov.l	@r15+, r2
+	mov.l	@r15+, r3
+	mov.l	@r15+, r4
+	mov.l	@r15+, r5
+	mov.l	@r15+, r6
+	mov.l	@r15+, r7
+
+	/* switch back to bank0 */
+	mov.l	12f, r9
+	not	r9, r9
+	stc	sr, r8
+	and	r9, r8
+	ldc	r8, sr
+
+	/* restore other random registers */
+	ldc.l	@r15+, spc
+	lds.l	@r15+, pr
+	ldc.l	@r15+, sr
+	ldc.l	@r15+, ssr
+	ldc.l	@r15+, gbr
+	lds.l	@r15+, mach
+	lds.l	@r15+, macl
+
+	/* restore r8->r15 */
+	mov.l	@r15+, r8
+	mov.l	@r15+, r9
+	mov.l	@r15+, r10
+	mov.l	@r15+, r11
+	mov.l	@r15+, r12
+	mov.l	@r15+, r13
+	mov.l	@r15+, r14
+	mov.l	@r15+, r15
+	rts
+	 nop
 
+swap_pages:
 	bra	1f
-	mov	r4,r0	  /* cmd = indirection_page */
+	 mov	r4,r0	  /* cmd = indirection_page */
 0:
 	mov.l	@r4+,r0	  /* cmd = *ind++ */
 
@@ -37,52 +160,70 @@ relocate_new_kernel:
 	tst	#1,r0
 	bt	2f
 	bra	0b
-	mov	r2,r5
+	 mov	r2,r5
 
 2:	/* else if(cmd & IND_INDIRECTION) ind = addr  */
 	tst	#2,r0
 	bt	3f
 	bra	0b
-	mov	r2,r4
+	 mov	r2,r4
 
-3:	/* else if(cmd & IND_DONE) goto 6  */
+3:	/* else if(cmd & IND_DONE) return */
 	tst	#4,r0
 	bt	4f
-	bra	6f
-	nop
+	rts
+	 nop
 
 4:	/* else if(cmd & IND_SOURCE) memcpy(dst,addr,PAGE_SIZE) */
 	tst	#8,r0
 	bt	0b
 
-	mov	r8,r3
+	mov.l	10f,r3	  /* PAGE_SIZE */
 	shlr2	r3
 	shlr2	r3
 5:
 	dt	r3
-	mov.l	@r2+,r1   /*  16n+0 */
-	mov.l	r1,@r5
-	add	#4,r5
-	mov.l	@r2+,r1	  /*  16n+4 */
-	mov.l	r1,@r5
-	add	#4,r5
-	mov.l	@r2+,r1   /*  16n+8 */
-	mov.l	r1,@r5
-	add	#4,r5
-	mov.l	@r2+,r1   /*  16n+12 */
-	mov.l	r1,@r5
-	add	#4,r5
+
+	/* regular kexec just overwrites the destination page
+	 * with the contents of the source page.
+	 * for the kexec jump case we need to swap the contents
+	 * of the pages.
+	 * to keep it simple swap the contents for both cases.
+	 */
+	mov.l	@(0, r2), r8
+	mov.l	@(0, r5), r1
+	mov.l	r8, @(0, r5)
+	mov.l	r1, @(0, r2)
+
+	mov.l	@(4, r2), r8
+	mov.l	@(4, r5), r1
+	mov.l	r8, @(4, r5)
+	mov.l	r1, @(4, r2)
+
+	mov.l	@(8, r2), r8
+	mov.l	@(8, r5), r1
+	mov.l	r8, @(8, r5)
+	mov.l	r1, @(8, r2)
+
+	mov.l	@(12, r2), r8
+	mov.l	@(12, r5), r1
+	mov.l	r8, @(12, r5)
+	mov.l	r1, @(12, r2)
+
+	add	#16,r5
+	add	#16,r2
 	bf	5b
 
 	bra	0b
-	nop
-6:
-	jmp @r6
-	nop
+	 nop
 
 	.align 2
 10:
 	.long	PAGE_SIZE
+11:
+	.long	0
+12:
+	.long	0x20000000 ! RB=1
 
 relocate_new_kernel_end:
 
