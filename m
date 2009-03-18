From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Mar 2009 08:49:45 +0000
Subject: [PATCH] sh: rework kexec segment code
Message-Id: <20090318084945.5927.11325.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Rework the kexec code to avoid using P2SEG. Instead
we walk the page list in machine_kexec() and convert
the addresses from physical to virtual using C.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/machine_kexec.c   |   17 ++++++++++++++++-
 arch/sh/kernel/relocate_kernel.S |    6 +-----
 2 files changed, 17 insertions(+), 6 deletions(-)

--- 0005/arch/sh/kernel/machine_kexec.c
+++ work/arch/sh/kernel/machine_kexec.c	2009-03-18 16:38:37.000000000 +0900
@@ -76,6 +76,21 @@ void machine_kexec(struct kimage *image)
 	unsigned long page_list;
 	unsigned long reboot_code_buffer;
 	relocate_new_kernel_t rnk;
+	unsigned long entry;
+	unsigned long *ptr;
+
+	/*
+	 * Nicked from the mips version of machine_kexec():
+	 * The generic kexec code builds a page list with physical
+	 * addresses. Use phys_to_virt() to convert them to virtual.
+	 */
+	for (ptr = &image->head; (entry = *ptr) && !(entry & IND_DONE);
+	     ptr = (entry & IND_INDIRECTION) ?
+	       phys_to_virt(entry & PAGE_MASK) : ptr + 1) {
+		if (*ptr & IND_SOURCE || *ptr & IND_INDIRECTION ||
+		    *ptr & IND_DESTINATION)
+			*ptr = (unsigned long) phys_to_virt(*ptr);
+	}
 
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
@@ -101,7 +116,7 @@ void machine_kexec(struct kimage *image)
 #endif
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
-	(*rnk)(page_list, reboot_code_buffer, P2SEGADDR(image->start));
+	(*rnk)(page_list, reboot_code_buffer, image->start);
 }
 
 void arch_crash_save_vmcoreinfo(void)
--- 0005/arch/sh/kernel/relocate_kernel.S
+++ work/arch/sh/kernel/relocate_kernel.S	2009-03-18 16:01:42.000000000 +0900
@@ -18,7 +18,6 @@ relocate_new_kernel:
 	/* r6 = start_address      */
 
 	mov.l	10f,r8	  /* PAGE_SIZE */
-	mov.l	11f,r9    /* P2SEG */
 
 	/*  stack setting */
 	add	r8,r5
@@ -29,9 +28,8 @@ relocate_new_kernel:
 0:
 	mov.l	@r4+,r0	  /* cmd = *ind++ */
 
-1:	/* addr = (cmd | P2SEG) & 0xfffffff0 */
+1:	/* addr = cmd & 0xfffffff0 */
 	mov	r0,r2
-	or	r9,r2
 	mov	#-16,r1
 	and	r1,r2
 
@@ -85,8 +83,6 @@ relocate_new_kernel:
 	.align 2
 10:
 	.long	PAGE_SIZE
-11:
-	.long	P2SEG
 
 relocate_new_kernel_end:
 
