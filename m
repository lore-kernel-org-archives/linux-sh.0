From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Jul 2012 21:39:23 +0000
Subject: Re: [PATCH 9/9 v3] dma: shdma: convert to the shdma base library
Message-Id: <Pine.LNX.4.64.1207262338130.2723@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de> 
 <1336576161-27082-10-git-send-email-g.liakhovetski@gmx.de> 
 <20120725035935.GA30468@linux-sh.org>  <1343285361.1726.8980.camel@vkoul-udesk3>
  <20120726065804.GF30468@linux-sh.org> <1343301622.1726.9021.camel@vkoul-udesk3>
In-Reply-To: <1343301622.1726.9021.camel@vkoul-udesk3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-sh@vger.kernel.org

On Thu, 26 Jul 2012, Vinod Koul wrote:

> On Thu, 2012-07-26 at 15:58 +0900, Paul Mundt wrote:
> > On Thu, Jul 26, 2012 at 12:19:21PM +0530, Vinod Koul wrote:
> > > On Wed, 2012-07-25 at 12:59 +0900, Paul Mundt wrote:
> > > > On Wed, May 09, 2012 at 05:09:21PM +0200, Guennadi Liakhovetski wrote:
> > > > > The shdma base library has originally been extracted from the shdma driver,
> > > > > which now can be converted to actually use it.
> > > > > 
> > > > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > > > > ---
> > > > >  drivers/dma/sh/shdma.c | 1122 ++++++++++++------------------------------------
> > > > >  drivers/dma/sh/shdma.h |   44 +-
> > > > >  include/linux/sh_dma.h |   33 +-
> > > > >  3 files changed, 302 insertions(+), 897 deletions(-)
> > > > > 
> > > > Now that this has hit mainline, the sh-sci with DMA enabled build is
> > > > broken:
> > > > 
> > > >   CC      drivers/tty/serial/sh-sci.o
> > > > drivers/tty/serial/sh-sci.c: In function 'work_fn_rx':
> > > > drivers/tty/serial/sh-sci.c:1413:67: error: dereferencing pointer to incomplete type
> > > > drivers/tty/serial/sh-sci.c:1413:81: warning: type defaults to 'int' in declaration of '__mptr'
> > > > drivers/tty/serial/sh-sci.c:1413:90: warning: initialization from incompatible pointer type
> > > > drivers/tty/serial/sh-sci.c:1413:161: error: invalid use of undefined type 'struct sh_desc'
> > > > drivers/tty/serial/sh-sci.c:1419:83: error: dereferencing pointer to incomplete type
> > > > drivers/tty/serial/sh-sci.c:1419:101: error: dereferencing pointer to incomplete type
> > > > drivers/tty/serial/sh-sci.c:1423:42: error: dereferencing pointer to incomplete type
> > > This was in -next for quite some time :(
> > > 
> > It seems we don't have any configs that have this default-enabled under
> > -next, so it wasn't noticed before. Still, as Guennadi wrote this code
> > I'm surprised it was overlooked.
> So did my script :(
> 
> 
> I tried checking this, struct sh_desc have moved to struct shdma_desc in
> shdma-base.h. But the field partial was dropped, so we need to use
> residue here. But, shdma or base doesn't calculate residue for err
> transactions, so you cannot use it to start a new one.

Hi Vinod, Paul

I'm on a holiday ATM, coming back late Saturday / Sunday. I'll have a look 
at this breakage ASAP and submit a fix.

Thank
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
