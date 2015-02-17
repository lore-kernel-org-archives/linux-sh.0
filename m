From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Tue, 17 Feb 2015 18:20:36 +0000
Subject: Re: [PATCH 0/3 v3][RFC] dmaengine: rcar-audmapp: calculate chcr via src/dst addr
Message-Id: <20150217182035.GA3888@Asurada>
List-Id: <linux-sh.vger.kernel.org>
References: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mw4xey70.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 17, 2015 at 03:09:41PM +0100, Arnd Bergmann wrote:
> I've thought some more about what it would really mean to support
> DMA_DEV_TO_DEV with the existing framework and binding. I believe
> we can actually do this with the existing DT binding if we really
> wanted to, but the dmaengine code would have to change. At the
> moment, we have 
> 
> struct dma_chan *dma_request_slave_channel_reason(struct device *dev,
>                                                   const char *name);
> 
> as the main interface. What I think we would need is a respective
> interface that takes two separate names for source and sink, like
> 
> struct dma_chan *dma_request_dev_to_dev_channel(struct device *dev,
>                                                 const char *source,
> 						 const char *sink);
> 
> Then you'd list all available sources and all sinks separately
> in the device node for the audio device and combine the ones you
> need.
> 
> Making this particular device specific to the audio driver is
> still much easier, I just wanted to ensure we document it here
> in case we need the same functionality later for something else.
> 
> There seems to be some weird workaround for a related problem
> in sound/soc/fsl/fsl_asrc_dma.c, which tries to get two channels
> individually, and then puts them into a private datas structre
> and filter function to get a third channel that is actually being
> used.

The fsl_asrc_dma was implemented upon ASoC DPCM -- it's using ASRC
(it has 3 pairs) as the Front-end and one of possible Back-ends
(several I2S controllers or a SPDIF controller). So its DMA channel
of the Front-end is based on which ASRC pair the ASRC driver assigns
while the Back-end is totally according to which Back-end controller
the DAI link is using. It means the driver has to dynamically fetch
them at runtime and overwrite the configurations in order to request
corresponding DMA channels on the fly.

Generic DMA engine looks more perfect to deal with static channel
assignments: even the dma_request_dev_to_dev_channel() above is also
seemly a bit tough to apply to ASRC's case unless we list all the
possible Back-ends in the DT and select one of names of Back-ends
based on the controller being used at runtime, although listing all
the Back-ends doesn't sound too much unreasonable.

Best regards,
Nicolin
