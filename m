From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 May 2015 02:17:26 +0000
Subject: Re: [PATCH 2/5] ASoC: rsnd: make sure it uses lock when it calls rsnd_dai_call
Message-Id: <87iobz506i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8761948j4f.wl%kuninori.morimoto.gx@renesas.com>
	<8738488j2k.wl%kuninori.morimoto.gx@renesas.com>
	<alpine.DEB.2.10.1505041134140.4711@ayla.of.borg>
In-Reply-To: <alpine.DEB.2.10.1505041134140.4711@ayla.of.borg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, Simon <horms@verge.net.au>, Atsushi Tamaki <atsushi.tamaki.ks@renesas.com>, linux-sh@vger.kernel.org


Hi Geert

> >  static int rsnd_rdai_continuance_probe(struct rsnd_priv *priv,
> >  				       struct rsnd_dai_stream *io)
> >  {
> > +	unsigned long flags;
> >  	int ret;
> >  
> > +	rsnd_lock(priv, flags);
> > +
> >  	ret = rsnd_dai_call(probe, io, priv);
> >  	if (ret = -EAGAIN) {
> >  		/*
> 
> This causes the following warning on r8a7791/koelsch:

Thank you for pointing this.
I will check/fixup it.

> 
> WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:2755 lockdep_trace_alloc+0xd4/0x118()
> DEBUG_LOCKS_WARN_ON(irqs_disabled_flags(flags))
> Modules linked in:
> 
> CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.1.0-rc2-koelsch-00564-g1817f2746e13e08e #1081
> Hardware name: Generic R8A7791 (Flattened Device Tree)
> Backtrace: 
> [<c00135e0>] (dump_backtrace) from [<c0013800>] (show_stack+0x18/0x1c)
>  r6:c0546ece r5:00000009 r4:00000000 r3:00204140
> [<c00137e8>] (show_stack) from [<c04483ec>] (dump_stack+0x78/0x94)
> [<c0448374>] (dump_stack) from [<c002d368>] (warn_slowpath_common+0x90/0xbc)
>  r4:eec59c90 r3:00000001
> [<c002d2d8>] (warn_slowpath_common) from [<c002d3cc>] (warn_slowpath_fmt+0x38/0x40)
>  r8:eed90010 r7:000001a1 r6:000080d0 r5:000080d0 r4:60000193
> [<c002d398>] (warn_slowpath_fmt) from [<c0069e94>] (lockdep_trace_alloc+0xd4/0x118)
>  r3:c054c535 r2:c0547435
> [<c0069dc0>] (lockdep_trace_alloc) from [<c00e3acc>] (__kmalloc_track_caller+0x34/0x11c)
>  r5:eec000c0 r4:00000000
> [<c00e3a98>] (__kmalloc_track_caller) from [<c02678b4>] (devres_alloc+0x20/0x48)
>  r7:000001a1 r6:ee7e2138 r5:c007a3d8 r4:00000000
> [<c0267894>] (devres_alloc) from [<c007a378>] (devm_request_threaded_irq+0x34/0x94)
>  r5:ee7ea8d0 r4:00000000
> [<c007a344>] (devm_request_threaded_irq) from [<c036ad4c>] (rsnd_src_probe_gen2+0x68/0x7c)
>  r9:eef61120 r8:a0000113 r7:ee7ea8d8 r6:eef6113c r5:ee7ea8d0 r4:ee7e2138
> [<c036ace4>] (rsnd_src_probe_gen2) from [<c0367e1c>] (rsnd_rdai_continuance_probe+0x80/0x29c)
>  r5:eef61130 r4:c036ace4
> [<c0367d9c>] (rsnd_rdai_continuance_probe) from [<c0368a80>] (rsnd_probe+0x114/0x304)
>  r10:eef61110 r9:00000000 r8:ee7ea8d8 r7:eed90000 r6:eed90010 r5:ee7ea8d0
>  r4:c048e960
> [<c036896c>] (rsnd_probe) from [<c02667f4>] (platform_drv_probe+0x50/0xa0)
>  r10:00000000 r9:c062f000 r8:c0624dec r7:00000000 r6:c0624dec r5:eed90010
>  r4:fffffffe
> [<c02667a4>] (platform_drv_probe) from [<c0264fac>] (driver_probe_device+0xfc/0x264)
>  r6:00000000 r5:c0e1e9fc r4:eed90010 r3:c02667a4
> [<c0264eb0>] (driver_probe_device) from [<c02651d8>] (__driver_attach+0x78/0x9c)
>  r8:c0606460 r7:c0619e98 r6:c0624dec r5:eed90044 r4:eed90010 r3:00000000
> [<c0265160>] (__driver_attach) from [<c02635c8>] (bus_for_each_dev+0x74/0x98)
>  r6:c0265160 r5:c0624dec r4:00000000 r3:00000001
> [<c0263554>] (bus_for_each_dev) from [<c0264a98>] (driver_attach+0x20/0x28)
>  r6:ee7ea9c0 r5:00000000 r4:c0624dec
> [<c0264a78>] (driver_attach) from [<c0264728>] (bus_add_driver+0xe8/0x1d0)
> [<c0264640>] (bus_add_driver) from [<c0265868>] (driver_register+0xa4/0xe8)
>  r7:c0606460 r6:00000000 r5:c05e6abc r4:c0624dec
> [<c02657c4>] (driver_register) from [<c0266728>] (__platform_driver_register+0x50/0x64)
>  r5:c05e6abc r4:ee7eec40
> [<c02666d8>] (__platform_driver_register) from [<c05e6ad4>] (rsnd_driver_init+0x18/0x20)
> [<c05e6abc>] (rsnd_driver_init) from [<c000a7d8>] (do_one_initcall+0x108/0x1bc)
> [<c000a6d0>] (do_one_initcall) from [<c05c7dc8>] (kernel_init_freeable+0x11c/0x1e4)
>  r9:c062f000 r8:c062f000 r7:c05fb160 r6:c05f3a40 r5:00000084 r4:00000006
> [<c05c7cac>] (kernel_init_freeable) from [<c0445120>] (kernel_init+0x10/0xec)
>  r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0445110 r4:00000000
> [<c0445110>] (kernel_init) from [<c000fef0>] (ret_from_fork+0x14/0x24)
>  r4:00000000 r3:00000000
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
