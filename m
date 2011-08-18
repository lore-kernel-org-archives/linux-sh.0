From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 18 Aug 2011 08:21:55 +0000
Subject: [OOPS] sh-sci.c: sleeping in atomic context
Message-Id: <Pine.LNX.4.64.1108181015410.3069@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all

Looks like sleeping in serial_console_write() is not a good idea:

BUG: scheduling while atomic: dma1chan0-copy2/780/0x00000002
no locks held by dma1chan0-copy2/780.
Modules linked in: dmatest shdma
Backtrace: 
[<c001249c>] (dump_backtrace+0x0/0x110) from [<c024e0fc>] (dump_stack+0x18/0x1c)
 r6:00000000 r5:00000000 r4:cf7ad0c0 r3:60000013
[<c024e0e4>] (dump_stack+0x0/0x1c) from [<c001e7a8>] (__schedule_bug+0x60/0x6c)
[<c001e748>] (__schedule_bug+0x0/0x6c) from [<c024e7a0>] (schedule+0x5c/0x494)
 r5:cf7ae000 r4:cf7ad0c0
[<c024e744>] (schedule+0x0/0x494) from [<c02502b0>] (mutex_lock_nested+0x1a4/0x2ec)
 r9:c034fa98 r8:cf7ae000 r7:c0336a00 r6:cf7ad0c0 r5:60000013
r4:c03369dc
[<c025010c>] (mutex_lock_nested+0x0/0x2ec) from [<c017d41c>] (pm_genpd_runtime_resume+0x78/0x1fc)
 r8:cf7ae000 r7:cf7ae000 r6:c03369dc r5:c0330650 r4:c0336978
[<c017d3a4>] (pm_genpd_runtime_resume+0x0/0x1fc) from [<c017b304>] (rpm_callback+0x4c/0x6c)
[<c017b2b8>] (rpm_callback+0x0/0x6c) from [<c017c03c>] (rpm_resume+0x300/0x3d4)
 r6:00000000 r5:c034fa08 r4:c0330650 r3:c0336978
[<c017bd3c>] (rpm_resume+0x0/0x3d4) from [<c017c39c>] (__pm_runtime_resume+0x50/0x68)
[<c017c34c>] (__pm_runtime_resume+0x0/0x68) from [<c016d14c>] (sci_port_enable+0x24/0x44)
 r7:60000093 r6:c036545b r5:00000052 r4:c0760ef8
[<c016d128>] (sci_port_enable+0x0/0x44) from [<c016d1d0>] (serial_console_write+0x28/0x80)
 r4:c0760ef8 r3:c0760ef8
[<c016d1a8>] (serial_console_write+0x0/0x80) from [<c00246a0>] (__call_console_drivers+0x90/0xa8)
 r6:0000a52d r5:0000a4db r4:c034f320 r3:c016d1a8
[<c0024610>] (__call_console_drivers+0x0/0xa8) from [<c0024738>] (_call_console_drivers+0x80/0x90)
 r6:00000000 r5:c03437b4 r4:0000a52d r3:0000a4db
[<c00246b8>] (_call_console_drivers+0x0/0x90) from [<c00248a8>] (console_unlock+0x100/0x1cc)
 r5:0000a52d r4:0000a52d
[<c00247a8>] (console_unlock+0x0/0x1cc) from [<c002500c>] (vprintk+0x3b0/0x438)
[<c0024c5c>] (vprintk+0x0/0x438) from [<c024e2c8>] (printk+0x24/0x2c)
[<c024e2a4>] (printk+0x0/0x2c) from [<bf007de0>] (dmatest_func+0xb04/0xbd4 [dmatest])
 r3:00000000 r2:0000000a r1:cf7ad29c r0:bf008477
[<bf0072dc>] (dmatest_func+0x0/0xbd4 [dmatest]) from [<c003e238>] (kthread+0x8c/0x94)
[<c003e1ac>] (kthread+0x0/0x94) from [<c0027830>] (do_exit+0x0/0x630)
 r7:00000013 r6:c0027830 r5:c003e1ac r4:cf403df0

Yes, I was experimenting with runtime PM, based on a bunch of 
not-yet-mainlined patches, but the backtrace seems legitimate. In 
principle looks like any printk to the console, which wakes it up, will 
cause this.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
