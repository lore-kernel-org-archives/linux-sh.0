From: "Nylund, Martin" <Martin.Nylund@emtrion.de>
Date: Tue, 11 Aug 2009 13:00:47 +0000
Subject: kernel oopses on 7780 target with 2.6.25 kernel
Message-Id: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello All,

I have a SH7780 target with kernel 2.6.25. I get some strange memory
management related kernel OOPSes when running a simple kernel module
which just acknowledges a interrupt source. Here's my module:

-------------------------------------------------
#include <linux/module.h>
#include <linux/init.h>
#include <linux/fs.h>
#include <linux/ioport.h>
#include <linux/interrupt.h>
#include <asm/io.h>
#include <asm/dma.h>
#include <asm/irq.h>
#include <asm/signal.h>
#include <asm/hico7780.h>

MODULE_LICENSE("GPL");

static irqreturn_t interrupt_handler(int irq, void *dev_id)
{
	ctrl_outl(ctrl_inl(0xFFD00024)&~(1<<29), 0xFFD00024);
	return IRQ_HANDLED;
}


static int __init init_mod(void)
{
	
	set_irq_type(CAN0_IRQ,IRQ_TYPE_EDGE_FALLING); 

	if(request_irq(CAN0_IRQ, interrupt_handler, 0, "SDR", NULL)!=0)
{
		printk(KERN_WARNING "%s request_irq failed\n",__func__);
		return -EIO;
	}
	return 0;
}


static void __exit end_mod(void){
	free_irq(CAN0_IRQ, NULL);
}

module_init(init_mod);
module_exit(end_mod);
-------------------------------------------------

I insert the module and start some user space action with following
script:

-------------------------------------------------
#!/bin/sh

modprobe sdr

top -d 1 | grep CPU &

while true; do
    uptime
    sleep 1
done
-------------------------------------------------

...after a while I get following oops messages
------------------------------------------------------
.
.
.
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
  261   256 root     S     2576   2%   0% grep CPU
 16:15:49 up 2 min, load average: 0.08, 0.02, 0.00
CPU:   0% usr   1% sys   0% nice  95% idle   0% io   1% irq   0% softirq
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
  261   256 root     S     2576   2%   0% grep CPU
 16:15:50 up 2 min, load average: 0.08, 0.02, 0.00
CPU:   0% usr   1% sys   0% nice  93% idle   0% io   2% irq   0% softirq
  PID  PPID USER     STAT   VSZ %MEM %CPU COMMAND
  261   256 root     S     2576   2%   0% grep CPU
Unable to handle kernel paging request at virtual address dffef000
pc = 881063c0
*pde = 88350000
Oops: 0000 [#1]
Modules linked in: sdr

Pid : 474, Comm:               uptime
PC is at copy_page+0x10/0x4c
PC  : 881063c0 SP  : 8fd9be48 SR  : 40008001 TEA : dffef000    Not
tainted
R0  : 00001000 R1  : 881063b0 R2  : 40008001 R3  : dffef054
R4  : 8f38e000 R5  : dffef000 R6  : 00000000 R7  : ff000000
R8  : dfff0000 R9  : 8f38e000 R10 : 8f38e000 R11 : dffef000
R12 : 88351000 R13 : 2960e094 R14 : 8fd9be54
MACH: 0000002c MACL: 00000000 GBR : 2975c450 PR  : 880109d0

Call trace:
[<8805472a>] __do_fault+0x26a/0x4c0
[<88058056>] unmap_region+0xb6/0x100
[<8805603e>] handle_mm_fault+0x9e/0x360
[<8800fdca>] do_page_fault+0x8a/0x3e0
[<88059eae>] do_mmap_pgoff+0x20e/0x320
[<88247fec>] __down_write+0xc/0x20
[<880326aa>] up_write+0xa/0x20
[<880063d2>] old_mmap+0x72/0xe0
[<880080e0>] ret_from_exception+0x0/0xc
[<880080e0>] ret_from_exception+0x0/0xc

Process: uptime (pid: 474, stack limit = 8fd9a001)
Stack: (0x8fd9be48 to 0x8fd9c000)
be40:                   dffef000 0848c000 00000000 8805472a 8fd9be74
2960e094
be60: 8fd9be8c 00000001 8fdd080c 884381c0 00000001 8fdd084c 8fdd6294
8fdcda60
be80: 88058056 8fd9bea0 2960d000 00000001 0000007a 2960e000 8835a180
00000200
bea0: 8805603e 8fd9becc 2960e094 8fdd6294 00000838 8fdd080c 8fdcda60
000003ff
bec0: 0000007a 00000001 00000000 8fdd080c 00000001 8fd9beec 8800fdca
8fd9bef8
bee0: 8fd9bfa0 8fdcda94 8fc56820 2960e094 8fdcda60 8fdd080c 8fd9befc
00000001
bf00: 8fdd084c 00000012 8fdb8520 00000000 8f808150 8fd6077c 8fd60784
8fdd0860
bf20: 88059eae 8fd9bf4c 8fdb8520 00000002 00002000 00002000 00000003
00000073
bf40: 08100073 00000079 00000001 88247fec 8fdcdaa0 880326aa 8fd9bf74
00002000
bf60: 2960d000 8fdb8520 00000012 2960d000 00000079 880063d2 8fd9bf7c
00000003
bf80: 880080e0 7babf450 29574000 29583004 2960e094 880080e0 2960e094
00000001
bfa0: 0000000c 00010d26 00000003 0000005a 2960e094 00000000 00000008
2960e094
bfc0: 2960e09c 7babf3a4 2960e09c 2960e094 29583004 29574000 7babf450
7babf38c
bfe0: 2956de68 2955d0fa 00008000 2975c450 0000002c 00000030 ffffffff
00000060
---[ end trace ccfba5b32180435e ]---
note: uptime[474] exited with preempt_count 2
Segmentation fault
---------------------------------------------------------

If I compile above module statically to the kernel the system runs
stable.

Do you have any idea what might cause this or how/where I could start to
debug this? Any help is appreciated.

Regards,
Martin
