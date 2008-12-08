From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 08 Dec 2008 04:23:18 +0000
Subject: Re: Dreamcast oopses on boot
Message-Id: <20081208042318.GD12039@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1228567633.6763.2.camel@localhost.localdomain>
In-Reply-To: <1228567633.6763.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sat, Dec 06, 2008 at 12:47:13PM +0000, Adrian McMenamin wrote:
> [    3.512804] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [    3.520910] pc = 00000000
> [    3.523605] *pde = 00000000
> [    3.526490] Oops: 0000 [#1]
> [    3.529353] Modules linked in:
> [    3.532584] 
> [    3.534028] Pid : 1, Comm:              swapper
> [    3.538707] CPU : 0    Not tainted  (2.6.28-rc7-13830-g168fef8 #939)
> [    3.545348] PC is at 0x0
> [    3.547875] PR is at do_IRQ+0x42/0x80
> [    3.551638] PC  : 00000000 SP  : 8cc21ca8 SR  : 400081f1 TEA : 00000000
> [    3.558464] R0  : 00000050 R1  : 00000000 R2  : 00000000 R3  : 0000001f
> [    3.565294] R4  : 00000050 R5  : 8c2ad784 R6  : 8c85fba0 R7  : 00000001
> [    3.572120] R8  : 00000050 R9  : 8c2e97fc R10 : 00000000 R11 : 8c2ad79c
> [    3.578943] R12 : 00000050 R13 : 00000000 R14 : 8cc21ca8
> [    3.584515] MACH: 01f00f65 MACL: 000012c0 GBR : 00000000 PR  : 8c003782
> [    3.591329] 
> [    3.591343] Call trace: 
> [    3.595486] [<8c0080e8>] ret_from_irq+0x0/0x10
> [    3.599975] [<8c003740>] do_IRQ+0x0/0x80
> [    3.604138] [<8c041856>] __setup_irq+0x1f6/0x300
> [    3.608867] [<8c0417aa>] __setup_irq+0x14a/0x300
> [    3.613552] [<8c041ba4>] request_irq+0x84/0xc0

So, this is because you have stumbled across the
GENERIC_HARDIRQS_NO__DO_IRQ hiccup that hp6xx also hit. I've changed the
default behaviour in-tree to leave this disabled for the problematic
platforms. Presently these include the Cayman, Microdev, Dreamcast, and
SystemH 7751.

Having said that, converting dreamcast to irq_chip and dropping it from
the dependencies is certainly the way we want to go. I'll have to look at
Cayman and Microdev one of these days, but as neither have a double-digit
userbase, this is not a pressing priority.

On Sun, Dec 07, 2008 at 09:30:11PM +0000, Adrian McMenamin wrote:
> Working with Matt, can now boot the Dreamcast and the PVR2 and GDRom
> appear to work (certainly get video output from the PVR2). But cannot
> get the network to come up.
> 
> Matt thinks this issue might have been seen elsewhere too - anybody got
> any ideas about fixing it?
> 
> [    6.248295] Sending DHCP requests .....<6>NETDEV WATCHDOG: eth0 (8139too): transmit timed out
> [   41.933824] ------------[ cut here ]------------
> [   41.938367] Badness at net/sched/sch_generic.c:226
> [   41.943388] 
> [   41.944832] Pid : 0, Comm:              swapper
> [   41.949511] CPU : 0    Not tainted  (2.6.28-rc7-13831-gacfbbdd-dirty #967)
> [   41.956714] PC is at dev_watchdog+0x198/0x340
> [   41.961196] PR is at dev_watchdog+0x198/0x340
> [   41.965677] PC  : 8c19f378 SP  : 8c2a7e64 SR  : 40008101 TEA : 00000000
> [   41.972503] R0  : 00000037 R1  : 8c2a6000 R2  : 8c2a6000 R3  : 000000df
> [   41.979330] R4  : 00000001 R5  : 00001755 R6  : ffffffff R7  : 00000035
> [   41.986160] R8  : 00000001 R9  : 8c2af794 R10 : 00000001 R11 : 8c2f5278
> [   41.992981] R12 : 00000001 R13 : 8cc532fc R14 : 8c2a7e64
> [   41.998375] MACH: 0000270c MACL: 000003c0 GBR : 8c000000 PR  : 8c19f378
> [   42.005188] 
> [   42.005202] Call trace: 
> [   42.009355] [<8c0407ca>] get_timestamp+0xa/0x40
> [   42.014023] [<8c00db16>] tmu_timer_read+0x16/0x40
> [   42.018866] [<8c006970>] sched_clock+0x10/0x60
> [   42.023543] [<8c0343f8>] sched_clock_cpu+0x18/0x40

It looks like your ethernet IRQ isn't firing or being handled at all. The
stack trace in question only covers the watchdog timeout relative to the
timer, no IRQ noise from 8139too is visible. So, you probably have
something broken with your irq_chip conversion patch, likely related to
the demux handling.
