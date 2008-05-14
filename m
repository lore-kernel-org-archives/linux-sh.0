From: Hideo Saito <saito@densan.co.jp>
Date: Wed, 14 May 2008 02:09:00 +0000
Subject: fix entry-common.S
Message-Id: <20080514.110900.125129265.saito@densan.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul,

In the code on entry-common.S, it seems that the following fix is needed, because the code causes to jump to |resume_userspace| from |syscall_badsys| without set r8.

--- arch/sh/kernel/entry-common.S.org	2008-04-17 11:49:44.000000000 +0900
+++ arch/sh/kernel/entry-common.S	2008-04-21 14:47:14.000000000 +0900
@@ -143,16 +143,17 @@ noresched:
 #ifdef CONFIG_TRACE_IRQFLAGS
 3:	.long	trace_hardirqs_on
 4:	.long	trace_hardirqs_off
 #endif
 #endif
 
 ENTRY(resume_userspace)
 	! r8: current_thread_info
+	get_current_thread_info r8, r0
 	cli
 #ifdef CONFIG_TRACE_IRQFLAGS
 	mov.l	5f, r0
 	jsr	@r0
 	 nop
 #endif
 	mov.l	@(TI_FLAGS,r8), r0		! current_thread_info->flags
 	tst	#_TIF_WORK_MASK, r0
