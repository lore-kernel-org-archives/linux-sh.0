From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 02 May 2017 10:25:19 +0000
Subject: endless loop in futex code since commit 00b73d8d1b71
Message-Id: <20170502102519.iukf6bf3u55wrdbp@aurel32.net>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

Commit 00b73d8d1b71 ("sh: add working futex atomic ops on userspace
addresses for smp") introduce a loop over the atomic code used in
futex_atomic_op_inuser. On a SH7751R based machine (actually QEMU
emulated), therefore using the futex-irq.h code, this causes a deadlock:

    [   40.092000] NMI watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [rsyslogd:401]
    [   40.092000] Modules linked in:
    [   40.092000]
    [   40.092000] CPU: 0 PID: 401 Comm: rsyslogd Not tainted 4.8.5 #18
    [   40.092000] task: 8fed96c0 task.stack: 8ec56000
    [   40.092000] PC is at arch_local_save_flags+0x0/0x8
    [   40.092000] PR is at do_futex+0x5d6/0x8d4
    [   40.092000] PC  : 8c0128c8 SP  : 8ec57ec0 SR  : 40008001 TEA : 295b3cc0
    [   40.092000] R0  : 00000000 R1  : 80000000 R2  : 00000001 R3  : 8c0128c8
    [   40.092000] R4  : 00000000 R5  : 8c0128d0 R6  : 00a3bbb9 R7  : 00000001
    [   40.092000] R8  : ffffffff R9  : 00000000 R10 : 00000000 R11 : 00000000
    [   40.092000] R12 : 00473878 R13 : 00000000 R14 : 8ec57ec0
    [   40.092000] MACH: 00000000 MACL: 47ae147b GBR : 295784d0 PR  : 8c0819ae
    [   40.092000]
    [   40.092000] Call trace:
    [   40.092000]  [<8c07c654>] clockevents_program_event+0x88/0x1b4
    [   40.092000]  [<8c06fa94>] hrtimer_interrupt+0xa0/0x1a0
    [   40.092000]  [<8c07d348>] tick_program_event+0x0/0x90
    [   40.092000]  [<8c04dbfc>] pick_next_task_fair+0x190/0x1f0
    [   40.092000]  [<8c081d24>] SyS_futex+0x78/0x154
    [   40.092000]  [<8c52c864>] handle_tlbmiss+0x90/0x140
    [   40.092000]  [<8c018242>] syscall_call+0x18/0x1e
    [   40.092000]  [<8c081cac>] SyS_futex+0x0/0x154
    [   40.092000]
    [   40.092000] Code:
    [   40.092000]   8c0128c2:  .word 0x8c63
    [   40.092000]   8c0128c4:  add       #76, r1
    [   40.092000]   8c0128c6:  .word 0x8c5e
    [   40.092000] ->8c0128c8:  stc       sr, r0
    [   40.092000]   8c0128ca:  and       #-16, r0
    [   40.092000]   8c0128cc:  rts
    [   40.092000]   8c0128ce:  nop
    [   40.092000]   8c0128d0:  mov.w     8c0128f0 <arch_local_irq_restore+0x20/0x24>, r1  ! 000000f0 <0xf0>
    [   40.092000]   8c0128d2:  cmp/eq    r1, r4
    [   40.092000]

The deadlock happens in the FUTEX_OP_SET case, with oparg = 0 and
*uaddr = 1. In that case oldval = 0, so newval is not written to *uaddr
and prev get set to 1. It means that the while condition prev != oldval
is always true, leading to an endless loop.

The previous code didn't have this while loop. It looks like something
is wrong somewhere in the new code. Any idea?

Thanks,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
