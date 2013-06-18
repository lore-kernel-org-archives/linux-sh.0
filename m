From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 18 Jun 2013 13:30:59 +0000
Subject: Re: [PATCH v2 3/3] DMA: shdma: add DT support
Message-Id: <201306181531.00023.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de> <201306171748.11836.arnd@arndb.de> <Pine.LNX.4.64.1306180959190.30844@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1306180959190.30844@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Simon Horman <horms@verge.net.au>

On Tuesday 18 June 2013, Guennadi Liakhovetski wrote:
> Hi Arnd
> 
> On Mon, 17 Jun 2013, Arnd Bergmann wrote:
> 
> > On Thursday 06 June 2013, Guennadi Liakhovetski wrote:
> > > +Required properties:
> > > +- dmas:		a list of <[DMA controller phandle] [MID/RID value]> pairs
> > > +- dma-names:	a list of DMA channel names, one per "dmas" entry
> > 
> > Looks ok to me, although it might be helpful to clarify what MID/RID means,
> > by expanding the acronym and describing whether one needs to pass both
> > or just one of them. If both, what is the bit pattern?
> 
> One word: magic. MID/RID is what that value is called in the datasheet. 
> E.g. on APE6 (r8a73a4) it is indeed divided into 2 fields - 2 and 6 bits 
> for RID and MID respectively, I _guess_ 2 bits are to select a channel 
> within a slave device and 6 bits to pick up one of slaves, but that 
> doesn't fit with a slave with 8 channels (HSI), there are also slave 
> devices with different MID values, so, those values are really better 
> considered as a single magic value - an 8-bit channel request handle, 
> which is also how they are listed in a reference table.

Ok.

> > >   * services would have to provide their own filters, which first would check
> > >   * the device driver, similar to how other DMAC drivers, e.g., sa11x0-dma.c, do
> > >   * this, and only then, in case of a match, call this common filter.
> > > + * NOTE 2: This filter function is also used in the DT case by shdma_xlate().
> > > + * In that case the MID-RID value is used for slave channel filtering and is
> > > + * passed to this function in the "arg" parameter.
> > >   */
> > >  bool shdma_chan_filter(struct dma_chan *chan, void *arg)
> > >  {
> > >  	struct shdma_chan *schan = to_shdma_chan(chan);
> > >  	struct shdma_dev *sdev = to_shdma_dev(schan->dma_chan.device);
> > >  	const struct shdma_ops *ops = sdev->ops;
> > > -	int slave_id = (int)arg;
> > > +	int match = (int)arg;
> > >  	int ret;
> > >  
> > > -	if (slave_id < 0)
> > > +	if (match < 0)
> > >  		/* No slave requested - arbitrary channel */
> > >  		return true;
> > >  
> > > -	if (slave_id >= slave_num)
> > > +	if (!schan->dev->of_node && match >= slave_num)
> > >  		return false;
> > >  
> > > -	ret = ops->set_slave(schan, slave_id, true);
> > > +	ret = ops->set_slave(schan, match, true);
> > >  	if (ret < 0)
> > >  		return false;
> > 
> > This is complicated by the fact that you are using the same function for
> > two entirely different purposes. It would be easier to have a separate
> > filter for the DT case, rather than reusing the one that uses the slave_id
> > as an argument.
> 
> Hm, yes, I was considering either making 2 functions or reusing one, but 
> it's really the same code with only difference - the DT version wouldn't 
> have the "> slave_num" check. So, I decided to use a single function 
> renaming "slave_id" to a neutral "match." You really think it's become too 
> complex and should be copied for clarity?

I think it would be easier to understand if you have two functions, but
it's not very important. Especially if you make the new function specific
to shdma, that would be clearer.

> > > @@ -867,6 +883,29 @@ void shdma_chan_remove(struct shdma_chan *schan)
> > >  }
> > >  EXPORT_SYMBOL(shdma_chan_remove);
> > >  
> > > +struct dma_chan *shdma_xlate(struct of_phandle_args *dma_spec,
> > > +				 struct of_dma *ofdma)
> > > +{
> > > +	struct shdma_dev *sdev = ofdma->of_dma_data;
> > > +	u32 id = dma_spec->args[0];
> > > +	dma_cap_mask_t mask;
> > > +	struct dma_chan *chan;
> > > +
> > > +	if (dma_spec->args_count != 1 || !sdev)
> > > +		return NULL;
> > > +
> > > +	dma_cap_zero(mask);
> > > +	/* Only slave DMA channels can be allocated via DT */
> > > +	dma_cap_set(DMA_SLAVE, mask);
> > > +
> > > +	chan = dma_request_channel(mask, shdma_chan_filter, (void *)id);
> > > +	if (chan)
> > > +		to_shdma_chan(chan)->hw_req = id;
> > > +
> > > +	return chan;
> > > +}
> > > +EXPORT_SYMBOL(shdma_xlate);
> > 
> > I would suggest keeping this to the drivers/dma/sh/shdma.c file
> > and not exporting it. The sudma would use a different binding anyway.
> 
> Ok, can do that and then see, how different sudma's .xlate() function will 
> be. If it's the same we can make this common again.

I hope we can get rid of the need for calling dma_request_channel() from
xlate soon, since that is a bit silly anyway. Ideally you would just pick
the right channel of the dma_device (or the first free one, depending on
the driver) and return that from xlate.

> > The pdata and slave_id should really not be needed here for the lookup in the DT
> > case. Is this just temporary until all slave drivers use dmaenging_slave_config
> > to pass the address? That should be clarified in a comment.
> 
> Also with DT we still use platform data, passed to the driver using 
> auxdata. This function finds a suitable struct sh_dmae_slave_config 
> channel configuration entry in the platform data and returns it to the 
> caller. I don't think this can be avoided without carrying all the 
> platform data over to DT.

I think that should be done anyway. A lot of the data can just be hardcoded
in the driver based on the specific "compatible" value, e.g. the register offsets
of the individual channels.

The list of slaves that is currently passed in platform data should not be needed,
but I realize that moving the FIFO addresses into the drivers is work in progress.

	Arnd
