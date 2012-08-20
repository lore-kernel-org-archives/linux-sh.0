From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Aug 2012 08:12:13 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <87fw7irnhh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> The irqdomain ranges are calculated using evt2irq(), but it looks like
> sh73a0 needs to use intcs_evt2irq()/to_intc_vect() for factoring in the
> offsets. That offset factorization appears to be what is throwing this
> out of range -- though why evt2irq() use on these vectors hasn't resulted
> in issues before this I don't know.
>
> Do you observe any difference by dropping evt2irq() bounding for the
> linear range and simply using the tree type?

I tried your patch, but I got same result as before.
I'm using 
 linus/master + paul/sh-latest + your-patch

----------------
irq: irq_domain_associate_many(<no-node>, irqbaseQ6, hwbaseQ6, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseQ7, hwbaseQ7, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseQ8, hwbaseQ8, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseR0, hwbaseR0, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseR1, hwbaseR1, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseR2, hwbaseR2, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseR3, hwbaseR3, count=1)
(snip)
intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs
irq: Allocated domain of type 3 @0xde8029c0
irq: irq_domain_associate_many(<no-node>, irqbaseT4, hwbaseT4, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseT5, hwbaseT5, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseT6, hwbaseT6, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseT7, hwbaseT7, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseT8, hwbaseT8, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseT9, hwbaseT9, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseU0, hwbaseU0, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseU1, hwbaseU1, count=1)
irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=1)
------------[ cut here ]------------
WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
error: irq_desc already associated; irqU2 hwirq=0x228
Modules linked in:
Backtrace:
[<c0012358>] (dump_backtrace+0x0/0x10c) from [<c02e7e1c>] (dump_stack+0x18/0x1c)
 r6:c0065640 r5:00000009 r4:c03e9ed8 r3:c0404908
[<c02e7e04>] (dump_stack+0x0/0x1c) from [<c001cecc>] (warn_slowpath_common+0x54)
[<c001ce78>] (warn_slowpath_common+0x0/0x6c) from [<c001cf88>] (warn_slowpath_f)
 r8:00000228 r7:c03de514 r6:00000228 r5:00000000 r4:de8029c0
r3:00000009

Best regards
---
Kuninori Morimoto
