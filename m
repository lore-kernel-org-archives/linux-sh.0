From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 27 Jan 2010 07:27:14 +0000
Subject: Re: [PATCH] spi_sh_msiof: Fixed data sampling on the correct edge
Message-Id: <20100127072713.GH2739@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0171E8D4959B@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0171E8D4959B@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 27, 2010 at 04:23:36PM +0900, Magnus Damm wrote:
> On Thu, Jan 21, 2010 at 7:28 PM, Pietrek, Markus
> <Markus.Pietrek@emtrion.de> wrote:
> > I'm using spidev to communicate with a samsung oled display S6E63D6.
> > This display requires the mode SPI_CPHA and SPI_CPOL.
> >
> > Plain writing is fine with the old register setting (REDG=!TEDG). I
> > can configure the display. But when reading the chip identifier, the
> > last byte (of the identified 0x63D6) is never stored in the FIFO. I
> > always read 0x6363, so the FIFO returns the 2nd last byte as the last
> > byte.
> 
> Huh, is that so?
> 
> I tested this on my Ecovec sh7724 board with MMC-over-SPI and your
> patch does not break my setup...
> 
> > With a logical analyzer I can proof that the device is sending the
> > correct data. So it must be an issue of the sampling. And changing
> > REDG/TEDG to the values recommended in the SH7723 HW Reference Manual
> > fixed this issue.
> 
> .. and following the data sheet sounds like a good plan. Especially
> since it fixes your issue.
> 
> Can you please send a patch without the debug printouts to
> spi-devel-general and add my acked-by?
> 
> Acked-by: Magnus Damm <damm@opensource.se>
> 
This looks like something we should handle for 2.6.33 anyways, so Markus
when you resubmit this make sure to provide your Signed-off-by as well,
then I'll batch it up with the next round of updates, thanks.
