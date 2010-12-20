From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Dec 2010 08:18:26 +0000
Subject: about ap4evb HDMI video
Message-Id: <w3pbp4g6enp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Guennadi, Magnus, Paul

Now I'm using paul/rmobile-latest tree,
and HDMI video doens't work on mach-ap4evb board.

It print below when boot.
Why is this happen ?

---------------
...
msgmni has been set to 500
io scheduler noop registered (default)
sh-mobile-hdmi sh-mobile-hdmi: Detected HDMI controller 0x0:0x0
sh-mobile-hdmi sh-mobile-hdmi: clocks managed by runtime pm
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: clocks managed by runtime pm
------------[ cut here ]------------
WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/mm/page_alloc.c:1985 )
Modules linked in:
[<c002a220>] (unwind_backtrace+0x0/0xe4) from [<c0033b80>] (warn_slowpath_commo)
[<c0033b80>] (warn_slowpath_common+0x4c/0x64) from [<c0033bb0>] (warn_slowpath_)
[<c0033bb0>] (warn_slowpath_null+0x18/0x1c) from [<c0063808>] (__alloc_pages_no)
[<c0063808>] (__alloc_pages_nodemask+0x144/0x528) from [<c002ac90>] (__dma_allo)
[<c002ac90>] (__dma_alloc+0x90/0x2a4) from [<c002af1c>] (dma_alloc_coherent+0x5)
[<c002af1c>] (dma_alloc_coherent+0x54/0x60) from [<c026616c>] (sh_mobile_lcdc_p)
[<c026616c>] (sh_mobile_lcdc_probe+0x5ac/0x820) from [<c017e8fc>] (platform_drv)
[<c017e8fc>] (platform_drv_probe+0x14/0x18) from [<c017dab8>] (driver_probe_dev)
[<c017dab8>] (driver_probe_device+0xc8/0x184) from [<c017dbd4>] (__driver_attac)
[<c017dbd4>] (__driver_attach+0x60/0x84) from [<c017d324>] (bus_for_each_dev+0x)
[<c017d324>] (bus_for_each_dev+0x48/0x74) from [<c017cc90>] (bus_add_driver+0x9)
[<c017cc90>] (bus_add_driver+0x9c/0x20c) from [<c017dec4>] (driver_register+0xa)
[<c017dec4>] (driver_register+0xa8/0x138) from [<c00253ac>] (do_one_initcall+0x)
[<c00253ac>] (do_one_initcall+0xcc/0x1a0) from [<c00083c4>] (kernel_init+0x94/0)
[<c00083c4>] (kernel_init+0x94/0x14c) from [<c0026830>] (kernel_thread_exit+0x0)
---[ end trace dec6997083161631 ]---
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: unable to allocate buffer
sh_mobile_lcdc_fb: probe of sh_mobile_lcdc_fb.1 failed with error -12
sh_mobile_lcdc_fb sh_mobile_lcdc_fb.0: clocks managed by runtime pm
Console: switching to colour frame buffer device 100x30
graphics fb0: registered sh_mobile_lcdc_fb/mainlcd as 800x480 16bpp.
...
---------------

Best regards
--
Kuninori Morimoto
 
