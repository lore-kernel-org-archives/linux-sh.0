From: "Nylund, Martin" <Martin.Nylund@emtrion.de>
Date: Tue, 11 Aug 2009 13:24:11 +0000
Subject: AW: kernel oopses on 7780 target with 2.6.25 kernel
Message-Id: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE7@em-srv1-kaha.intern.emtrion.de>
List-Id: <linux-sh.vger.kernel.org>
References: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
In-Reply-To: <37C9A1F7C45F1F498E9CB8295E7B305CBD3FE6@em-srv1-kaha.intern.emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Here is better copy of my test session (PC seems to be always pointing
to copy_page or memcpy):

BusyBox v1.12.4 (2009-08-11 14:02:42 CEST) built-in shell (ash)
Enter 'help' for a list of built-in commands.

~ #
~ #
~ # cat mtest.sh
#!/bin/sh

modprobe sdr

top -d 1 | grep 'CPU:' &

while true; do
    grep -i sdr /proc/interrupts
    uptime
    sleep 1
done
~ # ./mtest.sh
Modulo start
  6:        282      sh7780-irq-level     SDR
 16:47:44 up 0 min, load average: 0.07, 0.01, 0.00
CPU:  30% usr  50% sys   0% nice   0% idle   0% io  20% irq   0% softirq
  258   253 root     S     2572   2%   0% grep CPU:
CPU:  33% usr  66% sys   0% nice   0% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:       3603      sh7780-irq-level     SDR
 16:47:46 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   2% usr   7% sys   0% nice  82% idle   0% io   5% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
CPU:   0% usr   0% sys   0% nice  97% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:       6847      sh7780-irq-level     SDR
 16:47:47 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   0% usr   2% sys   0% nice  94% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      10021      sh7780-irq-level     SDR
 16:47:48 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   0% usr   4% sys   0% nice  90% idle   0% io   2% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      13199      sh7780-irq-level     SDR
 16:47:49 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   2% grep CPU:
  6:      16376      sh7780-irq-level     SDR
Unable to handle kernel paging request at virtual address dfff0b00
pc = 881063c0
*pde = 88350000
Oops: 0000 [#1]
Modules linked in: sdr

Pid : 282, Comm:             mtest.sh
PC is at copy_page+0x10/0x4c
PC  : 881063c0 SP  : 8fdf5e70 SR  : 40008000 TEA : dfff0b00    Not
tainted
R0  : 8f3b3ae0 R1  : 7b80bd54 R2  : 0000020a R3  : 00000002
R4  : 848abcd0 R5  : 848abacc R6  : ff4bb4c4 R7  : 2975c450
R8  : dfff1000 R9  : 8f3b3000 R10 : 8f3b3b00 R11 : dfff0b00
R12 : 88351000 R13 : 7b80b5f4 R14 : 8fdf5e7c
MACH: 00000051 MACL: 00000000 GBR : 2975c450 PR  : 880109d0

Call trace:
[<88054b38>] do_wp_page+0xb8/0x580
[<88056230>] handle_mm_fault+0x290/0x360
[<8800fdca>] do_page_fault+0x8a/0x3e0
[<880080e0>] ret_from_exception+0x0/0xc
[<880080e0>] ret_from_exception+0x0/0xc
[<88013e2a>] schedule_tail+0x4a/0x80
[<88013e2a>] schedule_tail+0x4a/0x80
[<8800fce8>] __do_page_fault+0xc8/0x120
[<880080e0>] ret_from_exception+0x0/0xc
[<880080e0>] ret_from_exception+0x0/0xc

Process: mtest.sh (pid: 282, stack limit = 8fdf4001)
Stack: (0x8fdf5e70 to 0x8fdf6000)
5e60:                                     dfff0000 0f30a000 00000000
88054b38
5e80: 8fdf5e9c 7b80b5f4 00000000 88438660 8fdd66bc 88437140 00000001
8fdc7200
5ea0: 88056230 8fdf5ecc 7b80b5f4 8fde17b8 0000002c 8fdd66bc 8fdc7200
000003ff
5ec0: 8fde17b8 8fdc7240 0f30a15c 00000000 00000001 8fdf5eec 8800fdca
8fdf5ef8
5ee0: 8fdf5fa0 8fdc7234 8fc30080 7b80b5f4 8fdc7200 8fdd66bc 8fca7908
00000001
5f00: 8fdf5f0c 00000000 8fdf5f2c 8fc300fc 880080e0 8fdf5f90 8fca795c
ffffff0f
5f20: 8fca78e0 880080e0 2975c048 00000001 0000011a 882f828c 00000000
000000fc
5f40: 8fc15ce0 882f828c 8fc3028c 2975c04c 2975c048 00000000 8fc3027c
8fca78e0
5f60: ffffff0f 8fca795c 8fdf5f90 8fdf5f90 88013e2a 88013e2a 8800fce8
8fdf5f8c
5f80: 880080e0 7b80b604 00000000 297587b8 000000fd 880080e0 7b80b5f4
00000001
5fa0: 00002740 fffff000 00000000 0000011a 01200011 fffd2b3c 00000000
2975c048
5fc0: 2975c040 7b80b5f8 00000000 000000fd 297587b8 00000000 7b80b604
7b80b5f8
5fe0: 2967dba0 296ab064 00008001 2975c450 00000051 ad6b6374 ffffffff
00000060
---[ end trace 006900a3068ee60e ]---
note: mtest.sh[282] exited with preempt_count 2
BUG: scheduling while atomic: mtest.sh/282/0x10000002
Stack: (0x8fdf5c84 to 0x8fdf6000)
5c80:          88006a0e 8fdf5c94 88246260 00000000 88013d06 8fdf5c9c
8824656e
5ca0: 8fdf5ca8 8fc301d8 88013d60 880581b0 88013d60 8fdf5cd0 00000000
8fca4540
5cc0: 8fca4548 00000000 88246260 10000000 8824687a 8fdf5ce0 00000000
00000407
5ce0: 88019d02 8fdf5ce8 ffffff0f 88019d5a 8fdf5d0c 8fdf5e10 881105e0
882af930
5d00: 0000000b 8fc30080 8fc302fc 8801b2ee 8fdf5d14 8fdf5e10 881105e0
8fc300fc
5d20: 00000001 8fdf5e10 88018540 88006bec 8fdf5d4c 8fdf5e10 881105e0
882af930
5d40: 00000000 8fdf5e10 88018540 8800ffa4 8fdf5d68 88351000 8fc30080
dfff0b00
5d60: 88018540 88350000 c0071080 00000000 40008001 00000000 00000006
00000000
5d80: 20000000 00000000 8fcb1bc0 00000000 00000000 00000006 88351000
7b80b5f4
5da0: 8fdf5dd0 8fdf5dc8 c0071084 88040e50 40008001 2975c450 00000001
00000006
5dc0: ffffffff 00000040 88042c20 8fdf5de8 8fdf5dd4 8800d34c 8fdf5ddc
88042c3a
5de0: 8fdf5de8 882f8900 880037ca 8fdf5df8 880080e0 8fdf5e7c 7b80b5f4
88351000
5e00: dfff0b00 880080e0 dfff0b00 00000000 8f3b3ae0 7b80bd54 0000020a
00000002
5e20: 848abcd0 848abacc ff4bb4c4 2975c450 dfff1000 8f3b3000 8f3b3b00
dfff0b00
5e40: 88351000 7b80b5f4 8fdf5e7c 8fdf5e70 881063c0 880109d0 40008000
2975c450
5e60: 00000051 00000000 ffffffff 00000040 dfff0000 0f30a000 00000000
88054b38
5e80: 8fdf5e9c 7b80b5f4 00000000 88438660 8fdd66bc 88437140 00000001
8fdc7200
5ea0: 88056230 8fdf5ecc 7b80b5f4 8fde17b8 0000002c 8fdd66bc 8fdc7200
000003ff
5ec0: 8fde17b8 8fdc7240 0f30a15c 00000000 00000001 8fdf5eec 8800fdca
8fdf5ef8
5ee0: 8fdf5fa0 8fdc7234 8fc30080 7b80b5f4 8fdc7200 8fdd66bc 8fca7908
00000001
5f00: 8fdf5f0c 00000000 8fdf5f2c 8fc300fc 880080e0 8fdf5f90 8fca795c
ffffff0f
5f20: 8fca78e0 880080e0 2975c048 00000001 0000011a 882f828c 00000000
000000fc
5f40: 8fc15ce0 882f828c 8fc3028c 2975c04c 2975c048 00000000 8fc3027c
8fca78e0
5f60: ffffff0f 8fca795c 8fdf5f90 8fdf5f90 88013e2a 88013e2a 8800fce8
8fdf5f8c
5f80: 880080e0 7b80b604 00000000 297587b8 000000fd 880080e0 7b80b5f4
00000001
5fa0: 00002740 fffff000 00000000 0000011a 01200011 fffd2b3c 00000000
2975c048
5fc0: 2975c040 7b80b5f8 00000000 000000fd 297587b8 00000000 7b80b604
7b80b5f8
5fe0: 2967dba0 296ab064 00008001 2975c450 00000051 ad6b6374 ffffffff
00000060

Call trace:
[<88006a0e>] dump_stack+0xe/0x20
[<88246260>] schedule+0x0/0x480
[<88013d06>] __schedule_bug+0x46/0x80
[<8824656e>] schedule+0x30e/0x480
[<88013d60>] __cond_resched+0x20/0x60
[<880581b0>] exit_mmap+0x90/0x120
[<88013d60>] __cond_resched+0x20/0x60
[<88246260>] schedule+0x0/0x480
[<8824687a>] _cond_resched+0x3a/0x60
[<88019d02>] put_files_struct+0xe2/0x120
[<88019d5a>] __exit_files+0x1a/0x40
[<881105e0>] bust_spinlocks+0x0/0x60
[<8801b2ee>] do_exit+0x10e/0x7e0
[<881105e0>] bust_spinlocks+0x0/0x60
[<88018540>] printk+0x0/0x40
[<88006bec>] die+0x10c/0x180
[<881105e0>] bust_spinlocks+0x0/0x60
[<88018540>] printk+0x0/0x40
[<8800ffa4>] do_page_fault+0x264/0x3e0
[<88018540>] printk+0x0/0x40
[<c0071080>] interrupt_handler+0x0/0x60 [sdr]
[<c0071084>] interrupt_handler+0x4/0x60 [sdr]
[<88040e50>] handle_IRQ_event+0x50/0xa0
[<88042c20>] handle_level_irq+0x60/0xe0
[<8800d34c>] intc_enable+0x4c/0x80
[<88042c3a>] handle_level_irq+0x7a/0xe0
[<880037ca>] do_IRQ+0x4a/0xe0
[<880080e0>] ret_from_exception+0x0/0xc
[<880080e0>] ret_from_exception+0x0/0xc
[<881063c0>] copy_page+0x10/0x4c
[<880109d0>] copy_user_highpage+0xb0/0x120
[<88054b38>] do_wp_page+0xb8/0x580
[<88056230>] handle_mm_fault+0x290/0x360
[<8800fdca>] do_page_fault+0x8a/0x3e0
[<880080e0>] ret_from_exception+0x0/0xc
[<880080e0>] ret_from_exception+0x0/0xc
[<88013e2a>] schedule_tail+0x4a/0x80
[<88013e2a>] schedule_tail+0x4a/0x80
[<8800fce8>] __do_page_fault+0xc8/0x120
[<880080e0>] ret_from_exception+0x0/0xc
[<880080e0>] ret_from_exception+0x0/0xc

Segmentation fault
CPU:   2% usr   3% sys   0% nice  50% idle   0% io  44% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      19878      sh7780-irq-level     SDR
 16:47:51 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      23058      sh7780-irq-level     SDR
 16:47:52 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   0% usr   2% sys   0% nice  93% idle   0% io   2% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      26235      sh7780-irq-level     SDR
 16:47:53 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      29417      sh7780-irq-level     SDR
 16:47:55 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   0% usr   4% sys   0% nice  93% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      32595      sh7780-irq-level     SDR
 16:47:56 up 0 min, load average: 0.06, 0.01, 0.00
CPU:   0% usr   2% sys   0% nice  94% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      35778      sh7780-irq-level     SDR
 16:47:57 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   0% usr   4% sys   0% nice  92% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      38951      sh7780-irq-level     SDR
 16:47:58 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   1% usr   1% sys   0% nice  94% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      42131      sh7780-irq-level     SDR
 16:47:59 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   1% usr   1% sys   0% nice  95% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      45299      sh7780-irq-level     SDR
 16:48:00 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   1% usr   3% sys   0% nice  91% idle   0% io   2% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      48476      sh7780-irq-level     SDR
CPU:   1% usr   0% sys   0% nice  95% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
 16:48:01 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   0% usr   2% sys   0% nice  96% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      51691      sh7780-irq-level     SDR
 16:48:02 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  92% idle   0% io   2% irq   0% softirq
  258   253 root     S     2576   2%   2% grep CPU:
  6:      54869      sh7780-irq-level     SDR
 16:48:03 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      58048      sh7780-irq-level     SDR
 16:48:04 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      61233      sh7780-irq-level     SDR
 16:48:05 up 0 min, load average: 0.05, 0.01, 0.00
CPU:   1% usr   3% sys   0% nice  93% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      64409      sh7780-irq-level     SDR
 16:48:06 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      67590      sh7780-irq-level     SDR
 16:48:07 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   0% usr   3% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      70767      sh7780-irq-level     SDR
 16:48:08 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   0% usr   2% sys   0% nice  93% idle   0% io   2% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      73947      sh7780-irq-level     SDR
 16:48:09 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   1% usr   3% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      77124      sh7780-irq-level     SDR
 16:48:10 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      80302      sh7780-irq-level     SDR
 16:48:11 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   1% usr   1% sys   0% nice  94% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      83480      sh7780-irq-level     SDR
 16:48:12 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   1% usr   3% sys   0% nice  92% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      86662      sh7780-irq-level     SDR
 16:48:13 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   0% usr   2% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      89839      sh7780-irq-level     SDR
 16:48:15 up 0 min, load average: 0.04, 0.01, 0.00
CPU:   0% usr   3% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      93016      sh7780-irq-level     SDR
 16:48:16 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   2% grep CPU:
  6:      96198      sh7780-irq-level     SDR
 16:48:17 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   1% usr   3% sys   0% nice  93% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:      99375      sh7780-irq-level     SDR
 16:48:18 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  93% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:     102555      sh7780-irq-level     SDR
 16:48:19 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   0% usr   3% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:     105733      sh7780-irq-level     SDR
 16:48:20 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  93% idle   0% io   1% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:     108916      sh7780-irq-level     SDR
 16:48:21 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   0% usr   3% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:     112092      sh7780-irq-level     SDR
 16:48:22 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   1% usr   2% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:     115272      sh7780-irq-level     SDR
 16:48:23 up 0 min, load average: 0.03, 0.01, 0.00
CPU:   0% usr   3% sys   0% nice  94% idle   0% io   0% irq   0% softirq
  258   253 root     S     2576   2%   0% grep CPU:
  6:     118451      sh7780-irq-level     SDR
 16:48:24 up 0 min, load average: 0.03, 0.01, 0.00
Unable to handle kernel paging request at virtual address dfff0e6a
pc = 88106854
*pde = 88350000
Oops: 0000 [#2]
Modules linked in: sdr

Pid : 257, Comm:                  top
PC is at memcpy+0x20/0x28c
PC  : 88106854 SP  : 8fdcfeac SR  : 40008100 TEA : dfff0e6a    Tainted:
G      D
R0  : 8f88c00e R1  : 00000010 R2  : 40008101 R3  : 50764e5c
R4  : 8f88c000 R5  : 50764e5c R6  : 00000007 R7  : ff000000
R8  : 086a7000 R9  : 00000000 R10 : dfff0000 R11 : 88351000
R12 : 7b93fe5d R13 : 8f88c000 R14 : 8fdcfeac
MACH: 00000001 MACL: 00000000 GBR : 2975c450 PR  : 88010c60

Call trace:
[<88056832>] access_process_vm+0x132/0x1c0
[<8809fa5c>] proc_pid_cmdline+0x7c/0x120
[<880a18c8>] proc_info_read+0xa8/0x100
[<880667c6>] vfs_read+0x86/0x160
[<88066dde>] sys_read+0x3e/0xa0
[<880081e8>] syscall_call+0xc/0x10
[<88066da0>] sys_read+0x0/0xa0

Process: top (pid: 257, stack limit = 8fdce001)
Stack: (0x8fdcfeac to 0x8fdd0000)
fea0:                            88056832 8fdcfed4 8f88c000 7b93fe6b
8fdcfeb4
fec0: 00000e5d 0000000e 886a7000 886a7e5d 0000000e 00000000 8f88c000
8fd49040
fee0: 8fd333b4 8fd33380 0000000e 8835e4e0 8fd9da58 8809fa5c 8fdcff18
8f88c000
ff00: 00000000 8fd49040 0000000e 8fd333fc 8fd33380 00000000 8fdcff34
880a18c8
ff20: 8fdcff3c 8fdcff78 00000018 fffffff4 8fd49040 8f88c000 8f88966c
0045fe75
ff40: 880667c6 8fdcff60 0000000c fffffff7 8fdcff78 00000018 0045fe75
8fdc5f60
ff60: 88066dde 8fdcff78 00000018 0045fe75 8fdc5f60 8fdcff44 0000000e
00000000
ff80: 00000000 880081e8 00000052 004054c8 00000000 00000021 8fdcfff8
88066da0
ffa0: 00000000 00000450 0000000e 00000003 00000003 0045fe75 00000018
000005b0
ffc0: 00000018 0045fe75 00000003 00461d4c 004054c8 0000000c 00000052
7bfb4aa8
ffe0: 296d1954 004082aa 00000101 2975c450 00000001 9999999a 0000004c
00000160
---[ end trace 006900a3068ee60e ]---
note: top[257] exited with preempt_count 1
BUG: scheduling while atomic: top/257/0x10000001
Stack: (0x8fdcfcc0 to 0x8fdd0000)
fcc0: 88006a0e 8fdcfcd0 88246260 00000000 88013d06 8fdcfcd8 8824656e
8fdcfce4
fce0: 8fc56278 88013d60 88067620 88013d60 8fdcfd0c 00000004 8fca4240
8fca4248
fd00: 00000000 88246260 10000000 8824687a 8fdcfd1c 00000000 00000007
88019d02
fd20: 8fdcfd24 ffffff0f 88019d5a 8fdcfd48 8fdcfe4c 881105e0 882af930
0000000b
fd40: 8fc56120 8fc5639c 8801b2ee 8fdcfd50 8fdcfe4c 881105e0 8fc5619c
00000001
fd60: 8fdcfe4c 88018540 88006bec 8fdcfd88 8fdcfe4c 881105e0 882af930
00000000
fd80: 8fdcfe4c 88018540 8800ffa4 8fdcfda4 7b93fe5d 8fc56120 dfff0e6a
88018540
fda0: 88350000 c0071080 00000000 c0071080 00000000 40008101 00000000
00000006
fdc0: 00000000 20000000 00000000 8fcb1bc0 00000000 00000000 00000006
7b93fe5d
fde0: 8f88c000 8fdcfe0c 8fdcfe0c c0071080 88040e50 00000001 00000006
00000001
fe00: 00000150 88042c20 8fdcfe24 8fdcfe10 8800d34c 8fdcfe18 88042c3a
8fdcfe24
fe20: 882f8900 880037ca 8fdcfe34 880080e0 8fdcfeac 8f88c000 7b93fe5d
88351000
fe40: 880080e0 dfff0e6a 00000000 8f88c00e 00000010 40008101 50764e5c
8f88c000
fe60: 50764e5c 00000007 ff000000 086a7000 00000000 dfff0000 88351000
7b93fe5d
fe80: 8f88c000 8fdcfeac 8fdcfeac 88106854 88010c60 40008100 2975c450
00000001
fea0: 00000000 ffffffff 00000040 88056832 8fdcfed4 8f88c000 7b93fe6b
8fdcfeb4
fec0: 00000e5d 0000000e 886a7000 886a7e5d 0000000e 00000000 8f88c000
8fd49040
fee0: 8fd333b4 8fd33380 0000000e 8835e4e0 8fd9da58 8809fa5c 8fdcff18
8f88c000
ff00: 00000000 8fd49040 0000000e 8fd333fc 8fd33380 00000000 8fdcff34
880a18c8
ff20: 8fdcff3c 8fdcff78 00000018 fffffff4 8fd49040 8f88c000 8f88966c
0045fe75
ff40: 880667c6 8fdcff60 0000000c fffffff7 8fdcff78 00000018 0045fe75
8fdc5f60
ff60: 88066dde 8fdcff78 00000018 0045fe75 8fdc5f60 8fdcff44 0000000e
00000000
ff80: 00000000 880081e8 00000052 004054c8 00000000 00000021 8fdcfff8
88066da0
ffa0: 00000000 00000450 0000000e 00000003 00000003 0045fe75 00000018
000005b0
ffc0: 00000018 0045fe75 00000003 00461d4c 004054c8 0000000c 00000052
7bfb4aa8
ffe0: 296d1954 004082aa 00000101 2975c450 00000001 9999999a 0000004c
00000160

Call trace:
[<88006a0e>] dump_stack+0xe/0x20
[<88246260>] schedule+0x0/0x480
[<88013d06>] __schedule_bug+0x46/0x80
[<8824656e>] schedule+0x30e/0x480
[<88013d60>] __cond_resched+0x20/0x60
[<88067620>] fput+0x20/0x40
[<88013d60>] __cond_resched+0x20/0x60
[<88246260>] schedule+0x0/0x480
[<8824687a>] _cond_resched+0x3a/0x60
[<88019d02>] put_files_struct+0xe2/0x120
[<88019d5a>] __exit_files+0x1a/0x40
[<881105e0>] bust_spinlocks+0x0/0x60
[<8801b2ee>] do_exit+0x10e/0x7e0
[<881105e0>] bust_spinlocks+0x0/0x60
[<88018540>] printk+0x0/0x40
[<88006bec>] die+0x10c/0x180
[<881105e0>] bust_spinlocks+0x0/0x60
[<88018540>] printk+0x0/0x40
[<8800ffa4>] do_page_fault+0x264/0x3e0
[<88018540>] printk+0x0/0x40
[<c0071080>] interrupt_handler+0x0/0x60 [sdr]
[<c0071080>] interrupt_handler+0x0/0x60 [sdr]
[<c0071080>] interrupt_handler+0x0/0x60 [sdr]
[<88040e50>] handle_IRQ_event+0x50/0xa0
[<88042c20>] handle_level_irq+0x60/0xe0
[<8800d34c>] intc_enable+0x4c/0x80
[<88042c3a>] handle_level_irq+0x7a/0xe0
[<880037ca>] do_IRQ+0x4a/0xe0
[<880080e0>] ret_from_exception+0x0/0xc
[<880080e0>] ret_from_exception+0x0/0xc
[<88106854>] memcpy+0x20/0x28c
[<88010c60>] copy_from_user_page+0xa0/0x120
[<88056832>] access_process_vm+0x132/0x1c0
[<8809fa5c>] proc_pid_cmdline+0x7c/0x120
[<880a18c8>] proc_info_read+0xa8/0x100
[<880667c6>] vfs_read+0x86/0x160
[<88066dde>] sys_read+0x3e/0xa0
[<880081e8>] syscall_call+0xc/0x10
[<88066da0>] sys_read+0x0/0xa0

  6:     120472      sh7780-irq-level     SDR
 16:48:25 up 0 min, load average: 0.03, 0.01, 0.00
  6:     123653      sh7780-irq-level     SDR
 16:48:26 up 0 min, load average: 0.03, 0.01, 0.00
  6:     126831      sh7780-irq-level     SDR
 16:48:27 up 0 min, load average: 0.03, 0.01, 0.00
  6:     130010      sh7780-irq-level     SDR
 16:48:28 up 0 min, load average: 0.03, 0.01, 0.00
