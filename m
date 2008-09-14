From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Sun, 14 Sep 2008 16:26:48 +0000
Subject: Re: [PATCH v2] sh7760mmc: Driver for SH7760 MMCIF interface.
Message-Id: <20080914182648.3c5e82f0@scarran.roarinelk.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080911093718.GA8671@roarinelk.homelinux.net>
In-Reply-To: <20080911093718.GA8671@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello Pierre,

On Sun, 14 Sep 2008 16:31:54 +0200
Pierre Ossman <drzeus@drzeus.cx> wrote:

> On Thu, 11 Sep 2008 11:37:18 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
> > +
> > +config MMC_SH7760
> > +	tristate "Renesas SH7760 MMCIF Interface support  (EXPERIMENTAL)"
> > +	depends on CPU_SUBTYPE_SH7760
> > +	help
> > +	  Say Y or M here to enable the SH7760 MMC Interface driver.
> 
> Is it really alpha quality (which is what EXPERIMENTAL means)? If so,
> you should also modify the "depends on".

Well, it works for me(TM), which is a custom board and SD cards;
the mmc_test titled "Correct xfer_size at read (start failure)"
never completes (and I don't really understand what the test actually
does).  So yeah, it's very alpha.


> > +			/* longer timeout for long response */
> > +			MMC_OUTB(host, CTOCR, 1);
> 
> Huh?

Command timeout counter register: The manual states one should write
'1' to this register for 136 bit responses and 0 for short/no
response.


> > +#ifdef CONFIG_CPU_SUBTYPE_SH7760
> > +		/* SH7760: skip R2 CRC checks; these fail every time */
> > +		if (mmc_resp_type(cmd) = MMC_RSP_R2) {
> > +			rsptyr &= ~RSPTYR_CRC;
> > +			host->ien1 &= ~INTCR1_CRCERIE;
> > +		}
> > +#endif
> 
> The problem is probably CRC with long responses, not just R2.




> > +	MMC_OUTB(host, CMDR0, (1 << 6) | (cmd->opcode & 0x3f));
> 
> The (1 << 6) could use a define.

It's the "HOST" bit. I'll add a constant.

 
> > +	/* start MMC engine */
> > +	shmmc_clock(host, 1);
> 
> Hmm... are you fiddling with the clock for each request?

It's disabled when the request completion is called; so yes.


> > +	/* explicitly check for cmd->data (not host->data), because the
> > +	 * completed command could be the data->stop/mrq->stop cmd!
> > +	 */
> > +	if (!(cmd->data)) {
> > +		shmmc_done(host);
> > +	} else if ((host->data) && (host->data->flags & MMC_DATA_WRITE)) {
> > +		/* start write-data-engine */
> > +		MMC_OUTB(host, OPCR, OPCR_DATAEN);
> > +	} else {
> > +		/* data read op starts automatically. just enable CRC irqs */
> > +		host->ien1 |= INTCR1_CRCERIE;
> > +		MMC_OUTB(host, INTCR1, host->ien1);
> > +	}
> 
> This is probably wrong. Some data transfers are so short that they can
> end before the response is sent.

Could be, yes. However this has worked for almost 4 years now ;-)
Can the mmc_test driver generate a testcase where this situation occurs?


> > +static void shmmc_read_fifo(struct shmmc_host *host, size_t bytes)
> > +{
> > +	unsigned long flags;
> > +	unsigned short *sg_ptr;
> > +	size_t cnt;
> > +
> > +	host->xfered += bytes;
> > +	host->required -= bytes;
> > +
> > +	local_irq_save(flags);
> > +
> > +	while (bytes) {
> > +		if (!sg_miter_next(&host->sg_miter))
> > +			BUG();
> > +
> > +		cnt = min(host->sg_miter.length, bytes);
> > +
> > +		bytes -= cnt;
> > +		host->sg_miter.consumed = cnt;
> > +		sg_ptr = host->sg_miter.addr;
> > +
> > +		while (cnt > 1) {
> > +			*sg_ptr++ = be16_to_cpu(MMC_INW(host, DR));
> > +			cnt -= 2;
> 
> No alignment issues on this platform?

Of courese, but I've never encountered unaligned data buffers so far
(can't test SDIO because I don't have any hardware).  The MMC card
block driver works fine so far.  Also, falling back on byte-sized
reading roughly halves the transfer rate.

 
> > +static void shmmc_write_fifo(struct shmmc_host *host, size_t bytes)
> > +{
> > +	unsigned long flags;
> > +	unsigned short *sg_ptr;
> > +	size_t cnt;
> > +
> > +	host->xfered += bytes;
> 
> I hope this isn't written to bytes_xfered if a failure occurs as that
> would be _very_ bad.

So in case of error, the driver should return 0?


> > +
> > +	blksz_bits = ffs(data->blksz) - 1;
> > +
> > +	/* only power-of-two block sizes >=4 are allowed */
> > +	if (((1 << blksz_bits) != data->blksz) || (blksz_bits = 1))
> > +		return -EINVAL;
> > +
> 
> is_power_of_2() in linux/log2.h.

fixed.
 
> > +	/* multiblock WRITES are badly broken.  Setting max_blk_count
> > +	 * to 1 works around that but unfortunately it also reduces
> > +	 * read performance by about 60% on my test system.
> > +	 */
> 
> What's the issue?

While the card is the busy state, the controller continues to transfer
data to it, resulting in a CRC error.

Thanks for the review!
	Manuel Lauss

