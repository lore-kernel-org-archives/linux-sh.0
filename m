From: Christoph Hellwig <hch@lst.de>
Date: Tue, 01 Sep 2020 15:40:49 +0000
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset
Message-Id: <20200901154049.GA376@lst.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20200901150438.228887-1-ulf.hansson@linaro.org> <20200901150654.GB30034@lst.de> <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
In-Reply-To: <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Christoph Hellwig <hch@lst.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Rich Felker <dalias@libc.org>, Mark Brown <broonie@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > I still don't think this makes sense, as the dma_mask should always
> > be non-NULL here.
> 
> If that is the case, I wonder how the driver could even have worked without DMA.
> 
> Because in the existing code, host->dma_dev gets assigned to
> spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> usage in the driver.
> 
> What am I missing?

Do you know of other non-DMA users?  For SH nommu it probably worked
because SH nommu used to provide a DMA implementation that worked
fine for streaming maps, but was completely broken for coherent
allocation.  And this driver appears to only use the former.
