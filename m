From: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Date: Wed, 14 Mar 2012 07:14:43 +0000
Subject: Re: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer
Message-Id: <4F604563.90000@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4F5DC485.8020607@renesas.com>
In-Reply-To: <4F5DC485.8020607@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi,

> ... You could slightly improve it in 
> my subjective opinion by avoiding an extra assignment in its first part:
...
>  	if (!uart_circ_empty(xmit)) {
> +		s->cookie_tx = 0;
That looks tidier.

>  	} else if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
>  		u16 ctrl = sci_in(port, SCSCR);
>  		sci_out(port, SCSCR, ctrl & ~SCSCR_TIE);
> +		s->cookie_tx = -EINVAL;
I found the assignment should have been in "else" block, but "else if".
(my mistake). Fixed this time as follows, without run-away case.

 	if (!uart_circ_empty(xmit)) {
		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
	} else {
		s->cookie_tx = -EINVAL;
		if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {

> Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Thank you!
I will post the patch attached with it, if new modification above seems
to breaks nothing, after successful one day run (not a smart at all ;)

Thank you,
/yoshii

commit 3e0c3f7537318392123cacbc1264cc8180ad893d
Author: Yoshii Takashi <takashi.yoshii.zj@renesas.com>
Date:   Mon Mar 12 18:40:21 2012 +0900

    serial: sh-sci: fix a race of DMA submit_tx on transfer
    
    When DMA is enabled, sh-sci transfer begins with
     uart_start()
      sci_start_tx()
        if (cookie_tx < 0) schedule_work()
    Then, starts DMA when wq scheduled, -- (A)
     process_one_work()
      work_fn_rx()
       cookie_tx = desc->submit_tx()
    And finishes when DMA transfer ends, -- (B)
     sci_dma_tx_complete()
      async_tx_ack()
      cookie_tx = -EINVAL
      (possible another schedule_work())
    
    This A to B sequence is not reentrant, since controlling variables
    (for example, cookie_tx above) are not queues nor lists. So, they
    must be invoked as A B A B..., otherwise results in kernel crash.
    
    To ensure the sequence, sci_start_tx() seems to test if cookie_tx < 0
    (represents "not used") to call schedule_work().
    But cookie_tx will not be set (to a cookie, also means "used") until
    in the middle of work queue scheduled function work_fn_tx().
    
    This gap between the test and set allows the breakage of the sequence
    under the very frequently call of uart_start().
    Another gap between async_tx_ack() and another schedule_work() results
    in the same issue, too.
    
    This patch introduces a new condition "cookie_tx = 0" just to mark
    it is "busy" and assign it within spin-locked region to fill the gaps.
    
    Signed-off-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
    Reviewed-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 899bbfe..a09d142 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1229,17 +1229,20 @@ static void sci_dma_tx_complete(void *arg)
 	port->icount.tx += sg_dma_len(&s->sg_tx);
 
 	async_tx_ack(s->desc_tx);
-	s->cookie_tx = -EINVAL;
 	s->desc_tx = NULL;
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
 	if (!uart_circ_empty(xmit)) {
+		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
-	} else if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
-		u16 ctrl = sci_in(port, SCSCR);
-		sci_out(port, SCSCR, ctrl & ~SCSCR_TIE);
+	} else {
+		s->cookie_tx = -EINVAL;
+		if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
+			u16 ctrl = sci_in(port, SCSCR);
+			sci_out(port, SCSCR, ctrl & ~SCSCR_TIE);
+		}
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1501,8 +1504,10 @@ static void sci_start_tx(struct uart_port *port)
 	}
 
 	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
-	    s->cookie_tx < 0)
+	    s->cookie_tx < 0) {
+		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
+	}
 #endif
 
 	if (!s->chan_tx || port->type = PORT_SCIFA || port->type = PORT_SCIFB) {


