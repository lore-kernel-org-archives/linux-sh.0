From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 24 Dec 2014 01:30:57 +0000
Subject: Re: [PATCH 1/7] mmc: tmio: add .enable_dma
Message-Id: <87lhlx7s0e.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egs1ve96.wl%kuninori.morimoto.gx@renesas.com>
	<87d27lve84.wl%kuninori.morimoto.gx@renesas.com>
	<CAPDyKFqg99xDJHbY0U5YisYKdXUtMYxSJ-3+g24gvgA8qZ7VTw@mail.gmail.com>
	<87mw6d7sk1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw6d7sk1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>


Hi Ulf, again

> > >  void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
> > > diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
> > > index 5738817..6788f9b 100644
> > > --- a/include/linux/mfd/tmio.h
> > > +++ b/include/linux/mfd/tmio.h
> > > @@ -111,6 +111,7 @@ void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
> > >  void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
> > >
> > >  struct dma_chan;
> > > +struct tmio_mmc_host;
> > >
> > >  struct tmio_mmc_dma {
> > >         void *chan_priv_tx;
> > > @@ -120,10 +121,9 @@ struct tmio_mmc_dma {
> > >         int alignment_shift;
> > >         dma_addr_t dma_rx_offset;
> > >         bool (*filter)(struct dma_chan *chan, void *arg);
> > > +       void (*enable)(struct tmio_mmc_host *host, bool enable);
> > 
> > Before we decide to add more callbacks to this struct, can we please
> > try to move the mmc specific parts into the mmc tmio specific header?
> > drivers/mmc/host/tmio_mmc.h.
> > 
> > For example the tmio_mmc_dma can be moved there.

Hmm....
tmio_mmc_dma is used from tmio_mmc_data.
And, tmio_mmc_data is used from drivers/mfd/xxx.c
It seems impossible to move it.
