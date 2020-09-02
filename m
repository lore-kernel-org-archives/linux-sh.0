From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 02 Sep 2020 08:31:47 +0000
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset
Message-Id: <CAPDyKFqDKUG3RC241hv535CLFGEQc4b-vv0e3bexzGkDSY82Jg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
 <20200901150654.GB30034@lst.de> <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
 <20200901154049.GA376@lst.de>
In-Reply-To: <20200901154049.GA376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>, Rich Felker <dalias@libc.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, 1 Sep 2020 at 17:40, Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > > I still don't think this makes sense, as the dma_mask should always
> > > be non-NULL here.
> >
> > If that is the case, I wonder how the driver could even have worked without DMA.
> >
> > Because in the existing code, host->dma_dev gets assigned to
> > spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> > usage in the driver.
> >
> > What am I missing?
>
> Do you know of other non-DMA users?  For SH nommu it probably worked

I don't know of other non-DMA users. As I said, I wish someone could
step in and take better care of mmc_spi - as I know it's being used a
lot.

> because SH nommu used to provide a DMA implementation that worked
> fine for streaming maps, but was completely broken for coherent
> allocation.  And this driver appears to only use the former.

Alright, so you are saying the DMA support may potentially never have
been optional to this driver. In any case, I can remove the check in
$subject patch, as it shouldn't matter.

Anyway, let's see what Rich thinks of this. I am curious to see if the
patch works on his SH boards - as I haven't been able to test it.

Kind regards
Uffe
