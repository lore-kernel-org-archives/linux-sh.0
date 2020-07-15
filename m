From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 15 Jul 2020 07:27:08 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de> <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx> <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
In-Reply-To: <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Adrian,

On Wed, Jul 15, 2020 at 1:14 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> However, independent of Christoph's series, the kernels throws two backtraces during
> boot which I think should require a git bisect (unless I missed a configuration option
> as I trimmed down the kernel a bit to make sure it's not too big).
>
> See the traces below and let me know what you think.

> [    1.560000] sh-sci.1: ttySC1 at MMIO 0xffeb0000 (irq = 44, base_baud = 0) is a scif
> [    1.560000] BUG: spinlock bad magic on CPU#0, swapper/1
> [    1.560000]  lock: sci_ports+0x1d8/0xb10, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0

[PATCH v1] serial: core: Initialise spin lock before use in
uart_configure_port()
https://lore.kernel.org/r/20200706140036.75524-1-andriy.shevchenko@linux.intel.com

> [    1.560000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
> [    1.560000] Stack: (0x9f445ce8 to 0x9f446000)
> [    1.560000] 5ce0:
> [    1.560000]
> [    1.560000]
> [    1.560000] 80260daa
> [    1.560000] 9f445cfc
> [    1.560000] 80048fd8
> [    1.560000] 8096c158
> [    1.560000] 805ab908
> [    1.560000] 8004449c

Any plans to take "[PATCH v2 0/9] sh: Modernize printing of kernel messages"?
https://lore.kernel.org/r/20200617143639.18315-1-geert+renesas@glider.be


> [    5.464000] WARNING: CPU: 0 PID: 1 at mm/slab.c:2589 cache_alloc_refill+0x216/0x6a0
> [    5.464000] Modules linked in:
> [    5.464000]
> [    5.464000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
> [    5.464000] PC is at cache_alloc_refill+0x216/0x6a0
> [    5.464000] PR is at kmem_cache_alloc+0xd6/0x128
> [    5.464000] PC  : 800ec0d2 SP  : 9f445e68 SR  : 400080f0
> [    5.464000] TEA : c00c30d0
> [    5.464000] R0  : 8062724c R1  : 8000fee8 R2  : 9f403540 R3  : 00000100
> [    5.464000] R4  : 9f403500 R5  : 00000000 R6  : 8068d5b0 R7  : 007fffff
> [    5.464000] R8  : 0000000c R9  : 9f403500 R10 : 8096fc0c R11 : 80044410
> [    5.464000] R12 : 9f405060 R13 : 00000dc0 R14 : 9f445e68
> [    5.464000] MACH: 10623bba MACL: 00000cc0 GBR : 2957bd58 PR  : 800ec80a
> [    5.464000]
> [    5.464000] Call trace:
> [    5.464000]  [<(ptrval)>] _raw_spin_unlock_irqrestore+0x0/0x54
> [    5.464000]  [<(ptrval)>] _raw_spin_lock_irqsave+0x0/0x44
> [    5.464000]  [<(ptrval)>] kmem_cache_alloc+0xd6/0x128
> [    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
> [    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
> [    5.464000]  [<(ptrval)>] pgd_alloc+0x10/0x24

Does commit 73c348f31b63d28d ("sh: Fix unneeded constructor in page
table allocation") in next-20200710 and later fix that?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
