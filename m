From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 18 Jul 2008 05:12:21 +0000
Subject: Re: [PATCH] sh7760mmc: host driver for SH7760 MMC interface
Message-Id: <20080718051221.GA22279@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080717110119.GA14949@roarinelk.homelinux.net>
In-Reply-To: <20080717110119.GA14949@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Paul,

On Fri, Jul 18, 2008 at 08:09:16AM +0900, Paul Mundt wrote:
> On Thu, Jul 17, 2008 at 01:03:53PM +0200, Manuel Lauss wrote:
> > Here is my latest attempt at an MMC host driver for the MMCIF interface
> > found on many SH-4 socs, particularly the SH7760, SH778x, and SH7763.
> > 
> > This is a very basic driver, without DMA support and crippled performance
> > due to hardware or driver bugs wrt. multiblock writes.
> > 
> > The driver has been extensively tested on SH7760 only.  The SH7780 and 7763
> > MMCIF should theoretically work with some minor adjustments.
> > 
> > Patch is against latest linus git.
> > 
> Looks good to me in general, though a few minor nits.
> 
> > +/* The MMCIF does not provide any facilities for card- and read-only
> > + * detection as well as voltage setting. Use GPIOs in the board-specific
> > + * code for that. PLEASE READ Documentation/sh/sh7760-mmc.txt if you
> > + * want to use this driver with your board!
> > + *
> This document appears to be missing in your patch.

Will be in my next patch.

 
> > +static inline unsigned short MMC_INW(struct shmmc_host *h, unsigned int reg)
> > +{
> > +	return ioread16(h->iobase + reg);
> > +}
> > +
> > +static inline void MMC_OUTW(struct shmmc_host *h, int reg, unsigned short val)
> > +{
> > +	iowrite16(val, h->iobase + reg);
> > +}
> > +
> > +static inline unsigned char MMC_INB(struct shmmc_host *h, unsigned int reg)
> > +{
> > +	return ioread8(h->iobase + reg);
> > +}
> > +
> > +static inline void MMC_OUTB(struct shmmc_host *h, int reg, unsigned char val)
> > +{
> > +	iowrite8(val, h->iobase + reg);
> > +}
> > +
> These accessors seem pretty pointless, any reason you don't just use
> ioread/writeX() directly?

makes it easier to spot accesses to the peripheral in code. Other than
readability issues, no reason.  I'll replace them all if necessary.


> > +static void shmmc_done_tasklet(unsigned long arg)
> > +{
> > +	struct shmmc_host *host = (struct shmmc_host *)arg;
> > +	struct mmc_request *mrq;
> > +
> > +	mrq = host->mrq;
> > +
> > +	/* should not happen, but I've seen it once or twice */
> > +	if (!mrq) {
> > +		pr_debug("%s: mrq = 0!\n", mmc_hostname(host->mmc));
> > +		return;
> > +	}
> > +	host->mrq = NULL;
> > +
> > +	/* HACK ALERT: I need this cache flush on my SH7760 system because
> > +	 * otherwise bits of the card response will be corrupted,
> > +	 * preventing card identification due to malformed CID/SCR/...
> > +	 * Don't know why, but it has been this way all the way back to
> > +	 * 2.6.17.  -- mlau
> > +	 */
> > +	flush_dcache_all();
> > +
> flush_dcache_all() seems a bit heavy-handed, even for a hack. Though it
> would be good to know why this is occuring in the first place..
> 
> Also, is the implication that you didn't need this in 2.6.16 and earlier,
> or that 2.6.17 was the first kernel you tested this driver on?

I think I originally wrote it for 2.6.16, which worked pretty well. 
Sometimes however, when inserting a card, random kernel was (is) printed
instead of the card name (most of the time an empty string, but on rare
occasions random memory dumps and a kernel hang afterwards).  It never
really was a huge problem until around 2.6.22 when the MMC core was unable
to detect my cards. So I stuck this cache flush in there and voila, working
mmc and happy customers ;-)

I also tried to flush_dcache_page() the various pointers the mmc core hands
to a driver, but nothing helps except for the sledgehammer approach.

I didn't investigate it in deep but the MMC core debug output shows intact
response values, however the sysfs nodes only show truncated garbage (i.e.
instead of a cid 03534453443031478040cab522007ce5 only the upper 3-4 bytes
are intact and the rest zeroes).

 
> > +static inline void
> > +shmmc_write_fifo(struct shmmc_host *host, unsigned long cnt)
> > +{
> > +	unsigned short *sga;
> > +
> > +	/* get a pointer to physical RAM */
> > +	sga = (unsigned short *)P2SEGADDR(sg_dma_address(host->data->sg)
> > +					  + host->xfered);
> > +
> P2SEGADDR is going away in the future completely, so it would be
> preferable not to opencode more instances of it in new code.

What is the preferred method now to get a pointer to do PIO on SH?

I'm looking into refreshing the SH DMA api, since a lot of other drivers
could benefit from it as well.  Using DMA would also simplify the drivers'
irq handlers.


> > +	host->ioarea = request_mem_region(r->start, r->end - r->start + 1,
> > +					  dev->name);
> > +	if (!host->ioarea)
> > +		goto out0;
> > +
> > +	host->iobase = ioremap(r->start, r->end - r->start + 1);
> > +	if (!host->iobase)
> > +		goto out1;
> > +
> Off-by-1 on resource size. request_mem_region() wants r->end - r->start
> while ioremap wants the + 1.

Gaah. This inconsistency sucks. Fixed.

 
> > +MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
> > +MODULE_DESCRIPTION("SH7760 MMCIF driver");
> > +MODULE_LICENSE("GPL");
> 
> Your boilerplate at the top suggests v2 only, while MODULE_LICENSE("GPL")
> implies "or any later version". You may want to revise this to be "GPL
> v2" if restricting it is indeed your intention.

Done.


Thanks Paul!
	Manuel Lauss
