From: Christoph Hellwig <hch@lst.de>
Date: Sat, 29 Aug 2020 08:31:21 +0000
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-Id: <20200829083121.GA7851@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de> <20200714121856.955680-10-hch@lst.de> <20200828020045.GT3265@brightrain.aerifal.cx> <20200828021152.GU3265@brightrain.aerifal.cx> <20200828042422.GA29734@lst.de> <CAPDyKFrKJrUN8mJ94g0+0Vs3aT1uq9MmHWfvzcVaoA5efaYPmQ@mail.gmail.com> <20200828150942.GV3265@brightrain.aerifal.cx>
In-Reply-To: <20200828150942.GV3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-spi@vger.kernel.org

On Fri, Aug 28, 2020 at 11:09:43AM -0400, Rich Felker wrote:
> > However, by looking at the code, one get the feeling that the DMA
> > support is somewhat prepared to be made optional. I guess it has never
> > been really tested, as the Kconfig option has "depends on HAS_DMA"  -
> > and it's been like that as long as I can remember.
> 
> It always worked on our "byte-banged" SPI controller, with no DMA
> controller present, before Christoph's changes in this patch series,

Before that nommu sh builds provided a DMA mapping implementation
that even worked for the streaming side (dma_map_*), but would corrupt
data if you used dma_alloc_coherent memory to communicate with the
device. 

> and seems to be working now (although I have some other, hopefully
> unrelated regressions to debug) with #ifdef CONFIG_HAS_DMA around the
> if (spi->master->dev.parent->dma_mask) block in mmc_spi_probe. That's
> probably not the right fix though -- why isn't it checking
> host->dma_dev instead and only attempting DMA setup if dma_dev is
> non-null?

I don't think dma_dev can be NULL right now.  dma_dev is assigned here:

	if (spi->master->dev.parent->dma_mask) {
		struct device   *dev = spi->master->dev.parent;

		host->dma_dev = dev;

but for any OF or real bus device dma_mask never is zero (it actually is
a pointer), and the value of it also is initialized to 32-bit by default,
making this effectively an "if (1) {".  The driver needs some way to
communicate if a given device actually is DMA capable or not. Or is that
purely a factor of the platform which would be a little strange.

In which case we should do something like:


diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 39bb1e30c2d722..3b0cc9a70e6432 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1374,7 +1374,7 @@ static int mmc_spi_probe(struct spi_device *spi)
 	if (!host->data)
 		goto fail_nobuf1;
 
-	if (spi->master->dev.parent->dma_mask) {
+	if (IS_ENABLED(CONFIG_HAS_DMA)) {
 		struct device	*dev = spi->master->dev.parent;
 
 		host->dma_dev = dev;
