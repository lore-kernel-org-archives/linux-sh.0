From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 11 Mar 2009 08:18:52 +0000
Subject: [PATCH] sh: break out vbr register code
Message-Id: <20090311081852.2041.19566.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add set_vbr_register(), get_vbr_register() and vbr_base
to system.h.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 This register needs to be modified by the suspend code
 as well, so break it out.

 arch/sh/include/asm/system.h |   19 +++++++++++++++++++
 arch/sh/kernel/traps_32.c    |   13 ++-----------
 2 files changed, 21 insertions(+), 11 deletions(-)


--- 0001/arch/sh/include/asm/system.h
+++ work/arch/sh/include/asm/system.h	2009-03-11 16:53:11.000000000 +0900
@@ -180,6 +180,25 @@ BUILD_TRAP_HANDLER(singlestep);
 BUILD_TRAP_HANDLER(fpu_error);
 BUILD_TRAP_HANDLER(fpu_state_restore);
 
+extern void *vbr_base;
+
+static inline void set_vbr_register(void *base)
+{
+	asm volatile("ldc       %0, vbr"
+		     : /* no output */
+		     : "r" (base)
+		     : "memory");
+}
+
+static inline void *get_vbr_register(void)
+{
+	register unsigned long vbr;
+
+	asm volatile("stc vbr, %0" : "=r" (vbr));
+
+	return (void *)vbr;
+}
+
 #define arch_align_stack(x) (x)
 
 struct mem_access {
--- 0001/arch/sh/kernel/traps_32.c
+++ work/arch/sh/kernel/traps_32.c	2009-03-11 16:52:16.000000000 +0900
@@ -768,16 +768,12 @@ void *gdb_vbr_vector;
 
 static inline void __init gdb_vbr_init(void)
 {
-	register unsigned long vbr;
-
 	/*
 	 * Read the old value of the VBR register to initialise
 	 * the vector through which debug and BIOS traps are
 	 * delegated by the Linux trap handler.
 	 */
-	asm volatile("stc vbr, %0" : "=r" (vbr));
-
-	gdb_vbr_vector = (void *)(vbr + 0x100);
+	gdb_vbr_vector = get_vbr_register() + 0x100;
 	printk("Setting GDB trap vector to 0x%08lx\n",
 	       (unsigned long)gdb_vbr_vector);
 }
@@ -785,8 +781,6 @@ static inline void __init gdb_vbr_init(v
 
 void __cpuinit per_cpu_trap_init(void)
 {
-	extern void *vbr_base;
-
 #ifdef CONFIG_SH_STANDARD_BIOS
 	if (raw_smp_processor_id() = 0)
 		gdb_vbr_init();
@@ -796,10 +790,7 @@ void __cpuinit per_cpu_trap_init(void)
 	   (or P2, virtural "fixed" address space).
 	   It's definitely should not in physical address.  */
 
-	asm volatile("ldc	%0, vbr"
-		     : /* no output */
-		     : "r" (&vbr_base)
-		     : "memory");
+	set_vbr_register(&vbr_base);
 }
 
 void *set_exception_table_vec(unsigned int vec, void *handler)
