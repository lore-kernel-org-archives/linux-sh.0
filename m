From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 01 Sep 2020 15:36:17 +0000
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset
Message-Id: <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200901150438.228887-1-ulf.hansson@linaro.org> <20200901150654.GB30034@lst.de>
In-Reply-To: <20200901150654.GB30034@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rich Felker <dalias@libc.org>, Mark Brown <broonie@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 1 Sep 2020 at 17:06, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Sep 01, 2020 at 05:04:38PM +0200, Ulf Hansson wrote:
> > +#ifdef CONFIG_HAS_DMA
> > +static int mmc_spi_dma_alloc(struct mmc_spi_host *host)
> > +{
> > +     struct spi_device *spi = host->spi;
> > +     struct device *dev;
> > +
> > +     if (!spi->master->dev.parent->dma_mask)
> > +             return 0;
>
> I still don't think this makes sense, as the dma_mask should always
> be non-NULL here.

If that is the case, I wonder how the driver could even have worked without DMA.

Because in the existing code, host->dma_dev gets assigned to
spi->master->dev.parent->dma_mask - which seems to turn on the DMA
usage in the driver.

What am I missing?

Kind regards
Uffe
