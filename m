From: Arnd Hannemann <arnd@arndnet.de>
Date: Wed, 21 Jul 2010 07:25:54 +0000
Subject: [bisected] sh_cmt Division by zero in kernel.
Message-Id: <4C46A102.6000805@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

when booting recent genesis-2.6 head on an AP4EVB board a division by zero
in kernel is reported:
(Looks identical to: http://thread.gmane.org/gmane.linux.ports.sh.devel/8497)


[    0.000000]  sh_cmt.10: using deprecated clock lookup
[    0.000000]  sh_cmt.10: used for clock events
[    0.000000]  sh_cmt.10: used for periodic clock events
[    0.000000] Division by zero in kernel.
[    0.000000] Backtrace:
[    0.000000] [<c0028f08>] (dump_backtrace+0x0/0x110) from [<c0202ecc>] (dump_stack+0x18/0x1c)
[    0.000000]  r6:c0298978 r5:cf80e600 r4:cf801460 r3:c02a37ac
[    0.000000] [<c0202eb4>] (dump_stack+0x0/0x1c) from [<c002904c>] (__div0+0x18/0x20)
[    0.000000] [<c0029034>] (__div0+0x0/0x20) from [<c01177fc> ](Ldiv0+0x8/0x10)
[    0.000000] [<c0202444>] (sh_cmt_probe+0x0/0x4e4) from [<c0016f40> ](early_platform_driver_probe+0x1c8/0x264)
[    0.000000] [<c0016d78>] (early_platform_driver_probe+0x0/0x264) from[<c000cbb8>] (shmobile_late_time_init+0x24/0x2c)
[    0.000000] [<c000cb94>] (shmobile_late_time_init+0x0/0x2c) from[<c0008978>] (start_kernel+0x208/0x2a8)
[    0.000000] [<c0008770>] (start_kernel+0x0/0x2a8) from [<40008034>](0x40008034)
[    0.000000]  r5:c02bd1f0 r4:10c53c7d
[    0.000000]  sh_cmt.10: used as clock source

and as a result time is running too fast.
For example sleep 60 on bash returns after a few seconds.

Git bisect identified following commit as bad:

commit f4d7c3565c1692c54d9152b52090fe73f0029e37
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Wed Jun 2 17:10:44 2010 +0900

    clocksource: sh_cmt: compute mult and shift before registration
       Based on the sh_tmu change in 66f49121ffa41a19c59965b31b046d8368fec3c7
    ("clocksource: sh_tmu: compute mult and shift before registration").
    The same issues impact the sh_cmt driver, so we take the same approach
    here.
       Cc: stable@kernel.org
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

Best regards,
Arnd

