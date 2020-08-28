From: Rich Felker <dalias@libc.org>
Date: Fri, 28 Aug 2020 15:09:43 +0000
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-Id: <20200828150942.GV3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <20200714121856.955680-10-hch@lst.de>
 <20200828020045.GT3265@brightrain.aerifal.cx>
 <20200828021152.GU3265@brightrain.aerifal.cx>
 <20200828042422.GA29734@lst.de>
 <CAPDyKFrKJrUN8mJ94g0+0Vs3aT1uq9MmHWfvzcVaoA5efaYPmQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrKJrUN8mJ94g0+0Vs3aT1uq9MmHWfvzcVaoA5efaYPmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-spi@vger.kernel.org

On Fri, Aug 28, 2020 at 11:26:57AM +0200, Ulf Hansson wrote:
> On Fri, 28 Aug 2020 at 06:24, Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Aug 27, 2020 at 10:11:53PM -0400, Rich Felker wrote:
> > > > This change broke SD card support on J2 because MMC_SPI spuriously
> > > > depends on HAS_DMA. It looks like it can be fixed just by removing
> > > > that dependency from drivers/mmc/host/Kconfig.
> > >
> > > It can't. mmp_spi_probe fails with ENOMEM, probably due to trying to
> > > do some DMA setup thing that's not going to be needed if the
> > > underlying SPI device doesn't support/use DMA.
> >
> > Adding the linux-mmc and linux-spi lists, as that seems pretty odd.
> 
> The mmc_spi driver needs modernizations, so I am not surprised to see
> odd things.
> 
> My guess is that in ->probe() we check "if
> (spi->master->dev.parent->dma_mask)" - > and runs dma_map*()
> operations, which fails and leads to bailing out of ->probe() to
> return an error code.
> 
> However, by looking at the code, one get the feeling that the DMA
> support is somewhat prepared to be made optional. I guess it has never
> been really tested, as the Kconfig option has "depends on HAS_DMA"  -
> and it's been like that as long as I can remember.

It always worked on our "byte-banged" SPI controller, with no DMA
controller present, before Christoph's changes in this patch series,
and seems to be working now (although I have some other, hopefully
unrelated regressions to debug) with #ifdef CONFIG_HAS_DMA around the
if (spi->master->dev.parent->dma_mask) block in mmc_spi_probe. That's
probably not the right fix though -- why isn't it checking
host->dma_dev instead and only attempting DMA setup if dma_dev is
non-null?

Rich
