From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Mar 2014 13:43:36 +0000
Subject: Re: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <CAMuHMdWKA36H7D3V1xbrKdH6=t049u08Y0=VK4+7WgexBWd1Sg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 17, 2014 at 2:38 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> [<c01f92c4>] (__pm_runtime_idle) from [<c023ee90>]
> (sh_eth_get_stats+0x228/0x23c)
>  r7:ee471000 r6:c0356bd4 r5:ee428000 r4:ee428000
> [<c023ec68>] (sh_eth_get_stats) from [<c028c194>] (dev_get_stats+0x5c/0x84)
>  r4:eec7bc30 r3:c023ec68
> [<c028c138>] (dev_get_stats) from [<c029cb08>] (rtnl_fill_ifinfo+0x410/0x8dc)
>  r6:00000000 r5:ee428000 r4:eed76ec0 r3:00000684
> [<c029c6f8>] (rtnl_fill_ifinfo) from [<c029d9f4>] (rtmsg_ifinfo+0x6c/0xd4)
>  r10:00000010 r9:ee428510 r8:ffffffff r7:eed76ec0 r6:ee428000 r5:000000d0
>  r4:00000000
> [<c029d988>] (rtmsg_ifinfo) from [<c0291cd0>] (register_netdevice+0x3dc/0x428)
>  r10:00000000 r8:eed42810 r7:ee428010 r6:ee428000 r5:c047f600 r4:00000000
> [<c02918f4>] (register_netdevice) from [<c0291d38>] (register_netdev+0x1c/0x2c)
>  r7:eed42800 r6:ef203978 r5:ee46e790 r4:ee428000
> [<c0291d1c>] (register_netdev) from [<c0240528>] (sh_eth_drv_probe+0x994/0xb7c)
>  r4:ee428000 r3:00000040
> [<c023fb94>] (sh_eth_drv_probe) from [<c01f3e6c>] (platform_drv_probe+0x20/0x50)
>  r10:c042b548 r9:c045c544 r8:00000065 r7:c047d830 r6:00000000 r5:c047d830
>  r4:eed42810

sh_eth_get_stats() calls

    pm_runtime_get_sync(&mdp->pdev->dev);
    ...
    pm_runtime_put_sync(&mdp->pdev->dev);

so adding the extra pm_runtime_get_sync() in ->probe() prevents the
pm_runtime_put_sync() from putting the hardware to sleep.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
