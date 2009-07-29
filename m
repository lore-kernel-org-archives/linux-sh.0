From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 29 Jul 2009 20:46:24 +0000
Subject: Re: [PATCH] SH: Switch Migo-R to use the tmio MMC driver instead of SPI
Message-Id: <20090729204623.GA28753@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.0907280951220.4943@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.0907280951220.4943@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 29, 2009 at 01:41:04PM -0700, Andrew Morton wrote:
> On Tue, 28 Jul 2009 10:06:49 +0200 (CEST)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > Allow tmio_mmc driver to be used on SuperH systems and add platform bindngs to
> > the SH7722 Migo-R platform.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > ---
> > 
> > Depends on my previous two patches for tmio_mmc:
> > 
> > http://marc.info/?l=linux-kernel&m4876748530957&w=2
> > http://marc.info/?l=linux-kernel&m4782904228865&w=2
> 
> I was hoping that the great bunfight over those two patches would
> resolve itself, seems not.
> 
> The second patch
> (tmio_mmc-optionally-support-using-platform-clock.patch) has some
> review comments from Phillip Zabel which appear to not have been
> responded to.
> 
> If you have interdependent patches, please do if at all possible send
> them as a single sequence-numbered series rather than as a random patch
> sprinkle like this.  It simplifies review and reduces the chance of
> mistakes.
> 
Yes, Phillip's comments should be addressed in the next version. That at
least addresses the clock framework misuse issue of passing in the clock
string anyways.

> >  arch/sh/boards/mach-migor/setup.c |   48 ++++++++++++++++++++++++++++++-------
> >  drivers/mmc/host/Kconfig          |    4 +-
> 
> If we decide to merge these three patches:
> 
> mmc-make-the-configuration-memory-resource-optional.patch
> tmio_mmc-optionally-support-using-platform-clock.patch
> sh-switch-migo-r-to-use-the-tmio-mmc-driver-instead-of-spi.patch
> 
> then it would be simplest if
> sh-switch-migo-r-to-use-the-tmio-mmc-driver-instead-of-spi.patch were
> to me merged at the same time as the other two.  Paul, is that OK with you?

Yes, fine with me.
