From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 13 Mar 2012 11:47:27 +0000
Subject: Re: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer
Message-Id: <Pine.LNX.4.64.1203131227470.14461@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4F5DC485.8020607@renesas.com>
In-Reply-To: <4F5DC485.8020607@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, 13 Mar 2012, Takashi Yoshii wrote:

> Thank you for your reply.
> 
> > It looks like sci_start_tx() can be called asynchronously - before the 
> > previous request has completed. In such a case we have to actually protect 
> > the whole function. 
> Perhaps.
> Low level debugging shows sci_start_tx() called twice before work_fn_tx(), just before the issue occurs.
> I don't know if this frequent calls is an erroneous behavior or not, though.

It is not as such, but it is not currently correctly processed.

> > ... Please, check whether this slightly simpler patch 
> > works for you too. 
> Not working. (it crashes)
> 
> I applied only
> > +	    !s->desc_tx)
> (You mean *!*s->desc_tx, don't you? Otherwise no output)

Yes, right, thanks for catching.

> Spin-locks are not needed (and should not be) here, because this function
> is called with lock held.

Ok, good point, .start_tx() is called by serial_core.c under the same 
spinlock. But we also call sci_start_tx() internally from a couple of 
locations, so, there we should be taking the spinlock too.

> > ... If it does, we can then actually completely remove the 
> > cookie_tx member of struct sci_port:
> Doing same as my patch with desc_tx instead of cookie_tx, introducing
> other special value like desc_tx=1 or so, is OK. Because what is done
> by the patch is manual mutex by flag variable, choice of the variable
> is not a problem.
> 
> The problem seems to be that I don't know how the .start_tx() should
> be called. Shall we go to linux-serial ML?

You can certainly add linux-serial to CC if you like. But, I think, your 
patch looks good and is actually correct. You could slightly improve it in 
my subjective opinion by avoiding an extra assignment in its first part:

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 8b99aac..3be3dfa 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1229,17 +1229,18 @@ static void sci_dma_tx_complete(void *arg)
 	port->icount.tx += sg_dma_len(&s->sg_tx);
 
 	async_tx_ack(s->desc_tx);
-	s->cookie_tx = -EINVAL;
 	s->desc_tx = NULL;
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
 	if (!uart_circ_empty(xmit)) {
+		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
 	} else if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
 		u16 ctrl = sci_in(port, SCSCR);
 		sci_out(port, SCSCR, ctrl & ~SCSCR_TIE);
+		s->cookie_tx = -EINVAL;
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);

The bottom part remains the same. So, either with or without this change 
you can add my

Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
