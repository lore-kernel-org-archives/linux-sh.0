From: "Kristoffer Ericson" <kristoffer.ericson@gmail.com>
Date: Fri, 21 Nov 2008 10:08:44 +0000
Subject: Re: HP Jornada 600-series bisected
Message-Id: <3ec861a70811210208w75ced9kc1482793bd463e22@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
In-Reply-To: <20081120011600.9d3bf5cb.kristoffer.ericson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Appreciate it.

As I said the other bug (the complete cold reboot) was my hd64461-mfd
driver's fault. I've fixed it now, seemed to be caused by
hd64461 io functions being used without the base adress being
initialized (doh!).

So far the hd64461-mfd handles the IRQ's and io functions, I'm working
on integrating the framebuffer. So the driver is progressing
although alot slower than I expect (mfd's are alot more complex than
I first realized).

Best wishes
Kristoffer

2008/11/21, Paul Mundt <lethal@linux-sh.org>:
> On Thu, Nov 20, 2008 at 01:16:00AM +0100, Kristoffer Ericson wrote:
>> HD64461 configured at 0xb0000000 on irq 36(mapped into 64 to 79)
>> HD64461: enabling PCMCIA devices
> [snip]
>> scsi0 : pata_platform
>> ata1: PATA max PIO0 mmio cmd 0x150001f0 ctl 0x150001fe irq 77
>> Unable to handle kernel NULL pointer dereference at virtual address
>> 00000000
>> pc = 00000000
>> *pde = 00000000
>> Oops: 0000 [#1]
>> Modules linked in:
>>
>> Pid : 0, Comm:              swapper
>> PC is at 0x0
>> PC  : 00000000 SP  : 8d291f54 SR  : 400001f1 TEA : 00000000    Not tainted
>> R0  : 0000004d R1  : 00000000 R2  : 8d2c1a98 R3  : 0000000f
>> R4  : 0000004d R5  : 8d29970c R6  : 00000019 R7  : ffffffff
>> R8  : 8d2cec0c R9  : 00000000 R10 : 00000034 R11 : 8d2c009c
>> R12 : 8d21bb80 R13 : 8d2c005c R14 : 8d013cc0
>> MACH: 000071c6 MACL: 000010d8 GBR : 8c009800 PR  : 8d0036c4
>>
>> Call trace:
>> [<8d0070e8>] ret_from_irq+0x0/0x10
>> [<8d066130>] quicklist_trim+0x0/0x120
>> [<8d003690>] do_IRQ+0x0/0x60
>> [<8d003730>] default_idle+0x0/0xd0
>> [<8d066130>] quicklist_trim+0x0/0x120
>> [<8d21bb80>] __sched_text_start+0x0/0x4b0
>> [<8d013cc0>] printk+0x0/0x20
>> [<8d003782>] default_idle+0x52/0xd0
>> [<8d003854>] cpu_idle+0x54/0xb0
>> [<8d2a994e>] start_kernel+0x4ee/0x560
>> [<8d2ae4f0>] __alloc_bootmem+0x0/0x10
>> [<8d0e7810>] strlen+0x0/0x60
>> [<8d002024>] _stext+0x24/0x30
>
> On Thu, Nov 20, 2008 at 06:04:48PM +0100, Kristoffer Ericson wrote:
>> 5093c9a4e41518425d42c0bb5bb92f514ec77b1d is first bad commit
>> commit 5093c9a4e41518425d42c0bb5bb92f514ec77b1d
>> Author: Paul Mundt <lethal@linux-sh.org>
>> Date:   Mon Aug 4 14:17:13 2008 +0900
>>
>>     sh: define GENERIC_HARDIRQS_NO__DO_IRQ.
>>
>>     We haven't called in to __do_IRQ() in a long time, so it seems like a
>>     reasonable time to switch this on by default.
>>
>>     Signed-off-by: Paul Mundt <lethal@linux-sh.org>
>>
>> :040000 040000 cf3a9f428a81b93dcdc7d8da101ef722b6e0159e
>> 563fcba3d9482fd80e8f4f9b02178eb17567bbb7 M  arch
>>
>> Paul, thoughts about this?
>>
> The only relevant change here is the dispatch in include/linux/irq.h.
> With this patch reverted, the call goes through __do_IRQ() if there is no
> desc->handle_irq(). Given that the hd64461 code maps the vector that
> blows up, the implication is that the hd64461 interrupt code is broken.
> Indeed, looking at the code, I suspect it is the demux that is where the
> problem comes from, given that the hd64461 irq code does its own special
> thing and completely bypasses the generic hardirq layer for chained
> handlers.
>
> So, pending a rewrite of hd64461, we should probably just leave the
> __do_IRQ() dispatch as an option there, until someone gets around to
> rewriting that mess. I will conditionalize it on !HD64461 for now.
>
