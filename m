From: Rich Felker <dalias@libc.org>
Date: Fri, 28 Aug 2020 02:11:53 +0000
Subject: Re: [PATCH 09/10] sh: don't allow non-coherent DMA for NOMMU
Message-Id: <20200828021152.GU3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200714121856.955680-1-hch@lst.de>
 <20200714121856.955680-10-hch@lst.de>
 <20200828020045.GT3265@brightrain.aerifal.cx>
In-Reply-To: <20200828020045.GT3265@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:00:48PM -0400, Rich Felker wrote:
> On Tue, Jul 14, 2020 at 02:18:55PM +0200, Christoph Hellwig wrote:
> > The code handling non-coherent DMA depends on being able to remap code
> > as non-cached.  But that can't be done without an MMU, so using this
> > option on NOMMU builds is broken.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/sh/Kconfig | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> > index f8027eee08edae..337eb496c45a0a 100644
> > --- a/arch/sh/Kconfig
> > +++ b/arch/sh/Kconfig
> > @@ -61,6 +61,7 @@ config SUPERH
> >  	select MAY_HAVE_SPARSE_IRQ
> >  	select MODULES_USE_ELF_RELA
> >  	select NEED_SG_DMA_LENGTH
> > +	select NO_DMA if !MMU && !DMA_COHERENT
> >  	select NO_GENERIC_PCI_IOPORT_MAP if PCI
> >  	select OLD_SIGACTION
> >  	select OLD_SIGSUSPEND
> > @@ -135,7 +136,7 @@ config DMA_COHERENT
> >  	bool
> 
> This change broke SD card support on J2 because MMC_SPI spuriously
> depends on HAS_DMA. It looks like it can be fixed just by removing
> that dependency from drivers/mmc/host/Kconfig.

It can't. mmp_spi_probe fails with ENOMEM, probably due to trying to
do some DMA setup thing that's not going to be needed if the
underlying SPI device doesn't support/use DMA.

Rich
