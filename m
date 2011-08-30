From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Aug 2011 07:54:04 +0000
Subject: Re: [PATCH] serial: sh-sci: don't filter on DMA device, use only
Message-Id: <Pine.LNX.4.64.1108300931220.19151@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1106241354060.6014@axis700.grange> 
 <1308916071.1536.4.camel@vkoul-udesk3>  <20110829080047.GJ31809@linux-sh.org>
  <CANqRtoRn-Csu+Rns6dn6=cJmRqbZfLKXA9brs8Ug9rFvGRn78w@mail.gmail.com>
 <1314618931.1606.114.camel@vkoul-udesk3>
In-Reply-To: <1314618931.1606.114.camel@vkoul-udesk3>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Magnus Damm <damm@opensource.se>

On Mon, 29 Aug 2011, Vinod Koul wrote:

> On Mon, 2011-08-29 at 17:16 +0900, Magnus Damm wrote:
> > On Mon, Aug 29, 2011 at 5:00 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > > On Fri, Jun 24, 2011 at 05:17:51PM +0530, Koul, Vinod wrote:
> > >> On Fri, 2011-06-24 at 13:56 +0200, Guennadi Liakhovetski wrote:
> > >> > On some sh-mobile systems there are more than one DMA controllers, that
> > >> > can be used for serial ports. Specifying a DMA device in sh-sci platform
> > >> > data unnecessarily restricts the driver to only use one DMA controller.
> > >> >
> > >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > >> > ---
> > >> >  drivers/tty/serial/sh-sci.c |   25 ++++++++-----------------
> > >> >  include/linux/serial_sci.h  |    2 --
> > >> >  2 files changed, 8 insertions(+), 19 deletions(-)
> > >> >
> > >> > diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> > >> > index ebd8629..8711f4e 100644
> > >> > --- a/drivers/tty/serial/sh-sci.c
> > >> > +++ b/drivers/tty/serial/sh-sci.c
> > >> > @@ -1295,12 +1295,8 @@ static bool filter(struct dma_chan *chan, void *slave)
> > >> >     dev_dbg(chan->device->dev, "%s: slave ID %d\n", __func__,
> > >> >             param->slave_id);
> > >> >
> > >> > -   if (param->dma_dev = chan->device->dev) {
> > >> > -           chan->private = param;
> > >> > -           return true;
> > >> > -   } else {
> > >> > -           return false;
> > >> > -   }
> > >> > +   chan->private = param;
> > >> > +   return true;
> > >> You should not assign chan->private.
> > >> Please move this  to dma_slave_control API
> > >
> > > I haven't seen any reply to this comment and this patch seems to still be
> > > outstanding, is there an updated version of this patch that I've missed?
> I don't recall seeing any updated version fixing this 

As a matter of fact, when you say "use dma_slave_control API," you 
actually mean the dma_slave_config, right? Then, how is one supposed to 
use it in this case? Shall we be issuing a DMA_SLAVE_CONFIG call inside of 
the filter and check the return code? The problem is, that not all DMA 
controllers on sh-mobile SoCs can service the same slave devices. So, if 
we don't check in the filter we might well get an unsuitable DMA channel.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
