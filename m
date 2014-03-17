From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2014 13:38:27 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <CAMuHMdWkZNTypstb4oYvSs8U8oE-OLw+2HCCY7a9wWcdNHpDBQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 17, 2014 at 2:36 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> I have yet to ascertain how this ends up happening with device probe,
> it seems to be very dependant on the code.

Adding a WARN() in cpg_mstp_clock_endisable():

[<c0278c9c>] (cpg_mstp_clock_endisable) from [<c0278e10>]
(cpg_mstp_clock_disable+0x14/0
x18)
 r10:eec7a000 r9:00000003 r8:eed41508 r7:00000001 r6:a0000113 r5:eec23a00
 r4:eec23a00
[<c0278dfc>] (cpg_mstp_clock_disable) from [<c0275bf4>]
(__clk_disable+0x68/0x78)
[<c0275b8c>] (__clk_disable) from [<c0275cf4>] (clk_disable+0x20/0x2c)
 r4:60000193 r3:00000002
[<c0275cd4>] (clk_disable) from [<c01fd000>] (pm_clk_suspend+0x54/0x78)
 r5:eed41500 r4:eed414c0
[<c01fcfac>] (pm_clk_suspend) from [<c01f87f8>] (__rpm_callback+0x4c/0x7c)
 r8:0000000c r7:00000004 r6:00000000 r5:eed42810 r4:eed42810 r3:c01fcfac
[<c01f87ac>] (__rpm_callback) from [<c01f8878>] (rpm_callback+0x50/0x84)
 r5:eed42810 r4:eec7a000
[<c01f8828>] (rpm_callback) from [<c01f8e54>] (rpm_suspend+0x214/0x3e4)
 r6:00000000 r5:00000000 r4:eed42810 r3:eed42810
[<c01f8c40>] (rpm_suspend) from [<c01f9224>] (rpm_idle+0x184/0x19c)
 r10:00000010 r9:00000000 r8:ee4710bc r7:00000004 r6:00000004 r5:00000000
 r4:eed42810
[<c01f90a0>] (rpm_idle) from [<c01f9328>] (__pm_runtime_idle+0x64/0x7c)
 r6:60000113 r5:eed42870 r4:eed42810 r3:eed42870
[<c01f92c4>] (__pm_runtime_idle) from [<c023ee90>]
(sh_eth_get_stats+0x228/0x23c)
 r7:ee471000 r6:c0356bd4 r5:ee428000 r4:ee428000
[<c023ec68>] (sh_eth_get_stats) from [<c028c194>] (dev_get_stats+0x5c/0x84)
 r4:eec7bc30 r3:c023ec68
[<c028c138>] (dev_get_stats) from [<c029cb08>] (rtnl_fill_ifinfo+0x410/0x8dc)
 r6:00000000 r5:ee428000 r4:eed76ec0 r3:00000684
[<c029c6f8>] (rtnl_fill_ifinfo) from [<c029d9f4>] (rtmsg_ifinfo+0x6c/0xd4)
 r10:00000010 r9:ee428510 r8:ffffffff r7:eed76ec0 r6:ee428000 r5:000000d0
 r4:00000000
[<c029d988>] (rtmsg_ifinfo) from [<c0291cd0>] (register_netdevice+0x3dc/0x428)
 r10:00000000 r8:eed42810 r7:ee428010 r6:ee428000 r5:c047f600 r4:00000000
[<c02918f4>] (register_netdevice) from [<c0291d38>] (register_netdev+0x1c/0x2c)
 r7:eed42800 r6:ef203978 r5:ee46e790 r4:ee428000
[<c0291d1c>] (register_netdev) from [<c0240528>] (sh_eth_drv_probe+0x994/0xb7c)
 r4:ee428000 r3:00000040
[<c023fb94>] (sh_eth_drv_probe) from [<c01f3e6c>] (platform_drv_probe+0x20/0x50)
 r10:c042b548 r9:c045c544 r8:00000065 r7:c047d830 r6:00000000 r5:c047d830
 r4:eed42810
[<c01f3e4c>] (platform_drv_probe) from [<c01f2428>]
(driver_probe_device+0xc8/0x1f8)
 r5:eed42844 r4:eed42810
[<c01f2360>] (driver_probe_device) from [<c01f25c0>] (__driver_attach+0x68/0x8c)
 r7:00000000 r6:c047d830 r5:eed42844 r4:eed42810
[<c01f2558>] (__driver_attach) from [<c01f0cd4>] (bus_for_each_dev+0x5c/0x94)
 r6:c01f2558 r5:eec7be48 r4:c047d830 r3:c01f2558
[<c01f0c78>] (bus_for_each_dev) from [<c01f1f84>] (driver_attach+0x20/0x28)
 r7:00000000 r6:c047a148 r5:ee461480 r4:c047d830
[<c01f1f64>] (driver_attach) from [<c01f1b98>] (bus_add_driver+0xb4/0x1c8)
[<c01f1ae4>] (bus_add_driver) from [<c01f2c98>] (driver_register+0xa4/0xe8)
 r7:c0484780 r6:00000000 r5:c0454c18 r4:c047d830
[<c01f2bf4>] (driver_register) from [<c01f3854>]
(__platform_driver_register+0x50/0x64)
 r5:c0454c18 r4:c0442acc
[<c01f3804>] (__platform_driver_register) from [<c0442ae4>]
(sh_eth_driver_init+0x18/0x20)
[<c0442acc>] (sh_eth_driver_init) from [<c0009668>] (do_one_initcall+0x98/0x13c)
[<c00095d0>] (do_one_initcall) from [<c042bc60>]
(kernel_init_freeable+0x100/0x1cc)
 r9:c045c544 r8:00000065 r7:c0484780 r6:c0454bf8 r5:c0454c18 r4:00000006
[<c042bb60>] (kernel_init_freeable) from [<c032afa8>] (kernel_init+0x10/0xec)
 r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c032af98
 r4:00000000
[<c032af98>] (kernel_init) from [<c000ed98>] (ret_from_fork+0x14/0x3c)
 r4:00000000 r3:00000000


-- 
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
