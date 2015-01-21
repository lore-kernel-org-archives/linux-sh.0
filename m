From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Jan 2015 14:19:48 +0000
Subject: Re: [PATCH 1/6 v5] dmaengine: rcar-audmapp: independent from SH_DMAE_BASE v1
Message-Id: <2195960.ext3DPnloV@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wq4ib4xw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday 21 January 2015 01:25:51 Kuninori Morimoto wrote:
> Hi Arnd, Laurent
> 
> Laurent, can you please correct my comment if it was wrong/un-understandable ?
> 
> > > Current Renesas Audio DMAC Peri Peri driver is based on
> > > SH_DMAE_BASE driver which is used for Renesas SH-Mobile.
> > > But, basically, SH_DMAE_BASE driver was created for
> > > SuperH SoC, and it is not fully cared for DT.
> > > 
> > > For example, current SH_DMAE_BASE base driver will return
> > > non-matching DMA channel if some non-SH_DMAE_BASE drivers
> > > are probed.
> > > So, sound driver will get wrong DMA channel
> > > if Audio DMAC (= rcar-dma) was not probed,
> > > but Audio DMAC Peri Peri (= SH_DMAE_BASE) was probed.
> > > 
> > > OTOH, many SH-Mobile series drivers are using SH_DMAE_BASE
> > > driver, and Renesas R-Car series will not use it anymore.
> > > Maintenance cost for fully cared DT support on SH_DMAE_BASE
> > > will be very high
> > > (and keeping compatibility will be very complex).
> > > 
> > > In addition, Audio DMAC Peri Peri itself is very simple device,
> > > and, no SoC/board is using it from non-DT environment.
> > > 
> > > This patch simply removes current rcar-audmapp driver.
> > > 
> > 
> > I'm confused by the description above. From what I understand,
> > the purpose of the SH_DMAE_BASE driver is to multiplex between
> > the DMA engines that all share the same slaves on some of the
> > shmobile/r-mobile/r-car chips. If the audma driver does not
> > share its slaves with another dmaengine, it needs to register
> > its own of_dma_controller, which it does.
> >
> > The problem you describe with getting the wrong channel seems
> > to me that the shdma_chan_filter() function matches any DMA
> > engine that was registered through shdma_init(), because its
> > device_alloc_chan_resources function pointer matches. This problem
> > could be avoided by adding some flag in shdma_dev as a bug-fix
> > (also for backports to stable kernels).
> > 
> > That said, together with patch 2, this seems like a useful
> > simplification, it just needs a better description in my mind.
> 
> Historically we used SH_DMAE_BASE driver for DMAEngine when
> SH-Mobile series. and now we have new R-Car series.
> 
> R-Car series DMAC <-> SH-Mbile series DMAC are similar, but
> R-Car series DMAC has more advanced feature.
> Then, adding new feature on SH_DMAE_BASE seems difficult (for many reasons)
> So, we decided that R-Car series uses Laurent's rcar-dmac driver
> (which is not SH_DMAE_BASE driver, so it doesn't use shdma_init)
> instead of SH_DMAE_BASE driver.
> But, because of timing reason, this audmapp which is used
> from R-Car series was created as SH_DMAE_BASE driver.

My point was that the question whether to use SH_DMAE_BASE or
not should not depend on whether it is easy to do, but whether
it is *necessary*. We should not use it for drivers that do
not depend on the multiplexing, but we have to use it for the
ones that do.

By multiplexing, I mean drivers that specifically share a
common sh_dmae_slave_config array across multiple DMA engine
instances.

> SH_DMAE_BASE driver is mainly used from non-DT platform
> (it is supporting DT, but difficult to fixup/understand today)
> rcar-dmac is mainly used from DT platform.
> 
> Yes, SH_DMAE_BASE filter matches any DMAEngine,
> but, it matches not only shdma_init base driver,
> but matches with rcar-dmac.

How? shdma_chan_filter has this code

        /* Only support channels handled by this driver. */
        if (chan->device->device_alloc_chan_resources !            shdma_alloc_chan_resources)
                return false;

and that is only used by shdma_init(), which is called from
shdmac.c, sudmac.c, rcar-audmapp.c and rcar-hpbdma.c, but not
rcar-dmac.c

> From compatibility/complexity from point of view,
> "audmapp independent from SH_DMAE_BASE" is easier than
> "fixup SH_DMAE_BASE for DT".
> Because no other R-Car SoC DMAC uses SH_DMAE_BASE driver

Wouldn't this be enough to fix the bug (short term and for
backports, not in the long run)?

diff --git a/drivers/dma/sh/rcar-hpbdma.c b/drivers/dma/sh/rcar-hpbdma.c
index 6fef1b95c895..7a65740da3bd 100644
--- a/drivers/dma/sh/rcar-hpbdma.c
+++ b/drivers/dma/sh/rcar-hpbdma.c
@@ -604,6 +604,7 @@ static int hpb_dmae_probe(struct platform_device *pdev)
 
 	hpbdev->shdma_dev.ops = &hpb_dmae_ops;
 	hpbdev->shdma_dev.desc_size = sizeof(struct hpb_desc);
+	hpbdev->shdma_dev.multiplexed = true;
 	err = shdma_init(&pdev->dev, &hpbdev->shdma_dev, pdata->num_channels);
 	if (err < 0)
 		goto error;
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 8ee383d339a5..6b04312394d3 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -284,6 +284,9 @@ bool shdma_chan_filter(struct dma_chan *chan, void *arg)
 	    shdma_alloc_chan_resources)
 		return false;
 
+	if (!sdev->multiplexed)
+		return false;
+
 	if (match < 0)
 		/* No slave requested - arbitrary channel */
 		return true;
diff --git a/drivers/dma/sh/shdma.h b/drivers/dma/sh/shdma.h
index 2c0a969adc9f..ef0112e19b0e 100644
--- a/drivers/dma/sh/shdma.h
+++ b/drivers/dma/sh/shdma.h
@@ -43,6 +43,7 @@ struct sh_dmae_device {
 	void __iomem *dmars;
 	unsigned int chcr_offset;
 	u32 chcr_ie_bit;
+	bool multiplexed;
 };
 
 struct sh_dmae_regs {
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index aec8a84784a4..f9b38f165885 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -756,6 +756,7 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 	shdev->shdma_dev.ops = &sh_dmae_shdma_ops;
 	shdev->shdma_dev.desc_size = sizeof(struct sh_dmae_desc);
+	shdev->shdma_dev.multiplexed = true;
 	err = shdma_init(&pdev->dev, &shdev->shdma_dev,
 			      pdata->channel_num);
 	if (err < 0)


On a related topic, it seems you are very close to removing the
legacy sh_dmae_slave_config/hpb_dmae_slave_config arrays, the
only drivers that still rely on them are sound/soc/sh/siu_pcm.c,
drivers/usb/renesas_usbhs/fifo.c and drivers/tty/serial/sh-sci.c.
After those are converted to use dma_slave_config() and the normal
filter functions, a lot of obsolete code and data could just
go away.

	Arnd
