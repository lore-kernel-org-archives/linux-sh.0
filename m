From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 14 Mar 2014 13:02:59 +0000
Subject: Re: [PATCH] [RFC] ARM: shmobile: koelsch-reference: Work around core clock issues
Message-Id: <CAMuHMdV+BDB-R9EckfK2e4=hPFb1g2BX9KOGuW2q5VckFa_4sQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1394720970-4749-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Mar 14, 2014 at 1:43 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> > >> This should do the job, but as you mentioned, it's a crude hack. As we're
> > >> targeting v3.16, is there a chance we could fix the problem properly
> > >> instead ?
> >
> > Of course the goal is to fix it for real, so the crude hack will no longer
> > be needed. But for now, it looks like a good short-term workaround.
> >
> > > The best fix would be to re-enable the PM and find out what is
> >
> > Sure, but in a multiplatform-aware way.
>
> Of course. Are you working on that, or should I give it a try ? Would you like
> to discuss this ?

Yes, I plan to work on this. But all input is welcome, of course.

>> > actually causing the external abort. However currently there is
>> > no information in the manuals about anything we could find out from
>> > the AXI busses as to what the source actually is.
>>
>> I re-applied your patch "ARM: shmobile: compile drivers/sh for
>> CONFIG_ARCH_SHMOBILE_MULTI", and surprisingly, I no longer get the external
>> abort.
>>
>> Some experimenting revealed it's due to the "ether" clock in the
>> clk_enables[] array. As long as that's enabled early, the system seems to
>> boot fine with your patch.
>
> At what point do you get the external abort without the ether clock workaround
> ?

When userspace starts:

Freeing unused kernel memory: 204K (c042b000 - c045e000)
Unhandled fault: imprecise external abort (0x1406) at 0x00000000
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000007

CPU: 1 PID: 1 Comm: init Not tainted
3.14.0-rc6-koelsch-reference-00362-gf29bb90d4995-dirty #164
Backtrace:
[<c00120f4>] (dump_backtrace) from [<c0012294>] (show_stack+0x18/0x1c)
 r6:eec799c0 r5:ee49ce40 r4:00000000 r3:00000204
[<c001227c>] (show_stack) from [<c032e46c>] (dump_stack+0x70/0x8c)
[<c032e3fc>] (dump_stack) from [<c032c978>] (panic+0x90/0x1ec)
 r4:eec799c0 r3:00000001
[<c032c8ec>] (panic) from [<c0025d3c>] (do_exit+0x494/0x8bc)
 r3:eec73dc0 r2:00000000 r1:00000007 r0:c03d33ac
 r7:ee49ce78
[<c00258a8>] (do_exit) from [<c00262f4>] (do_group_exit+0xa4/0xd0)
 r7:ee431040
[<c0026250>] (do_group_exit) from [<c0031854>]
(get_signal_to_deliver+0x4bc/0x520)
 r7:ee431040 r6:eec7bee4 r5:eec7a000 r4:01060013
[<c0031398>] (get_signal_to_deliver) from [<c00115f4>] (do_signal+0xa8/0x3c0)
 r10:00000000 r9:eec7a000 r8:00000000 r7:eec7a000 r6:00000000 r5:00000000
 r4:eec7bfb0
[<c001154c>] (do_signal) from [<c0011c1c>] (do_work_pending+0x54/0x9c)
 r10:00000000 r8:00000000 r7:00000000 r6:00000000 r5:eec7a000 r4:eec7bfb0
[<c0011bc8>] (do_work_pending) from [<c000ed40>] (work_pending+0xc/0x20)
 r6:ffffffff r5:00000030 r4:b6ef0bc0 r3:eec799c0
CPU0: stopping
CPU: 0 PID: 0 Comm: swapper/0 Not tainted
3.14.0-rc6-koelsch-reference-00362-gf29bb90d4995-dirty #164
Backtrace:
[<c00120f4>] (dump_backtrace) from [<c0012294>] (show_stack+0x18/0x1c)
 r6:c0468844 r5:00000000 r4:00000000 r3:00200000
[<c001227c>] (show_stack) from [<c032e46c>] (dump_stack+0x70/0x8c)
[<c032e3fc>] (dump_stack) from [<c0013fe4>] (handle_IPI+0xcc/0x164)
 r4:c0484b98 r3:c046eae0
[<c0013f18>] (handle_IPI) from [<c0009314>] (gic_handle_irq+0x58/0x60)
 r5:c0461f18 r4:f0002000
[<c00092bc>] (gic_handle_irq) from [<c0012e00>] (__irq_svc+0x40/0x50)
Exception stack(0xc0461f18 to 0xc0461f60)
1f00:                                                       ef1ed698 00000000
1f20: 006e076b 00000000 c045d698 2ed90000 60000113 ef1ed698 c0468380 413fc0f2
1f40: ef7fccc0 c0461f8c c0461f60 c0461f60 c0067e14 c0067e18 60000113 ffffffff
 r6:ffffffff r5:60000113 r4:c0067e18 r3:c0067e14
[<c0067d68>] (rcu_idle_exit) from [<c005f660>] (cpu_startup_entry+0xe4/0x118)
 r8:c0468380 r7:c03357f4 r6:c0468454 r5:c0484780 r4:c0460000
[<c005f57c>] (cpu_startup_entry) from [<c032b228>] (rest_init+0x68/0x80)
 r7:c0454d90 r3:00000000
[<c032b1c0>] (rest_init) from [<c042bb04>] (start_kernel+0x2fc/0x358)
[<c042b808>] (start_kernel) from [<40008074>] (0x40008074)

Difference in clk_summary output between working and failed case just before
"Freeing unused kernel memory" is:

-             ether                        2            2    65000000          0
+             ether                        1            1    65000000          0

so at that point the clock is still enabled.

You once mentioned that if you try to access a module's registers while its
MSTP clock is not running you may get an exception (on some SoCs).
Is this such an exception?

Note that I never got exceptions when accessing QSPI or MSIOF on r8a7791
with the respective MSTP clocks disabled. I also didn't get one when Ethernet
stopped working after the is_enabled() MSTP fix. That was before NFS root
was mounted, though.

Running actual executables after mounting is different. Demand paging is
involved there. Perhaps there's a bug somewhere in nfs root mmap() or in
the Ethernet driver, not propagating the errors due to the lost Ethernet clock,
so /sbin/init starts running an uninitalized page?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
