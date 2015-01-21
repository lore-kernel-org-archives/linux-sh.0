From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 21 Jan 2015 00:56:01 +0000
Subject: Re: [PATCH 2/6 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v2
Message-Id: <87oaptne7c.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87vbk2b4x4.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87vbk2b4x4.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Arnd

> > +static bool audmapp_chan_filter(struct dma_chan *chan, void *arg)
> > +{
> > +       struct dma_device *dma = chan->device;
> > +       struct of_phandle_args *dma_spec = arg;
> > +
> > +       /*
> > +        * FIXME: Using a filter on OF platforms is a nonsense. The OF xlate
> > +        * function knows from which device it wants to allocate a channel from,
> > +        * and would be perfectly capable of selecting the channel it wants.
> > +        * Forcing it to call dma_request_channel() and iterate through all
> > +        * channels from all controllers is just pointless.
> > +        */
> > +       if (dma->device_config != audmapp_device_config ||
> > +           dma_spec->np != dma->dev->of_node)
> > +               return false;
> > +
> > 
> 
> I think the above means you can have a trivial xlate function instead, like
> 
> static struct dma_chan *audmapp_of_xlate(struct of_phandle_args *dma_spec,
> +                                        struct of_dma *ofdma)
> +{
> +       struct audmapp_chan *achan;
> +       struct dma_chan *chan;
> +
> +       if (dma_spec->args_count != 1)
> +               return NULL;
> +
> +       chan = dma_get_any_slave_channel(of_dma->of_dma_data);
> +       if (!chan)
> +               return NULL;
> +
> +       achan = chan_to_achan(chan);
> +       achan->chcr = dma_spec->args[0] << 16;
> +
> +       return chan;
> +}

Thank you. I didn't know this method

Best regards
---
Kuninori Morimoto
