From: Simon Horman <horms@verge.net.au>
Date: Wed, 08 May 2013 00:54:26 +0000
Subject: Re: [PATCH/RFC 0/6] DMA: shdma: add Device Tree support
Message-Id: <20130508005426.GA23419@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1365632389-2249-1-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1305020936400.17181@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1305020936400.17181@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Thu, May 02, 2013 at 09:47:52AM +0200, Guennadi Liakhovetski wrote:
> Hi Chris, Simon, Vinod (in alphabetical order :-) )
> 
> On Thu, 11 Apr 2013, Guennadi Liakhovetski wrote:
> 
> > This patch series adds Device Tree support to the shdma dmaengine driver 
> > and illustraits its use with the kzm9g-reference board's MMCIF interface.
> 
> Formally patches in this series belong to your 3 trees: 1-3 and 7 
> (documentation, sent later separately) to DMA, 4 and 6 to ARM/shmobile, 5 
> to MMC. However, they can actually be safely applied in any order, as long 
> as per-tree patches are kept together. Even if the DMA portion is applied 
> last, the MMC driver will find DMA DT bindings in the DT, will request 
> channels, but no DMA channels will be found, then the driver will fall 
> back to PIO.
> 
> So, it's up to you to decide, whether to pull these patches separately via 
> respective trees, or have some of them acked and push all of them via one 
> tree.

Hi Guennadi, Hi all,

I apologise for not replying earlier.

I am happy to take these changes through my renesas tree and
request they be pulled into the arm-soc tree provided that there
are acks from Vinod and Chris on the relevant patches.

I am also happy for either Chris or Vinod to take the patches.

To that end, for the two smhobile patches below:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> Thanks
> Guennadi
> 
> > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > 
> > Guennadi Liakhovetski (6):
> >   DMA: shdma: (cosmetic) don't re-calculate a pointer
> >   DMA: shdma: shdma_chan_filter() has to be in shdma-base.h
> >   DMA: shdma: add DT support
> >   ARM: shmobile: sh73a0: add support for the DMA0 controller in DT
> >   mmc: sh_mmcif: add support for Device Tree DMA bindings
> >   ARM: shmobile: kzm9g-reference: add DMA channels to the MMCIF DT
> > 
> >  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts |    3 ++
> >  arch/arm/boot/dts/sh73a0.dtsi                |   36 ++++++++++++++++++
> >  arch/arm/mach-shmobile/setup-sh73a0.c        |    4 ++
> >  drivers/dma/sh/shdma-base.c                  |   51 +++++++++++++++++++++++---
> >  drivers/dma/sh/shdma.c                       |   46 ++++++++++++++++++++----
> >  drivers/mmc/host/sh_mmcif.c                  |   29 +++++++++------
> >  include/linux/sh_dma.h                       |    2 -
> >  include/linux/shdma-base.h                   |    6 +++
> >  8 files changed, 151 insertions(+), 26 deletions(-)
> > 
> > -- 
> > 1.7.2.5
> > 
> > Thanks
> > Guennadi
> > ---
> > Guennadi Liakhovetski, Ph.D.
> > Freelance Open-Source Software Developer
> > http://www.open-technology.de/
> > 
> 
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
> 
