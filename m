From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 03 Sep 2020 08:10:30 +0000
Subject: Re: [PATCH v2] mmc: mmc_spi: Allow the driver to be built when CONFIG_HAS_DMA is unset
Message-Id: <CAPDyKFongKHXianvz0T7spcV8jHff_usagO1xM9-60ya=KW6zg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200901150438.228887-1-ulf.hansson@linaro.org>
 <20200901150654.GB30034@lst.de> <CAPDyKFqZXdtVokrDQvJAh-NzN0T2ayPD6MepemLEaDt1TRPduw@mail.gmail.com>
 <20200901154049.GA376@lst.de> <CAPDyKFqDKUG3RC241hv535CLFGEQc4b-vv0e3bexzGkDSY82Jg@mail.gmail.com>
 <20200902134418.GR3265@brightrain.aerifal.cx> <CAMuHMdUiPhHtkQfcpMSA6HMvmcFyg__rSGUoHRKQfQf2N5QTYA@mail.gmail.com>
 <20200903004135.GT3265@brightrain.aerifal.cx>
In-Reply-To: <20200903004135.GT3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, 3 Sep 2020 at 02:41, Rich Felker <dalias@libc.org> wrote:
>
> On Wed, Sep 02, 2020 at 05:51:16PM +0200, Geert Uytterhoeven wrote:
> > Hi Rich,
> >
> > On Wed, Sep 2, 2020 at 5:43 PM Rich Felker <dalias@libc.org> wrote:
> > > On Wed, Sep 02, 2020 at 10:31:47AM +0200, Ulf Hansson wrote:
> > > > On Tue, 1 Sep 2020 at 17:40, Christoph Hellwig <hch@lst.de> wrote:
> > > > > On Tue, Sep 01, 2020 at 05:36:17PM +0200, Ulf Hansson wrote:
> > > > > > > I still don't think this makes sense, as the dma_mask should always
> > > > > > > be non-NULL here.
> > > > > >
> > > > > > If that is the case, I wonder how the driver could even have worked without DMA.
> > > > > >
> > > > > > Because in the existing code, host->dma_dev gets assigned to
> > > > > > spi->master->dev.parent->dma_mask - which seems to turn on the DMA
> > > > > > usage in the driver.
> > > > > >
> > > > > > What am I missing?
> > > > >
> > > > > Do you know of other non-DMA users?  For SH nommu it probably worked
> > > >
> > > > I don't know of other non-DMA users. As I said, I wish someone could
> > > > step in and take better care of mmc_spi - as I know it's being used a
> > > > lot.
> > > >
> > > > > because SH nommu used to provide a DMA implementation that worked
> > > > > fine for streaming maps, but was completely broken for coherent
> > > > > allocation.  And this driver appears to only use the former.
> > > >
> > > > Alright, so you are saying the DMA support may potentially never have
> > > > been optional to this driver. In any case, I can remove the check in
> > > > $subject patch, as it shouldn't matter.
> > >
> > > DMA support was always optional, because even on systems where DMA is
> > > present, it doesn't necessarily mean the SPI controller uses DMA. In
> > > particular, pure bit-banged SPI via GPIOs doesn't have DMA, but has
> > > always worked. See my previous reply to Christoph about host->dma_dev
> > > for my current-best understanding of what's going on here.
> > >
> > > > Anyway, let's see what Rich thinks of this. I am curious to see if the
> > > > patch works on his SH boards - as I haven't been able to test it.
> > >
> > > I'll rebuild and retest just to confirm, but I already tested a
> > > functionally equivalent patch that just did the #ifdef inline (rather
> > > than moving the logic out to separate functions) and it worked fine.
> >
> > Hence, Tested-by? ;-)
>
> Confirmed that this version of the patch works too. Thus,
>
> Tested-by: Rich Felker <dalias@libc.org>

I have applied the patch for fixes, thanks for testing!

Christoph, when it comes to the check of
"spi->master->dev.parent->dma_mask", I am keeping it for now. I am
simply not sure that all spi masters assign the pointer (even if most
are platform drivers). I think it's better that we remove that check
in a separate patch - to get it tested.

Kind regards
Uffe
