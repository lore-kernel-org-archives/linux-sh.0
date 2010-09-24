From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 24 Sep 2010 09:05:38 +0000
Subject: [PATCH] sh: boot kernel with SR.BL set
Message-Id: <20100924090538.13826.99190.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the SH kernel to keep SR.BL set until the VBR
register has been initialized. Useful to allow boot
of the kernel even though exceptions are pending.

Without this patch there is a window of time when
exceptions such as NMI are enabled but no exception
handlers are installed.

This patch modifies both the zImage loader and the
actual kernel to boot with BL=1, but the zImage
loader is modfied in such a way that the init_sr
value is unchanged to not break the zImage loader
provided by kexec.

Tested on sh7724 Ecovec and on the SH4AL-DSP core
included in sh7372.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/boot/compressed/head_32.S |    4 +++-
 arch/sh/kernel/head_32.S          |    2 +-
 arch/sh/kernel/traps_32.c         |    3 +++
 3 files changed, 7 insertions(+), 2 deletions(-)

--- 0001/arch/sh/boot/compressed/head_32.S
+++ work/arch/sh/boot/compressed/head_32.S	2010-09-24 17:52:43.000000000 +0900
@@ -91,7 +91,9 @@ bss_start_addr:
 end_addr:
 	.long	_end
 init_sr:
-	.long	0x400000F0	/* Privileged mode, Bank=0, Block=0, IMASK=0xF */
+	.long	0x500000F0	/* Privileged mode, Bank=0, Block=1, IMASK=0xF */
+kexec_magic:
+	.long	0x400000F0	/* magic used by kexec to parse zImage format */
 init_stack_addr:
 	.long	stack_start
 decompress_kernel_addr:
--- 0001/arch/sh/kernel/head_32.S
+++ work/arch/sh/kernel/head_32.S	2010-09-24 17:48:10.000000000 +0900
@@ -330,7 +330,7 @@ ENTRY(_stext)
 #if defined(CONFIG_CPU_SH2)
 1:	.long	0x000000F0		! IMASK=0xF
 #else
-1:	.long	0x400080F0		! MD=1, RB=0, BL=0, FD=1, IMASK=0xF
+1:	.long	0x500080F0		! MD=1, RB=0, BL=1, FD=1, IMASK=0xF
 #endif
 ENTRY(stack_start)
 2:	.long	init_thread_union+THREAD_SIZE
--- 0001/arch/sh/kernel/traps_32.c
+++ work/arch/sh/kernel/traps_32.c	2010-09-24 17:48:10.000000000 +0900
@@ -802,6 +802,9 @@ void __cpuinit per_cpu_trap_init(void)
 		     : /* no output */
 		     : "r" (&vbr_base)
 		     : "memory");
+
+	/* disable exception blocking now when the vbr has been setup */
+	clear_bl_bit();
 }
 
 void *set_exception_table_vec(unsigned int vec, void *handler)
