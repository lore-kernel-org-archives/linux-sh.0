From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Mar 2014 19:22:04 +0000
Subject: NFS root on Koelsch reference
Message-Id: <CAMuHMdUND0D8rj4K3ZPqx1XqS7czK3PeHfBqTu2WRWQw3Ecj1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now we have DT support for Ethernet on r8a7791, I struggled a bit to get NFS
root working on Koelsch reference.

While I still need "[PATCH] ARM: shmobile: compile drivers/sh for
CONFIG_ARCH_SHMOBILE_MULTI" to make the thermal sensor warning
go away, this same patch causes a kernel panic when starting userspace from
NFS root on Koelsch reference:

VFS: Mounted root (nfs filesystem) readonly on device 0:12.
devtmpfs: mounted
Freeing unused kernel memory: 204K (c042b000 - c045e000)
Unhandled fault: imprecise external abort (0x1406) at 0x00000000
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007

CPU: 1 PID: 1 Comm: bash Not tainted
3.14.0-rc5-koelsch-reference-01179-gee99a8bd6a2f-dirty #115
Backtrace:
[<c00120ac>] (dump_backtrace) from [<c001224c>] (show_stack+0x18/0x1c)
 r6:eec799c0 r5:ee4a6e40 r4:00000000 r3:00000204
[<c0012234>] (show_stack) from [<c032f5f0>] (dump_stack+0x70/0x8c)
[<c032f580>] (dump_stack) from [<c032dafc>] (panic+0x90/0x1ec)
 r4:eec799c0 r3:00000001
[<c032da70>] (panic) from [<c0025d3c>] (do_exit+0x494/0x8bc)
 r3:eec73dc0 r2:00000000 r1:00000007 r0:c03d3cae
 r7:ee4a6e78
[<c00258a8>] (do_exit) from [<c00262f4>] (do_group_exit+0xa4/0xd0)
 r7:eed64040
[<c0026250>] (do_group_exit) from [<c0031854>]
(get_signal_to_deliver+0x4bc/0x520)
 r7:eed64040 r6:eec7bee4 r5:eec7a000 r4:01060013
[<c0031398>] (get_signal_to_deliver) from [<c00115ac>] (do_signal+0xa8/0x3c0)
 r10:00000000 r9:eec7a000 r8:00000000 r7:eec7a000 r6:00000000 r5:00000000
 r4:eec7bfb0

Nothing really interesting in the backtrace.

Without that patch, NFS root works, but it's much more sluggish than under
the Koelsch legacy kernel.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
