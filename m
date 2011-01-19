From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 Jan 2011 03:14:40 +0000
Subject: Re: SDHC Read Performance
Message-Id: <AANLkTinNtL0v2cnhz7Ci+a8TqQTcQXBMVW5EkX8qujy+@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20110119000909.GA9412@verge.net.au>
In-Reply-To: <20110119000909.GA9412@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Simon Horman <horms@verge.net.au>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Arnd Hannemann <arnd@arndnet.de>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Hi Simon,

On Wed, Jan 19, 2011 at 9:09 AM, Simon Horman <horms@verge.net.au> wrote:
> Hi,
>
> I am currently interested in the read performance of the SDHI driver. =A0I
> ran the following tests on a Mackerel board using Linus's latest tree
> (6845a44a), which I believe has all of the outstanding patches from Arnd
> and Guennadi merged.

Nice, thanks for testing this.

> I have made the following crude performance measurements using
> several different cards.
>
> dd if=3D/dev/mmcblk1 of=3D/dev/null bsQ2 count=100000
>
> SD1.1: =A0 =A0 =A0 =A0 =A07.0 MB/s
> SD2.0: =A0 =A0 =A0 =A0 =A07.0 MB/s
> SDHC Class 2: =A0 7.1 MB/s
> SDHC Class 10: =A07.2 MB/s
>
> Whereas I would expect something like:
>
> SD1.1 card: =A0 =A0 12 MB/s
> SD2.0 card: =A0 =A0 24 MB/s
> SDHC Class 2: =A0 24 MB/s
> SDHC Class 10: =A0Faster?

Please have a look at the clock frequency set by the SDHI MFD driver
(hclk), together with the tmio-mmc settings in tmio_mmc_set_clock().
For the clock to be bumped up properly some capability/feature flags
may be needed:

MMC_CAP_MMC_HIGHSPEED
MMC_CAP_SD_HIGHSPEED

Not sure if they are set properly. Probably not.

> Possibly relevant portions of my .config are:
>
> CONFIG_MFD_SH_MOBILE_SDHI=3Dy
> CONFIG_TMIO_MMC_DMA=3Dy
> CONFIG_MMC_TMIO=3Dy

These two are also relevant:

CONFIG_SH_DMAE=3Dy
CONFIG_DMA_ENGINE=3Dy

DMA controller platform data is also needed, not sure the state of
your board. You can check out the counters in /proc/interrupts to see
if the DMA controller is active or not.

Cheers,

/ magnus
