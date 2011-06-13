From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 13 Jun 2011 06:51:00 +0000
Subject: Re: current DMAEngine seems unstable
Message-Id: <Pine.LNX.4.64.1106130838020.10101@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <w3paadm6yiw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3paadm6yiw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, 13 Jun 2011, Kuninori Morimoto wrote:

> 
> Dear all
> 
> I'm afraid that current shdma.c seems unstable.
> I'm using latest Paul's tree + usb tree.
> If I use DMAEngine, sometimes it say below.
> 
> It didn't happen when v2.6.39
> Does it happen only to me ?
> 
> my environment is
>  - Paul's tree + usb tree
>  - using renesas_usb + DMAEngine driver
>  - Ecovec board

Do you mean, you're getting this only with USB? Can you also reproduce 
anything like that with other DMA users? Also, that's not a complete 
message from the kernel, could you send the complete one?

I have one suspicion though. From the backtrace below it looks like a 
recursive spin-lock. One is taken in sh_chan_xfer_ld_queue() as 
spin_lock_bh(), and then an interrupt occurs, which calls spin_lock(). 
This wasn't supposed to happen, at least not as long as you only have one 
DMA transfer active per channel. You can try to verify this by either (1) 
reverting commit 2dc666673b5a39d005579a0ef63ae69b5094e686, or replacing 
spin_(un)lock_bh() in sh_chan_xfer_ld_queue() with 
spin_(un)lock_{save,restore}() (of course, you'll need to add a "flags" 
variable.)

Thanks
Guennadi

> 
> Call trace:
>  [<88287f56>] dump_stack+0xe/0x1c
>  [<8813eb0a>] spin_bug+0x76/0xa4
>  [<8813ec24>] do_raw_spin_lock+0x38/0x114
>  [<8828a918>] _raw_spin_lock+0x2c/0x48
>  [<8828a920>] _raw_spin_lock+0x34/0x48
>  [<881500ce>] sh_dmae_interrupt+0x1a/0x74
>  [<88045142>] handle_irq_event_percpu+0x2e/0x134
>  [<8804527a>] handle_irq_event+0x32/0x68
>  [<88046f5a>] handle_level_irq+0x76/0xc4
>  [<880450f8>] generic_handle_irq+0x1c/0x2c
>  [<8815019a>] sh_chan_xfer_ld_queue+0x72/0x90
>  [<880035a4>] do_IRQ+0x0/0x58
>  [<880035ce>] do_IRQ+0x2a/0x58
>  [<880070f4>] ret_from_irq+0x0/0x10
>  [<8815019a>] sh_chan_xfer_ld_queue+0x72/0x90
>  [<8815019a>] sh_chan_xfer_ld_queue+0x72/0x90
>  [<880036c0>] arch_local_irq_restore+0x20/0x2a
>  [<8803a526>] lock_release+0x126/0x16c
>  [<880036ca>] arch_local_save_flags+0x0/0xe
>  [<8828b0e0>] _raw_spin_unlock_bh+0x18/0x44
>  [<8815019a>] sh_chan_xfer_ld_queue+0x72/0x90
>  [<8815019a>] sh_chan_xfer_ld_queue+0x72/0x90
>  [<881501c4>] sh_dmae_memcpy_issue_pending+0xc/0x18
>  [<881aa718>] usbhsf_dma_prepare_tasklet+0xec/0x130
>  [<8801b01e>] tasklet_action+0x5a/0xa4
>  [<880036a0>] arch_local_irq_restore+0x0/0x2a
>  [<8801b454>] __do_softirq+0x60/0x108
>  [<8801b68e>] do_softirq+0x2e/0x54
>  [<8828855c>] schedule+0x0/0x480
>  [<880036ca>] arch_local_save_flags+0x0/0xe
>  [<88077e78>] quicklist_trim+0x0/0x11c
>  [<880035a4>] do_IRQ+0x0/0x58
>  [<8801b6e8>] irq_exit+0x34/0x5c
>  [<880035d4>] do_IRQ+0x30/0x58
>  [<880070f4>] ret_from_irq+0x0/0x10
>  [<880036a0>] arch_local_irq_restore+0x0/0x2a
>  [<88077e78>] quicklist_trim+0x0/0x11c
>  [<880036ca>] arch_local_save_flags+0x0/0xe
>  [<8828855c>] schedule+0x0/0x480
>  [<880033bc>] default_idle+0x3c/0x8c
>  [<880033ba>] default_idle+0x3a/0x8c
>  [<88003454>] cpu_idle+0x48/0x90
>  [<88284abe>] rest_init+0x8e/0xec
>  [<88133520>] strlen+0x0/0x58
>  [<883d58fc>] start_kernel+0x3d8/0x460
>  [<882880d8>] printk+0x0/0x30
>  [<8800202c>] _stext+0x2c/0x38
>  [<88002000>] _stext+0x0/0x38
> 
> Best regards
> --
> Kuninori Morimoto
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
