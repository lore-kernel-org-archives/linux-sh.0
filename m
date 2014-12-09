From: Vinod Koul <vinod.koul@intel.com>
Date: Tue, 09 Dec 2014 06:20:34 +0000
Subject: Re: [PATCH][resend] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE
Message-Id: <20141209060834.GW16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvd4b2kh.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvd4b2kh.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 08, 2014 at 08:32:16PM +0200, Laurent Pinchart wrote:
> Hi Vinod,
> 
> On Monday 08 December 2014 18:15:25 Vinod Koul wrote:
> > On Fri, Nov 28, 2014 at 12:17:59AM +0000, Kuninori Morimoto wrote:
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > 
> > > Current Renesas Audio DMAC Peri Peri driver is for Renesas R-Car series,
> > > but it is based on SH_DMAE_BASE driver which is used for Renesas
> > > SH-Mobile. But it is not fully cared about DT.
> > > 
> > > For example, current SH_DMAE_BASE base driver will return non-matching
> > > DMA channel if some non-SH_DMAE_BASE drivers are probed.
> > > So, sound driver will get wrong DMA channel if Audio DMAC (= rcar-dma)
> > > was not probed and Audio DMAC Peri Peri (= SH_DMAE_BASE) was probed.
> > > 
> > > OTOH, many SH-Mobile series drivers are using SH_DMAE_BASE driver, and
> > > Renesas R-Car series will not use it anymore. Maintenance cost for fully
> > > cared DT support on SH_DMAE_BASE will be very high
> > > (and keeping compatibility will be very complex).
> > > 
> > > In addition, Audio DMAC Peri Peri itself is very simple device, and,
> > > no SoC/board is usign it from non-DT environment.
> > > 
> > > This patch remakes rcar-audmapp driver simply independents
> > > from SH_DMAE_BASE.
> > 
> > Hi Kuninori
> > 
> > Can you please split these changes into multiple smaller changes so that we
> > can review this propely...
Since this seems to be complet rewrite then remove old and add new driver
would be easier too

> > > +static struct dma_async_tx_descriptor *
> > > +audmapp_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> > > +			size_t buf_len, size_t period_len,
> > > +			enum dma_transfer_direction dir, unsigned long flags)
> > >  {
> > > -	struct audmapp_chan *auchan = to_chan(schan);
> > > -	u32 chcr;
> > > -	dma_addr_t dst;
> > > -	int ret;
> > > -
> > > -	ret = audmapp_get_config(auchan, slave_id, &chcr, &dst);
> > > -	if (ret < 0)
> > > -		return ret;
> > > -
> > > -	if (try)
> > > -		return 0;
> > > -
> > > -	auchan->chcr		= chcr;
> > > -	auchan->slave_addr	= slave_addr ? : dst;
> > > +	struct audmapp_chan *achan = chan_to_achan(chan);
> > > 
> > > -	return 0;
> > > +	return &achan->async_tx;
> > 
> > That doesn't look right to me. So for prepare you are returning descriptor
> > but not really preparing one, did I miss something here
This need to be fixed anyway in this driver

-- 
~Vinod
