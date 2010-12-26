From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 26 Dec 2010 23:24:04 +0000
Subject: Re: SDHI polling
Message-Id: <20101226232404.GA16946@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101226224506.GD21535@verge.net.au>
In-Reply-To: <20101226224506.GD21535@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 27, 2010 at 07:59:15AM +0900, Magnus Damm wrote:
> On Mon, Dec 27, 2010 at 7:45 AM, Simon Horman <horms@verge.net.au> wrote:
> > I have it in mind to run the SDHI hardware block in some sort of
> > polling mode - that is, with interrupts disabled - during early
> > boot. Does this make any sense?
> 
> I guess it depends on how early you mean. =)
> 
> Usually you want to make use of interrupts if they are available, but
> for really early code there is no interrupt support. So the in-kernel
> early printk support is implemented without any interrupts for
> instance. At least this is true for the SCIF driver used by SH and
> SH-Mobile / R-Mobile, pretty sure it applies to other hardware
> platforms as well.
> 
> As for the SDHI version of the MMC loader, I think you should do the
> same as the MMCIF loader that is present in
> include/linux/mmc/sh_mmcif.h. As you know it gets compiled into a
> separate image together with the rest of the zImage loader. No
> interrupt handling is available in that code, so just implementing
> things using polling mode is good enough.
> 
> I'm not 100% sure about U-boot these days, but I wouldn't be surprised
> if many boot loaders only implement polling.
> 
That's probably true, but note that most boot loaders do have rudimentary
interrupt stubs for the timer tick and so forth. I wouldn't classify a
boot loader as early code, it's more just half-assed. For true "early"
code polling is probably ok, particularly if you aren't able to continue
on without reading the image from the card. You will probably still want
to be able to track various state changes in order to ease debugging and
work out whether you get stuck or not. If the block raises an exception
for recoverable errors and so on then you're still going to have to deal
with an asynchronous code flow, too.
