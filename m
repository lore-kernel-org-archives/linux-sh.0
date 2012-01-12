From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 12 Jan 2012 01:57:39 +0000
Subject: Re: [PATCH v4 1/6] dmaengine: shdma: add IRQ resource name definition macros
Message-Id: <20120112015739.GC7281@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F0D39E7.4020102@renesas.com>
In-Reply-To: <4F0D39E7.4020102@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 12, 2012 at 10:54:49AM +0900, Shimoda, Yoshihiro wrote:
> 2012/01/12 10:04, Paul Mundt wrote:
> > On Wed, Jan 11, 2012 at 04:27:35PM +0900, Shimoda, Yoshihiro wrote:
> >> The SH DMAC has an ERROR IRQ and channel IRQs. So, the defination
> >> macros are used as the resource name, and the resource name will be
> >> used to detect each IRQ by the driver.
> >>
> >> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> >> ---
> >>  about v4:
> >>   - add defination macros for IRQ resource first.
> >>
> >>  include/linux/sh_dma.h |    4 ++++
> >>  1 files changed, 4 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/include/linux/sh_dma.h b/include/linux/sh_dma.h
> >> index cb2dd11..a6c82cc 100644
> >> --- a/include/linux/sh_dma.h
> >> +++ b/include/linux/sh_dma.h
> >> @@ -13,6 +13,10 @@
> >>  #include <linux/list.h>
> >>  #include <linux/dmaengine.h>
> >>
> >> +/* resource name of IORESOURCE_IRQ */
> >> +#define SH_DMA_IRQ_ERROR	"error"
> >> +#define SH_DMA_IRQ_CHANNEL	"channel"
> >> +
> > Why? This is just pointless churn, there's nothing wrong with using the
> > strings open-coded like the vast majority of other drivers/platforms do
> > without issue. If you can't spell it properly, too bad.
> > 
> 
> Thank you for your point.
> I read your comment, I thought that it is good.
> 
> I am mixed up about the shdma driver patch for the Error IRQ registration...
> I am thinking that the v3 patches are good because they have Paul's "Acked-by".
> 
Yes, the v3 patches are fine. There's no particular need for stop-gap
transition patches as we'll have these error string patches in place for
the relevant platforms long before these patches hit mainline, and
anything out of tree obviously doesn't matter.
