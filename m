From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Thu, 24 Jul 2008 04:53:16 +0000
Subject: Re: [PATCH] sh7760mmc: driver for SH7760 MMCIF interface.
Message-Id: <20080724045316.GA10338@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080721055030.GA15474@roarinelk.homelinux.net>
In-Reply-To: <20080721055030.GA15474@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Good Morning Pierre,

On Thu, Jul 24, 2008 at 01:24:23AM +0200, Pierre Ossman wrote:
> On Mon, 21 Jul 2008 07:50:31 +0200
> Manuel Lauss <mano@roarinelk.homelinux.net> wrote:
> 
> > 
> > Host driver for SH7760 on-chip MMCIF interface.
> > 
> > Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
> > ---
> 
> *snip*
> 
> > +static inline void
> > +shmmc_read_fifo(struct shmmc_host *host, unsigned long bytes)
> > +{
> > +	struct scatterlist *sg;
> > +	unsigned short *sg_ptr;
> > +	int sg_len, cnt;
> > +
> > +	host->xfered += bytes;
> > +	host->required -= bytes;
> > +
> > +	while (bytes) {
> > +		sg = &host->data->sg[host->sg_idx];
> > +		sg_ptr = sg_virt(sg) + host->sg_ofs;
> > +		sg_len = sg->length - host->sg_ofs;
> > +
> 
> This will not work with the modern chained sg lists. I suggest you have
> a look at the sg list iterator helper that just got merged into Linus'
> tree. The sdhci driver uses it for its PIO routines.

Will do.

 
> > +static inline void
> > +shmmc_write_fifo(struct shmmc_host *host, unsigned long bytes)
> > +{
> 
> Same thing here.
> 
> Btw, 'static' is generally sufficient. gcc will inline those when
> efficient (e.g. when there's just one caller).
> 
> > +
> > +	if (0 = shmmc_card_inserted(mmc)) {
> 
> This reversal style is generally frowned upon in kernel code.

Okay,

 
> > +static void shmmc_enable_sdio_irq(struct mmc_host *mmc, int en)
> > +{
> > +	struct shmmc_host *host = mmc_priv(mmc);
> > +
> > +	if (host->platdata && host->platdata->enable_sdio_irq)
> > +		host->platdata->enable_sdio_irq(mmc, en);
> > +}
> 
> This is a problem. The core assumes that this will always succeed. I
> guess we need a return code for this and a fallback to the polling
> method if it fails.

SDIO capability is only announced when platdata->enable_sdio_irq is not
NULL, so this should be safe (unless MMC core only checks whether
mmc_ops.enable_sdio_irq != NULL to determine SDIO caps?).
I'm going to remove the check and stick a comment on top of it.
 
Thanks Pierre!
	Manuel Lauss
