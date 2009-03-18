From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Mar 2009 05:31:49 +0000
Subject: [PATCH] sh: simplify kexec vbr code
Message-Id: <20090318053149.22163.40168.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Setup the vbr register in machine_kexec() instead of
passing values to the assembly snippet.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/machine_kexec.c   |   16 +++++++---------
 arch/sh/kernel/relocate_kernel.S |    4 ----
 2 files changed, 7 insertions(+), 13 deletions(-)

--- 0001/arch/sh/kernel/machine_kexec.c
+++ work/arch/sh/kernel/machine_kexec.c	2009-03-18 11:43:51.000000000 +0900
@@ -23,8 +23,7 @@
 typedef NORET_TYPE void (*relocate_new_kernel_t)(
 				unsigned long indirection_page,
 				unsigned long reboot_code_buffer,
-				unsigned long start_address,
-				unsigned long vbr_reg) ATTRIB_NORET;
+				unsigned long start_address) ATTRIB_NORET;
 
 extern const unsigned char relocate_new_kernel[];
 extern const unsigned int relocate_new_kernel_size;
@@ -76,14 +75,8 @@ void machine_kexec(struct kimage *image)
 
 	unsigned long page_list;
 	unsigned long reboot_code_buffer;
-	unsigned long vbr_reg;
 	relocate_new_kernel_t rnk;
 
-#if defined(CONFIG_SH_STANDARD_BIOS)
-	vbr_reg = ((unsigned long )gdb_vbr_vector) - 0x100;
-#else
-	vbr_reg = 0x80000000;  // dummy
-#endif
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 
@@ -100,9 +93,14 @@ void machine_kexec(struct kimage *image)
         kexec_info(image);
 	flush_cache_all();
 
+#if defined(CONFIG_SH_STANDARD_BIOS)
+	asm volatile("ldc %0, vbr" :
+		     : "r" (((unsigned long) gdb_vbr_vector) - 0x100)
+		     : "memory");
+#endif
 	/* now call it */
 	rnk = (relocate_new_kernel_t) reboot_code_buffer;
-	(*rnk)(page_list, reboot_code_buffer, P2SEGADDR(image->start), vbr_reg);
+	(*rnk)(page_list, reboot_code_buffer, P2SEGADDR(image->start));
 }
 
 void arch_crash_save_vmcoreinfo(void)
--- 0001/arch/sh/kernel/relocate_kernel.S
+++ work/arch/sh/kernel/relocate_kernel.S	2009-03-18 11:43:27.000000000 +0900
@@ -16,7 +16,6 @@ relocate_new_kernel:
 	/* r4 = indirection_page   */
 	/* r5 = reboot_code_buffer */
 	/* r6 = start_address      */
-	/* r7 = vbr_reg            */
 
 	mov.l	10f,r8	  /* PAGE_SIZE */
 	mov.l	11f,r9    /* P2SEG */
@@ -80,9 +79,6 @@ relocate_new_kernel:
 	bra	0b
 	nop
 6:
-#ifdef CONFIG_SH_STANDARD_BIOS
-	ldc   r7, vbr
-#endif
 	jmp @r6
 	nop
 
