From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 13 Feb 2012 12:17:35 +0000
Subject: Re: [PATCH 2/2] usb: fix renesas_usbhs to not schedule in atomic context
Message-Id: <Pine.LNX.4.64.1202131316220.8277@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202092313560.18719@axis700.grange>
 <Pine.LNX.4.64.1202092316180.18719@axis700.grange>
 <20120213120814.GP6614@legolas.emea.dhcp.ti.com>
In-Reply-To: <20120213120814.GP6614@legolas.emea.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Felipe Balbi <balbi@ti.com>
Cc: linux-usb@vger.kernel.org, "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Paul Mundt <lethal@linux-sh.org>

On Mon, 13 Feb 2012, Felipe Balbi wrote:

> Hi,
> 
> On Thu, Feb 09, 2012 at 11:17:51PM +0100, Guennadi Liakhovetski wrote:
> > @@ -997,7 +991,7 @@ static bool usbhsf_dma_filter(struct dma_chan *chan, void *param)
> >  	 *
> >  	 * usbhs doesn't recognize id = 0 as valid DMA
> >  	 */
> > -	if (0 = slave->slave_id)
> > +	if (0 = slave->simple_slave.slave_id)
> >  		return false;
> >  
> >  	chan->private = slave;
> > @@ -1176,8 +1170,8 @@ int usbhs_fifo_probe(struct usbhs_priv *priv)
> >  	fifo->port	= D0FIFO;
> >  	fifo->sel	= D0FIFOSEL;
> >  	fifo->ctr	= D0FIFOCTR;
> > -	fifo->tx_slave.slave_id	= usbhs_get_dparam(priv, d0_tx_id);
> > -	fifo->rx_slave.slave_id	= usbhs_get_dparam(priv, d0_rx_id);
> > +	fifo->tx_slave.simple_slave.slave_id	= usbhs_get_dparam(priv, d0_tx_id);
> > +	fifo->rx_slave.simple_slave.slave_id	= usbhs_get_dparam(priv, d0_rx_id);
> 
> what are these "simple_slave" changes ? They have nothing to do with
> $SUBJECT ? In fact, breaks my gadget branch.

Hrrrm... Right, sorry, that's clearly unrelated...

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
