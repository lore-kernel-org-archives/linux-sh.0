From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Thu, 04 Sep 2008 12:39:17 +0000
Subject: [PATCH] resume_kernel fix for kernel oops built with CONFIG_BKL_PREEMPT=y
Message-Id: <48BFD6F5.5030508@st.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030105030706050402080606"
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

This is a multi-part message in MIME format.
--------------030105030706050402080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,
attached patch solves a kernel OOPS discovered while running LTP 
testsuite (doio test) with kernel 2.6.23.y (rootf on hd).
Attached for your reference the output of the test and the kernel oops.

The problems is within the SH implementation of resume_kernel code,
that implements in assembly the bulk of preempt_schedule_irq function 
without taking care of the extra code needed to handle the BKL preemptible.

The patch basically consists of removing this asm code and calling the 
common C implementation (see kernel/sched.c) as other archs do.

Another change is the missing 'cli' macro invocation at the beginning of 
the resume_kernel.

In the new kernels (2.6.26 and later) this patch may be not so required 
because BKL will be again *not* preemptible; anyway, it may be worth 
aligning the SH implementation with others to rely on common C code.


Best regards,
Carmelo & Peppe



--------------030105030706050402080606
Content-Type: text/plain;
 name="doio.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="doio.log"

root@amorosoc:/usr/ltp/testcases/bin# ./go.sh 
/usr/ltp/testcases/bin/iogen -N iogen01 -i 120s -s read,write 500b:doio.f1.1201 1000b:doio.f2.1201 | /usr/ltp/testcases/bin/doio -N iogen01 -a -v -n 2 -k

iogen(iogen01) starting up with the following:

Out-pipe:              stdout
Iterations:            120 seconds
Seed:                  1217
Offset-Mode:           sequential
Overlap Flag:          off
Mintrans:              1           (1 blocks)
Maxtrans:              131072      (256 blocks)
O_RAW/O_SSD Multiple:  (Determined by device)
Syscalls:              read write 
Aio completion types:  none 
Flags:                 buffered sync 

Test Files:  

Path                                          Length    iou   raw iou file
                                              (bytes) (bytes) (bytes) type
-----------------------------------------------------------------------------
/usr/ltp/testcases/bin/doio.f1.1201            256000       1     512 regular
/usr/ltp/testcases/bin/doio.f2.1201            512000       1     512 regular

Message from syslogd@amorosoc at Sat Jan  1 00:04:56 2000 ...
amorosoc kernel: ------------[ cut here ]------------

doio(iogen01) ( 1216) 00:04:57
---------------------
(parent) pid 1218 terminated by signal 11
rwtest(iogen01) : doio reported errors (r=32)
iogen01     1  FAIL  :  doio reported errors (r=32)
iogen01     1  FAIL  :  Test failed


--------------030105030706050402080606
Content-Type: text/plain;
 name="oops.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oops.log"

root@amorosoc:~# ------------[ cut here ]------------
Kernel BUG at 84088240 [verbose debug info unavailable]
Kernel BUG: 003e [#1]
Modules linked in:

Pid : 1218, Comm:                 doio
PC is at locks_free_lock+0x80/0xc0
PC  : 84088240 SP  : 84ed5ea8 SR  : 40008000 TEA : 29560000    Not tainted
R0  : 00000000 R1  : 850dbf84 R2  : 850dbecc R3  : 8446eb60
R4  : 850dbf80 R5  : 850dbdb4 R6  : 00000000 R7  : 00024000
R8  : 850dbf80 R9  : 00000000 R10 : 00000000 R11 : 00000000
R12 : 000294c8 R13 : 00000000 R14 : 84ed5ea8
MACH: 00000000 MACL: 00000000 GBR : 29560430 PR  : 840886fa

Call trace: 
[<840886fa>] __posix_lock_file+0x7a/0x640
[<84088cce>] posix_lock_file+0xe/0x20
[<84088d08>] vfs_lock_file+0x28/0x40
[<8408a6ae>] fcntl_setlk+0x10e/0x280
[<840843ee>] do_fcntl+0x2e/0x400
[<840847fc>] sys_fcntl64+0x3c/0xa0
[<84008224>] syscall_call+0xc/0x10
[<840847c0>] sys_fcntl64+0x0/0xa0

Process: doio (pid: 1218, stack limit = 84ed4001)
Stack: (0x84ed5ea8 to 0x84ed6000)
5ea0:                   840886fa 84ed5eb4 00000000 850db651 850dbf4d 850db628 
5ec0: 850dbdb4 850dbf80 00000000 84e76d0c 00000001 00000000 84088cce 84ed5ef8 
5ee0: 852c1b20 84ed5f28 84ed4000 850db628 00000000 850db644 84088d08 84ed5f00 
5f00: 8408a6ae 84ed5f08 84ed4000 852c1b3c 850db650 00019c26 00000007 00000008 
5f20: 00000020 00000000 00000000 00000000 00000000 00000001 0043c320 00000002 
5f40: 000294c8 00019c26 fff1fff2 840843ee 84ed5f6c 00000000 7be3e620 fffffff7 
5f60: 00000008 7be3e620 852c1b20 840847fc 84ed5f84 fffffff7 852c1b20 00000008 
5f80: 00000007 84008224 7be3e5b4 296113a4 ffffff0f 00000021 84ed5ff8 840847c0 
5fa0: fffffbd0 7be3e5d8 00000000 000000dd 00000008 00000007 7be3e620 7be3e5e0 
5fc0: 00000007 7be3e620 00000008 00400ec4 296113a4 00000000 7be3e5b4 7be3e5b4 
5fe0: 2957b820 00403c16 00000001 29560430 00000000 00000000 0000004c 00000160 

Message from syslogd@amorosoc at Sat Jan  1 00:04:56 2000 ...
amorosoc kernel: ------------[ cut here ]------------


--------------030105030706050402080606
Content-Type: text/plain;
 name="linux-sh4-2.6.23.17_stm23_0116-resume_kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-sh4-2.6.23.17_stm23_0116-resume_kernel.patch"

This patch fixes a problem within the SH implementation of resume_kernel code,
that implements in assembly the bulk of preempt_schedule_irq function without
taking care of the extra code needed to handle the BKL preemptible.

The patch basically consists of removing this asm code and calling the common
C implementation (see kernel/sched.c) as other archs do.

Another change is the missing 'cli' macro invocation at the beginning of the resume_kernel.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>

diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index d41ffd6..df91031 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -95,6 +95,7 @@ ENTRY(ret_from_irq)
 	bra	resume_userspace
 	 nop
 ENTRY(resume_kernel)
+	cli
 	mov.l	@(TI_PRE_COUNT,r8), r0	! current_thread_info->preempt_count
 	tst	r0, r0
 	bf	noresched
@@ -108,28 +109,9 @@ need_resched:
 	and	#0xf0, r0		! interrupts off (exception path)?
 	cmp/eq	#0xf0, r0
 	bt	noresched
-
-	mov.l	1f, r0
-	mov.l	r0, @(TI_PRE_COUNT,r8)
-
-#ifdef CONFIG_TRACE_IRQFLAGS
 	mov.l	3f, r0
-	jsr	@r0
-	 nop
-#endif
-	sti
-	mov.l	2f, r0
-	jsr	@r0
-	 nop
-	mov	#0, r0
-	mov.l	r0, @(TI_PRE_COUNT,r8)
-	cli
-#ifdef CONFIG_TRACE_IRQFLAGS
-	mov.l	4f, r0
-	jsr	@r0
+	jsr	@r0			! call preempt_schedule_irq
 	 nop
-#endif
-
 	bra	need_resched
 	 nop
 
@@ -140,10 +122,7 @@ noresched:
 	.align 2
 1:	.long	PREEMPT_ACTIVE
 2:	.long	schedule
-#ifdef CONFIG_TRACE_IRQFLAGS
-3:	.long	trace_hardirqs_on
-4:	.long	trace_hardirqs_off
-#endif
+3:	.long	preempt_schedule_irq
 #endif
 
 ENTRY(resume_userspace)

--------------030105030706050402080606--
