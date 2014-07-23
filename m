From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 23 Jul 2014 09:48:25 +0000
Subject: Re: [PATCH/RFC 0/5] R-Car Gen2 DMAC hardware descriptor list support
Message-Id: <1815783.Bld4nzvI29@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1406032431-3807-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tuesday 22 July 2014 19:17:23 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > The code has been tested by artificially lowering the maximum chunk size
> > to 4096 bytes and running dmatest, which completed sucessfully. Morimoto-
> > san, is there an easy way to test cyclic transfers with your audio driver
> > ?
>
> Thank you for your offer.
> I tested this patchset with audio DMAC (= cyclic transfer)
> but, it doesn't work for me.
> 
> First of all, this sound driver which is using cyclic transfer
> was worked well in shdma-base driver.
> I had sent audio DMA support plafrom side patches before.
> But, of course I'm happy to update sound driver side.
> 
> I will re-send my audio DMAC support patches after this email.
> 
> My troubles are...
> 
> 1. "filter" still can't care "dma0" or "audma0"
> 
>  	dmac0: dma-controller@e6700000 {
> 	..
> 	};
> 	dmac1: dma-controller@e6720000 {
> 	...
> 	};
> 	audma0: dma-contorller@ec700000 {
> 	...
> 	};
> 	audma1: dma-controller@ec720000 {
> 	...
> 	};
> 	audmapp: audio-dma-pp@0xec740000 {
> 	...
> 	};
> 
>   audio driver requests "audma0, 0x01",
>   but, filter accepts it as "dmac0, 0x01"

Indeed, I've fixed the rcar-dmac driver to ignore channels handled by a 
different driver, but not channels handled by the same driver but a different 
device. I'll fix that.

By the way, I've noticed an issue with the snd_soc_rcar driver. If a 
dma_request_slave_channel_compat() call fails in a module probe operation, the 
rsnd_probe() function will return an error immediately

        for_each_rsnd_dai(rdai, priv, i) {
                ret = rsnd_dai_call(probe, &rdai->playback, rdai);
                if (ret)
                        return ret;

                ret = rsnd_dai_call(probe, &rdai->capture, rdai);
                if (ret)
                        return ret;
        }

The modules that have been successfully probed are not cleaned up, so DMA 
channels allocated by modules successfully probed are never released.

> 2. cyclic transfer doesn't work
> 
>    I got attached error.

I'm not too surprised as I haven't tested cyclic DMA yet :-) I'll fix it.

> ----------------------
> Playing WAVE '/home/Calm_16bit_48k.wav' : Signed 16 bit Little Endian, Rate
> 48000 Hz, Stereo ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 0 at
> /opt/home/morimoto/linux/drivers/dma/sh/rcar-dmac.c:1264
> rcar_dmac_isr_channel+0x68/0x184() CPU: 0 PID: 0 Comm: swapper/0 Not
> tainted 3.16.0-rc4-02824-gfc6caf1-dirty #291 Backtrace:
> [<c0011bbc>] (dump_backtrace) from [<c0011df8>] (show_stack+0x18/0x1c)
>  r6:c0516218 r5:00000009 r4:00000000 r3:00200000
> [<c0011de0>] (show_stack) from [<c0437e44>] (dump_stack+0x7c/0x98)
> [<c0437dc8>] (dump_stack) from [<c0024dac>] (warn_slowpath_common+0x68/0x8c)
> r4:00000000 r3:600f0193
> [<c0024d44>] (warn_slowpath_common) from [<c0024ea8>]
> (warn_slowpath_null+0x24/0x2c) r8:edbe6800 r7:00000000 r6:00000000
> r5:3e0c1810 r4:ee278010
> [<c0024e84>] (warn_slowpath_null) from [<c01d4710>]
> (rcar_dmac_isr_channel+0x68/0x184) [<c01d46a8>] (rcar_dmac_isr_channel)
> from [<c005f2dc>] (handle_irq_event_percpu+0x38/0x130) r6:00000000
> r5:00000160 r4:ee3ab3c0 r3:c01d46a8
> [<c005f2a4>] (handle_irq_event_percpu) from [<c005f41c>]
> (handle_irq_event+0x48/0x68) r10:00000000 r9:00000014 r8:edbe6800
> r7:c0587c9c r6:c0587f40 r5:c05a0c84 r4:ee818c40
> [<c005f3d4>] (handle_irq_event) from [<c00621c0>]
> (handle_fasteoi_irq+0xbc/0x144) r5:c05a0c84 r4:ee818c40
> [<c0062104>] (handle_fasteoi_irq) from [<c005ed04>]
> (generic_handle_irq+0x28/0x38) r5:c0583bcc r4:00000160
> [<c005ecdc>] (generic_handle_irq) from [<c000f184>] (handle_IRQ+0x70/0x98)
>  r4:00000160 r3:000001a7
> [<c000f114>] (handle_IRQ) from [<c0009320>] (gic_handle_irq+0x44/0x68)
>  r6:c058e88c r5:c0587c68 r4:f0002000 r3:000001a0
> [<c00092dc>] (gic_handle_irq) from [<c00129c0>] (__irq_svc+0x40/0x50)
> Exception stack(0xc0587c68 to 0xc0587cb0)
> 7c60:                   c05b308c 00000000 0d4a0d4a 0d4b0d4a ee231a00
> edb71b80 7c80: 00000000 00000000 edbe6800 00000014 00000000 c0587cbc
> c0587cc0 c0587cb0 7ca0: c03871f0 c043c4c0 600f0113 ffffffff
>  r6:ffffffff r5:600f0113 r4:c043c4c0 r3:c03871f0
> [<c043c49c>] (_raw_spin_lock) from [<c03871f0>] (ip_defrag+0xaac/0xcb8)
> [<c0386744>] (ip_defrag) from [<c0385a10>] (ip_local_deliver+0x5c/0x268)
>  r10:edb71b80 r9:c058f24c r8:00000008 r7:c05b2f40 r6:edb71b80 r5:edb71b98
>  r4:ee22332e
> [<c03859b4>] (ip_local_deliver) from [<c038626c>] (ip_rcv+0x650/0x6f0)
>  r7:c05b2f40 r6:edb71b80 r5:edb71b98 r4:ee22332e
> [<c0385c1c>] (ip_rcv) from [<c035e6a0>]
> (__netif_receive_skb_core+0x470/0x50c) r9:c058f24c r8:00000008 r7:c05900d0
> r6:00000000 r5:c058f238 r4:00000000 [<c035e230>] (__netif_receive_skb_core)
> from [<c035e908>] (__netif_receive_skb+0x2c/0x80) r10:000005ea r9:edbe6a78
> r8:edbe6d10 r7:0000003f r6:0000003f r5:c058f238 r4:edb71b80
> [<c035e8dc>] (__netif_receive_skb) from [<c035e9c0>]
> (netif_receive_skb_internal+0x64/0xa4) r5:c058f238 r4:edb71b80
> [<c035e95c>] (netif_receive_skb_internal) from [<c0362200>]
> (netif_receive_skb+0x10/0x14) r5:edb71b80 r4:edbe6800
> [<c03621f0>] (netif_receive_skb) from [<c027b230>] (sh_eth_poll+0x214/0x494)
> [<c027b01c>] (sh_eth_poll) from [<c0362784>] (net_rx_action+0xb8/0x174)
> r10:c05880c0 r9:00000040 r8:c05ba8b8 r7:eef9fc88 r6:0000012c r5:eef9fc80
> r4:edbe6d10
> [<c03626cc>] (net_rx_action) from [<c0028a04>] (__do_softirq+0xf0/0x22c)
>  r10:c0586000 r9:00000100 r8:c058808c r7:c0588080 r6:c0586000 r5:c0586018
>  r4:00000008
> [<c0028914>] (__do_softirq) from [<c0028da4>] (irq_exit+0x8c/0xe8)
>  r10:00000000 r9:413fc0f2 r8:ef7fccc0 r7:c0587f74 r6:00000000 r5:c0583bcc
>  r4:c0586028
> [<c0028d18>] (irq_exit) from [<c000f188>] (handle_IRQ+0x74/0x98)
>  r4:000000c2 r3:000001a7
> [<c000f114>] (handle_IRQ) from [<c0009320>] (gic_handle_irq+0x44/0x68)
>  r6:c058e88c r5:c0587f40 r4:f0002000 r3:000001a0
> [<c00092dc>] (gic_handle_irq) from [<c00129c0>] (__irq_svc+0x40/0x50)
> Exception stack(0xc0587f40 to 0xc0587f88)
> 7f40: eef9e490 00000000 0000404a 00000000 c0586018 c0586000 c0586000
> c0579814 7f60: ef7fccc0 413fc0f2 00000000 c0587f94 c0587f98 c0587f88
> c000f484 c000f488 7f80: 600f0013 ffffffff
>  r6:ffffffff r5:600f0013 r4:c000f488 r3:c000f484
> [<c000f45c>] (arch_cpu_idle) from [<c0056428>]
> (cpu_startup_entry+0xf4/0x154) [<c0056334>] (cpu_startup_entry) from
> [<c0434ea8>] (rest_init+0x68/0x80) [<c0434e40>] (rest_init) from
> [<c0548b74>] (start_kernel+0x2cc/0x31c) [<c05488a8>] (start_kernel) from
> [<40008074>] (0x40008074)
> ----------------------

-- 
Regards,

Laurent Pinchart

