From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Jan 2011 03:30:21 +0000
Subject: Re: SDHC Read Performance
Message-Id: <20110120033020.GA32120@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110119000909.GA9412@verge.net.au>
 <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
 <20110119080542.GE1960@verge.net.au>
In-Reply-To: <20110119080542.GE1960@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Wed, Jan 19, 2011 at 05:05:49PM +0900, Simon Horman wrote:
> On Wed, Jan 19, 2011 at 12:14:40PM +0900, Magnus Damm wrote:
> > Hi Simon,
> > 
> > On Wed, Jan 19, 2011 at 9:09 AM, Simon Horman <horms@verge.net.au> wrote:
> > > Hi,
> > >
> > > I am currently interested in the read performance of the SDHI driver.  I
> > > ran the following tests on a Mackerel board using Linus's latest tree
> > > (6845a44a), which I believe has all of the outstanding patches from Arnd
> > > and Guennadi merged.
> > 
> > Nice, thanks for testing this.
> > 
> > > I have made the following crude performance measurements using
> > > several different cards.
> > >
> > > dd if=/dev/mmcblk1 of=/dev/null bsQ2 count0000
> > >
> > > SD1.1:          7.0 MB/s
> > > SD2.0:          7.0 MB/s
> > > SDHC Class 2:   7.1 MB/s
> > > SDHC Class 10:  7.2 MB/s
> > >
> > > Whereas I would expect something like:
> > >
> > > SD1.1 card:     12 MB/s
> > > SD2.0 card:     24 MB/s
> > > SDHC Class 2:   24 MB/s
> > > SDHC Class 10:  Faster?
> > 
> > Please have a look at the clock frequency set by the SDHI MFD driver
> > (hclk), together with the tmio-mmc settings in tmio_mmc_set_clock().
> > For the clock to be bumped up properly some capability/feature flags
> > may be needed:
> > 
> > MMC_CAP_MMC_HIGHSPEED
> > MMC_CAP_SD_HIGHSPEED
> > 
> > Not sure if they are set properly. Probably not.
> 
> Actually this is one thing that I did check, sorry for not mentioning it.
> The clock does seem to be set correctly, to 50Mhz for the high-speed case,
> which iirc is everything except SD1.1.
> 
> > > Possibly relevant portions of my .config are:
> > >
> > > CONFIG_MFD_SH_MOBILE_SDHI=y
> > > CONFIG_TMIO_MMC_DMA=y
> > > CONFIG_MMC_TMIO=y
> > 
> > These two are also relevant:
> > 
> > CONFIG_SH_DMAE=y
> > CONFIG_DMA_ENGINE=y
> > 
> > DMA controller platform data is also needed, not sure the state of
> > your board. You can check out the counters in /proc/interrupts to see
> > if the DMA controller is active or not.
> {
> Thanks!
> 
> I have CONFIG_DMA_ENGINE but not CONFIG_SH_DMAE.

I ran my tests again with CONFIG_SH_DMAE (and CONFIG_DMA_ENGINE)
enabled and the results are substantially better. Although
the results are still below the theoretical speeds of the cards.

Read Speed - SHDI
SD1.1:		 9.9 MB/s
SD2.0:		17.2 MB/s
SDHC Class 2:	17.0 MB/s
SDHC Class 10:	17.2 MB/s
MMC4.0:		 8.6 MB/s   <-- Clocked down to 12Mhz due to driver limitations

I also tested the Write Speed
SD1.1:		 2.4 MB/s   <-- Faster than expected
SD2.0:		 2.8 MB/s   <-- Faster than expected
SDHC Class 2:	 2.5 MB/s   <-- Faster than expected
SDHC Class 10:	 3.8 MB/s   <-- Slower than expected
MMC4.0:		 2.1 MB/s   <-- Clocked down to 12Mhz due to driver limitations

For reference I obtained the following results on my laptop,
which according to dmesg has a SAMSUNG MMCRE28G VBM1 PQ.

Read
SD1.1:		10.0 MB/s
SD2.0:		19.2 MB/s
SDHC Class 2:	19.4 MB/s
SDHC Class10:	17.9 MB/s  <---- What!!!?
MMC4.0:		 8.2 MB/s

Write
SD1.1:		 2.7 MB/s
SD2.0:		 3.4 MB/s
SDHC Class 2:	 3.1 MB/s
SDHC Class10:	 3.8 MB/s  <---- What!!!?
MMC4.0:		 2.0 MB/s
