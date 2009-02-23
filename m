From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 23 Feb 2009 07:19:31 +0000
Subject: [PATCH 04/04] sh: prefetch early exception data on sh3/sh4/sh4a
Message-Id: <20090223071931.12300.72669.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Prefetch early exception data. There is unused space in our
exception handler cache line anyway, so this is almost free.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh3/entry.S |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- 0007/arch/sh/kernel/cpu/sh3/entry.S
+++ work/arch/sh/kernel/cpu/sh3/entry.S	2009-02-23 14:18:48.000000000 +0900
@@ -463,9 +463,11 @@ tlb_miss:
 	sts	pr, k3		! save original pr value in k3
 
 handle_exception:
+	mova	exception_data, k0
+
 	! Setup stack and save DSP context (k0 contains original r15 on return)
 	bsr	prepare_stack_save_dsp
-	 nop
+	 pref	@k0
 
 	! Save registers / Switch to bank 0
 	mov.l	5f, k2		! vector register address
@@ -556,10 +558,11 @@ ENTRY(handle_interrupt)
 11:
 #endif /* defined(CONFIG_KGDB) */
 	sts	pr, k3		! save original pr value in k3
+	mova	exception_data, k0
 
 	! Setup stack and save DSP context (k0 contains original r15 on return)
 	bsr	prepare_stack_save_dsp
-	 nop
+	 pref	@k0
 
 	! Save registers / Switch to bank 0
 	bsr	save_regs	! needs original pr value in k3
