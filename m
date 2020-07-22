From: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Date: Wed, 22 Jul 2020 23:13:20 +0000
Subject: [PATCH 2/4] sh: Rearrange blocks in entry-common.S
Message-Id: <20200722231322.419642-2-kernel@mkarcher.dialup.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
In-Reply-To: <20200722231322.419642-1-kernel@mkarcher.dialup.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>

This avoids out-of-range jumps that get auto-replaced by the assembler
and prepares for the changes needed to implement SECCOMP_FILTER cleanly.

Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
---
 arch/sh/kernel/entry-common.S | 57 ++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index 9bac5bbb67f3..c4d88d61890d 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -178,34 +178,6 @@ syscall_exit_work:
 	bra	resume_userspace
 	 nop
 
-	.align	2
-syscall_trace_entry:
-	!                     	Yes it is traced.
-	mov     r15, r4
-	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
-	jsr	@r11	    	! superior (will chomp R[0-7])
-	 nop
-	mov.l	r0, @(OFF_R0,r15)	! Save return value
-	!			Reload R0-R4 from kernel stack, where the
-	!   	    	    	parent may have modified them using
-	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
-	!   	    	    	reloaded from the kernel stack by syscall_call
-	!   	    	    	below, so don't need to be reloaded here.)
-	!   	    	    	This allows the parent to rewrite system calls
-	!   	    	    	and args on the fly.
-	mov.l	@(OFF_R4,r15), r4   ! arg0
-	mov.l	@(OFF_R5,r15), r5
-	mov.l	@(OFF_R6,r15), r6
-	mov.l	@(OFF_R7,r15), r7   ! arg3
-	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
-	!
-	mov.l	6f, r10			! Number of syscalls
-	cmp/hs	r10, r3
-	bf	syscall_call
-	mov	#-ENOSYS, r0
-	bra	syscall_exit
-	 mov.l	r0, @(OFF_R0,r15)	! Return value
-
 __restore_all:
 	mov	#OFF_SR, r0
 	mov.l	@(r0,r15), r0	! get status register
@@ -388,6 +360,35 @@ syscall_exit:
 	bf	syscall_exit_work
 	bra	__restore_all
 	 nop
+
+	.align	2
+syscall_trace_entry:
+	!                     	Yes it is traced.
+	mov     r15, r4
+	mov.l	7f, r11		! Call do_syscall_trace_enter which notifies
+	jsr	@r11	    	! superior (will chomp R[0-7])
+	 nop
+	mov.l	r0, @(OFF_R0,r15)	! Save return value
+	!			Reload R0-R4 from kernel stack, where the
+	!   	    	    	parent may have modified them using
+	!   	    	    	ptrace(POKEUSR).  (Note that R0-R2 are
+	!   	    	    	reloaded from the kernel stack by syscall_call
+	!   	    	    	below, so don't need to be reloaded here.)
+	!   	    	    	This allows the parent to rewrite system calls
+	!   	    	    	and args on the fly.
+	mov.l	@(OFF_R4,r15), r4   ! arg0
+	mov.l	@(OFF_R5,r15), r5
+	mov.l	@(OFF_R6,r15), r6
+	mov.l	@(OFF_R7,r15), r7   ! arg3
+	mov.l	@(OFF_R3,r15), r3   ! syscall_nr
+	!
+	mov.l	6f, r10			! Number of syscalls
+	cmp/hs	r10, r3
+	bf	syscall_call
+	mov	#-ENOSYS, r0
+	bra	syscall_exit
+	 mov.l	r0, @(OFF_R0,r15)	! Return value
+
 	.align	2
 #if !defined(CONFIG_CPU_SH2)
 1:	.long	TRA
-- 
2.28.0.rc1
