From: Vinod Koul <vinod.koul@intel.com>
Date: Thu, 11 Dec 2014 05:17:50 +0000
Subject: Re: [PATCH 2/2 v2] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <20141211050550.GK16827@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vblknmw3.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 10, 2014 at 07:05:27AM +0000, Kuninori Morimoto wrote:
> 
> Hi Vinod
> 
> Thank you for youre review
> Basically, this DMAC is very simple device,
> it needs very few settings only.
> 
> > > From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > > +static struct dma_async_tx_descriptor *
> > > +audmapp_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> > > +			size_t buf_len, size_t period_len,
> > > +			enum dma_transfer_direction dir, unsigned long flags)
> > > +{
> > > +	struct audmapp_chan *achan = chan_to_achan(chan);
> > > +
> > > +	return &achan->async_tx;
> > > +}
> > I had commented last time as well. This doesnt look right. You are ignoring
> > all input parameters, so how does it work at all?
> 
> When we set simple settings to DMAC, then, it works automatically as cyclic transfer.
> The usage of this DMA is very limited, so it is super simple.
> In addition, this is 2nd DMA which is needed on sound.
>  1st DMA is controled by rcar-dmac.c
>  2nd DMA is this
> almost all settings are set by 1st DMA, 2nd DMA is just relay.
okay that needs to be called out explcitly. While reading driver it wasn't
very clear
So which one is the 1st DMA, how will the client configure these two DMAs?

-- 
~Vinod

