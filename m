From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 15 Jul 2020 07:46:33 +0000
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-Id: <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
In-Reply-To: <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 7/15/20 9:27 AM, Geert Uytterhoeven wrote:
>> [    5.464000] WARNING: CPU: 0 PID: 1 at mm/slab.c:2589 cache_alloc_refill+0x216/0x6a0
>> [    5.464000] Modules linked in:
>> [    5.464000]
>> [    5.464000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
>> [    5.464000] PC is at cache_alloc_refill+0x216/0x6a0
>> [    5.464000] PR is at kmem_cache_alloc+0xd6/0x128
>> [    5.464000] PC  : 800ec0d2 SP  : 9f445e68 SR  : 400080f0
>> [    5.464000] TEA : c00c30d0
>> [    5.464000] R0  : 8062724c R1  : 8000fee8 R2  : 9f403540 R3  : 00000100
>> [    5.464000] R4  : 9f403500 R5  : 00000000 R6  : 8068d5b0 R7  : 007fffff
>> [    5.464000] R8  : 0000000c R9  : 9f403500 R10 : 8096fc0c R11 : 80044410
>> [    5.464000] R12 : 9f405060 R13 : 00000dc0 R14 : 9f445e68
>> [    5.464000] MACH: 10623bba MACL: 00000cc0 GBR : 2957bd58 PR  : 800ec80a
>> [    5.464000]
>> [    5.464000] Call trace:
>> [    5.464000]  [<(ptrval)>] _raw_spin_unlock_irqrestore+0x0/0x54
>> [    5.464000]  [<(ptrval)>] _raw_spin_lock_irqsave+0x0/0x44
>> [    5.464000]  [<(ptrval)>] kmem_cache_alloc+0xd6/0x128
>> [    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
>> [    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
>> [    5.464000]  [<(ptrval)>] pgd_alloc+0x10/0x24
> 
> Does commit 73c348f31b63d28d ("sh: Fix unneeded constructor in page
> table allocation") in next-20200710 and later fix that?

Indeed, it does. This patch should be picked up as well.

Kernel boots without any errors now.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
