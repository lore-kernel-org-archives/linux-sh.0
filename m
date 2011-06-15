From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 15 Jun 2011 07:34:49 +0000
Subject: Re: current kernel seems unstable
Message-Id: <Pine.LNX.4.64.1106150932450.23363@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3p7h8q6vgo.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3p7h8q6vgo.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Morimoto-san

On Mon, 13 Jun 2011, Kuninori Morimoto wrote:

> 
> Dear Guennadi
> 
> Thank you for your reply
> 
> > Do you mean, you're getting this only with USB? Can you also reproduce 
> > anything like that with other DMA users? Also, that's not a complete 
> > message from the kernel, could you send the complete one?
> 
> After your reply mail,
> I enabled CONFIG_MMC_SDHI on Ecovec.

Could you please tell me what exact tree, branch and commit you used to 
produce a kernel for ecovec and also send me (privately) your .config 
file? I tried several kernels yesterday and none of them worked for me.

Thanks
Guennadi

> And I got below.
> Linux kernel seems 100% cannnot boot.
> It seems not DMAEngine fail. so sorry.
> (I modified Mail Subject)
> 
> Is it driver issue ? or spin lock issue ?
> 
> ---- kernel boot -------
> ....
> camera 1-1: Probing 1-1
> sh_mobile_ceu sh_mobile_ceu.1: SuperH Mobile CEU driver attached to camera 1
> camera 1-1: Cannot get I2C adapter #1. No driver?
> sh_mobile_ceu sh_mobile_ceu.1: SuperH Mobile CEU driver detached from camera 1
> sh_mobile_sdhi sh_mobile_sdhi.0: mmc0 base at 0x04ce0000 clock rate 83 MHz
> sh_mobile_sdhi sh_mobile_sdhi.1: mmc1 base at 0x04cf0000 clock rate 83 MHz
> sh_tmu sh_tmu.0: kept as earlytimer
> sh_tmu sh_tmu.1: kept as earlytimer
> ALSA device list:
>   No soundcards found.
> heartbeat: version 0.1.2 loaded
> TCP cubic registered
> NET: Registered protocol family 17
> BUG: spinlock recursion on CPU#0, swapper/1
>  lock: 8f1b3c58, .magic: dead4ead, .owner: swapper/1, .owner_cpu: 0
> Stack: (0x8f029cf8 to 0x8f02a000)
> 9ce0:                                                       882947ca 8f029d08
> 9d00: 8f02713c 8f1b3c58 8813eaea 8f029d10 8835bfd8 8813ec04 8f029d2c 8f1b3c58
> 9d20: 881ea1d4 000000f0 8f1b3c58 8829725a 8f029d58 8f1b3be4 88297262 8f029d58
> 9d40: 8f1b3be4 8f1b3bd0 8f1b3c58 881ea1d4 000000f0 8f1b3c58 881ea1d4 8f029d6c
> 9d60: 8f1b3800 8f04be10 8f1b3b80 881defe2 8f029d84 8f1b3c58 00400001 8f04be10
> 9d80: 8f1b3b80 881ea4fc 8f029d8c 881ea922 8f029d9c 20c00601 8f1b3b80 000000f0
> 9da0: 8f04be3c 000000f0 8f1b3be0 8f1b3bcc 88045116 8f029dd0 887ec9a8 8f00b720
> 9dc0: 8f00b6e0 00000000 00000064 8f1ad860 00000000 88409e54 8804524e 8f029df8
> 9de0: 88409e54 883be390 880166a4 8f1ad860 8f00b728 8f00b6e0 88046f2e 8f029e0c
> 9e00: 00010000 8f00b728 8f00b6e0 880450cc 8f029e20 00000003 880035a4 00000064
> 9e20: 881ebb2c 8f029e2c 00000065 880450cc 8f029e34 880035ce 8f029e40 00000000
> 9e40: 00000065 880070f4 8f029eac 400081f1 00000000 00000000 40008100 00000000
> 9e60: 00000000 00000001 88016c6e 00000000 00000029 00000001 00000003 880166a4
> 9e80: 883be390 88409e54 8f029eac 8f029eac 880036c0 8801729a 40008100 00000000
> 9ea0: 00000000 00000020 ffffffff 8f029eb0 00000000 883e35e8 00000002 00000000
> 9ec0: 00000000 000000f0 883e0038 8803a180 8f029f00 000000f0 883dff38 00000000
> 9ee0: 880036a0 0000027c 00000000 00000001 00000000 00000000 88206832 8f029f00
> 9f00: 00000000 00000006 00000000 8829496a 8f029f2c 00000000 00000000 00000000
> 9f20: 88405e24 882caa60 00000000 8f029f38 88206856 8f029f44 00000011 8820684e
> 9f40: ffe00000 883fc3b6 8f029f54 883fc398 00000000 880020ea 8f029f60 88405de4
> 9f60: 883c0760 8f029f68 883e6242 8f029f88 00000000 00000000 00000000 88405e24
> 9f80: 88002050 88405de4 88003d34 8f029f9c 00000000 00000000 00000000 00000000
> 9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 883e61d0 00000000
> 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> 9fe0: 8f029fa4 88003d2c 00000000 40008000 00000000 00000000 00000000 00000000
> 
> Call trace:
>  [<882947ca>] dump_stack+0xe/0x1c
>  [<8813eaea>] spin_bug+0x76/0xa4
>  [<8813ec04>] do_raw_spin_lock+0x38/0x114
>  [<881ea1d4>] tmio_mmc_request+0x20/0x224
>  [<8829725a>] _raw_spin_lock_irqsave+0x3e/0x68
>  [<88297262>] _raw_spin_lock_irqsave+0x46/0x68
>  [<881ea1d4>] tmio_mmc_request+0x20/0x224
>  [<881ea1d4>] tmio_mmc_request+0x20/0x224
>  [<881defe2>] mmc_request_done+0x3e/0x68
>  [<881ea4fc>] tmio_mmc_finish_request+0x48/0x60
>  [<881ea922>] tmio_mmc_irq+0x2e2/0x604
>  [<88045116>] handle_irq_event_percpu+0x2e/0x134
>  [<8804524e>] handle_irq_event+0x32/0x68
>  [<880166a4>] emit_log_char+0x0/0x6c
>  [<88046f2e>] handle_level_irq+0x76/0xc4
>  [<880450cc>] generic_handle_irq+0x1c/0x2c
>  [<880035a4>] do_IRQ+0x0/0x58
>  [<881ebb2c>] intc_redirect_irq+0x18/0x28
>  [<880450cc>] generic_handle_irq+0x1c/0x2c
>  [<880035ce>] do_IRQ+0x2a/0x58
>  [<880070f4>] ret_from_irq+0x0/0x10
>  [<88016c6e>] console_unlock+0x10a/0x180
>  [<880166a4>] emit_log_char+0x0/0x6c
>  [<880036c0>] arch_local_irq_restore+0x20/0x2a
>  [<8801729a>] vprintk+0x312/0x380
>  [<8803a180>] lock_acquire+0x64/0x98
>  [<880036a0>] arch_local_irq_restore+0x0/0x2a
>  [<88206832>] sock_register+0x2a/0x78
>  [<8829496a>] printk+0x1e/0x30
>  [<88206856>] sock_register+0x4e/0x78
>  [<8820684e>] sock_register+0x46/0x78
>  [<883fc3b6>] packet_init+0x1e/0x5c
>  [<883fc398>] packet_init+0x0/0x5c
>  [<880020ea>] do_one_initcall+0x9a/0x15c
>  [<883e6242>] kernel_init+0x72/0x138
>  [<88002050>] do_one_initcall+0x0/0x15c
>  [<88003d34>] kernel_thread_helper+0x8/0x14
>  [<883e61d0>] kernel_init+0x0/0x138
>  [<88003d2c>] kernel_thread_helper+0x0/0x14
> 
> 
> Best regards
> --
> Kuninori Morimoto
>  
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
