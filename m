From: Olof Johansson <olof@lixom.net>
Date: Tue, 23 Jul 2013 02:39:07 +0000
Subject: Re: [PATCH] dmaengine: shdma: fix a build failure on platforms with no DMA support
Message-Id: <20130723023907.GC14983@quad.lixom.net>
List-Id: <linux-sh.vger.kernel.org>
References: <1373422152-29976-1-git-send-email-horms+renesas@verge.net.au>
 <20130716012041.GA942@verge.net.au>
In-Reply-To: <20130716012041.GA942@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jul 16, 2013 at 10:20:41AM +0900, Simon Horman wrote:
> On Wed, Jul 10, 2013 at 11:09:12AM +0900, Simon Horman wrote:
> > From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > 
> > On platforms with no support for the shdma dmaengine driver build is
> > currently failing with
> > 
> > drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> > drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'
> > 
> > Fix the breakage by defining shdma_chan_filter to NULL in such
> > configurations.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > [horms+renesas@verge.net.au: Apply change to shdma-base.h instead of sh_dma.h]
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  include/linux/shdma-base.h | 4 ++++
> >  1 file changed, 4 insertions(+)
> 
> > 
> > Hi Vinod,
> > 
> > please consider this fix from Guennadi for v3.11 which I have rebased on top of
> > next-20130709. It fixes a build problem on a number of shmobile defconfigs
> > including bockw.
> 
> Ping.
> 
> Would it be appropriate for me to take this change through my tree?
> It seems to resolve a regression in v3.11-rc1.

I'll take it through arm-soc since there's no response from Vinod. I've
applied it in the fixes branch we have.


-Olof
