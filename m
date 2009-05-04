From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 04 May 2009 09:15:23 +0000
Subject: 2.6.30-rc4-git: timer-related oops
Message-Id: <20090504091523.GA25786@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20090504091430.GA30660@linux-sh.org>
In-Reply-To: <20090504091430.GA30660@linux-sh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello!

Current -git (and a few revisions before that) oops when kernel tries to
mount nfsroot.  Anyone else seeing this?  (system is SH7760; I disabled
almost all of my platform code to rule out a screwup on my part. The code
works on 2.6.29).


This is without hrtimer and without dyntick:

Looking up port of RPC 100003/3 on 192.168.44.70
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Unable to handle kernel paging request at virtual address 00014274
pc = 0000000a
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:

Pid : 0, Comm:          swapper
CPU : 0                 Not tainted  (2.6.30-rc4-exm7760 #1)

PC is at 0xa
PR is at 0x14244
PC  : 0000000a SP  : 00000000 SR  : 00000000 TEA : 00014274
R0  : 0000003f R1  : ffffffb8 R2  : 40008100 R3  : 8c2d3e68
R4  : 8c2a073c R5  : 000025a3 R6  : ffffffff R7  : ffffffff
R8  : 00014244 R9  : 0000000a R10 : 00000000 R11 : 000108ed
R12 : 8c027ef4 R13 : 8c027ef4 R14 : 000075bf
MACH: fffebdbc MACL: ffffffff GBR : 8c29a63c PR  : 00014244
Code:
 (Bad address in pc)

Process: swapper (pid: 0, stack limit = 8c297001)
Stack: (0x00000000 to 0x8c298000)
0000:
Kernel panic - not syncing: Fatal exception in interrupt
Stack: (0x8c2d3e28 to 0x8c298000)

Call trace:
[<8c005c5c>] die+0xdc/0x148
[<8c1dfb18>] printk+0x0/0x28
[<8c00d2dc>] do_page_fault+0x1c0/0x2ec
[<8c1dfb18>] printk+0x0/0x28
[<8c003548>] do_IRQ+0x18/0xb0
[<8c0070e4>] ret_from_exception+0x0/0xc
[<8c003530>] do_IRQ+0x0/0xb0
[<8c014080>] emit_log_char+0x0/0x64
[<8c014898>] vprintk+0x1c0/0x23c
[<8c014884>] vprintk+0x1ac/0x23c
[<8c0070e4>] ret_from_exception+0x0/0xc
[<8c1dfb18>] printk+0x0/0x28
[<8c027ef4>] update_wall_time+0x30/0x5fc
[<8c0070e4>] ret_from_exception+0x0/0xc
[<8c027f7a>] update_wall_time+0xb6/0x5fc
[<8c0d0716>] __ashldi3+0x0/0x2a
[<8c027ef4>] update_wall_time+0x30/0x5fc
[<8c01af82>] do_timer+0x26/0xb4
[<8c1dfb18>] printk+0x0/0x28
[<8c00573e>] sched_clock+0x22/0x58
[<8c010882>] scheduler_tick+0x16/0x84
[<8c02a914>] tick_handle_periodic+0x18/0xc8
[<8c1dfb18>] printk+0x0/0x28
[<8c00b738>] tmu_timer_interrupt+0x38/0x50
[<8c1dfb18>] printk+0x0/0x28
[<8c03033c>] handle_IRQ_event+0x5c/0x10c
[<8c031944>] handle_level_irq+0x64/0xa0
[<8c014080>] emit_log_char+0x0/0x64
[<8c003586>] do_IRQ+0x56/0xb0
[<8c003514>] generic_handle_irq+0x0/0x1c



Here's one with dyntick and with hrtimer enabled:

Looking up port of RPC 100003/3 on 192.168.44.70
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
Looking up port of RPC 100005/3 on 192.168.44.70
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc = 00000000
*pde = 00000000
Oops: 0000 [#1]
Modules linked in:

Pid : 1, Comm:          swapper
CPU : 0                 Not tainted  (2.6.30-rc4-exm7760 #3)

PC is at 0x0
PR is at 0x0
PC  : 00000000 SP  : 8c2dbf78 SR  : 400081f1 TEA : 00000000
R0  : 00000001 R1  : 8c2b2e14 R2  : 8c2a1198 R3  : 8f818000
R4  : 00000000 R5  : 00000004 R6  : 00002000 R7  : 000000f0
R8  : 8c02593c R9  : 8c02b48a R10 : 00000004 R11 : 8c2a9fd4
R12 : 8c2a4388 R13 : 8c013ecc R14 : 00000000
MACH: 00011854 MACL: 00000500 GBR : 00000000 PR  : 00000000

Call trace:
[<8c025fe6>] hrtimer_interrupt+0x122/0x174
[<8c00b738>] tmu_timer_interrupt+0x38/0x50
[<8c1e460c>] printk+0x0/0x28
[<8c031bb8>] handle_IRQ_event+0x5c/0x10c
[<8c0331c0>] handle_level_irq+0x64/0xa0
[<8c013ecc>] emit_log_char+0x0/0x64
[<8c00359e>] do_IRQ+0x56/0xb0
[<8c00352c>] generic_handle_irq+0x0/0x1c

Code:
  fffffffa:  .word 0x0000
  fffffffc:  .word 0x0000
  fffffffe:  .word 0x0000
 (Bad address in pc)

Process: swapper (pid: 1, stack limit = 8f818001)



Thanks,
	Manuel Lauss
