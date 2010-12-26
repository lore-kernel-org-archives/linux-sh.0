From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 26 Dec 2010 22:59:15 +0000
Subject: Re: SDHI polling
Message-Id: <AANLkTinShnKkpKJHd1=1FhCYn0TSKc2b_BL0MpuoX0KO@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20101226224506.GD21535@verge.net.au>
In-Reply-To: <20101226224506.GD21535@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Mon, Dec 27, 2010 at 7:45 AM, Simon Horman <horms@verge.net.au> wrote:
> I have it in mind to run the SDHI hardware block in some sort of
> polling mode - that is, with interrupts disabled - during early
> boot. Does this make any sense?

I guess it depends on how early you mean. =)

Usually you want to make use of interrupts if they are available, but
for really early code there is no interrupt support. So the in-kernel
early printk support is implemented without any interrupts for
instance. At least this is true for the SCIF driver used by SH and
SH-Mobile / R-Mobile, pretty sure it applies to other hardware
platforms as well.

As for the SDHI version of the MMC loader, I think you should do the
same as the MMCIF loader that is present in
include/linux/mmc/sh_mmcif.h. As you know it gets compiled into a
separate image together with the rest of the zImage loader. No
interrupt handling is available in that code, so just implementing
things using polling mode is good enough.

I'm not 100% sure about U-boot these days, but I wouldn't be surprised
if many boot loaders only implement polling.

Cheers,

/ magnus
