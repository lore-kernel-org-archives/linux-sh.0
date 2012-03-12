From: Yoshii Takashi <takashi.yoshii.zj@renesas.com>
Date: Mon, 12 Mar 2012 09:40:21 +0000
Subject: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer
Message-Id: <4F5DC485.8020607@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, Guennadi.

I believe I've found a small bug in DMA handling of sh-sci, and made a patch attached.
This shows good result -- the issue can't be reproduced -- but, I'm afraid I am not
confident of the correctness of the fix in logic/theory.
Would you please see it and give some comments or ack?

--
The test to reproduce the issue is simple as follows.
$ stty -F /dev/ttySC0 115200 # faster is better, I think.
$ while :; do dd if=/dev/zero bs  count00 of=/dev/ttySC0; done

in about half an hour on sh7757lcr board(with DMA enabled locally),
(and, in few seconds ape5r SMP system(one of kota2's variation) here),
it stops as

| Unable to handle kernel NULL pointer dereference at virtual address 00000004
| pc = 801cca66
| *pde = 8ee51000
| Oops: 0000 [#1]
| Modules linked in:
| 
| Pid : 232, Comm: 		kworker/0:1
| CPU : 0        		Not tainted  (3.3.0-rc4-00037-gc671a05-dirty #104)
| 
| PC is at sci_dma_tx_complete+0x46/0x120
...

Apparently, this is because async_tx_ack(s->desc_tx) at sci_dma_tx_complete() is
called when s->desc_tx is NULL.
Detailed trace showed the mechanism of the issue as a description of attached patch.

Thank you.
/yoshii

--
From 8fb99cf51248b9b2a73ea9e849823bd71ac81769 Mon Sep 17 00:00:00 2001
From: Takashi YOSHII <takashi.yoshii.zj@renesas.com>
Date: Fri, 10 Feb 2012 15:54:07 +0900
Subject: [PATCH] sh-sci: fix a race of DMA submit_tx on transfer

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
---
 drivers/tty/serial/sh-sci.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 7508579..107db7a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1229,7 +1229,7 @@ static void sci_dma_tx_complete(void *arg)
 	port->icount.tx += sg_dma_len(&s->sg_tx);
 
 	async_tx_ack(s->desc_tx);
-	s->cookie_tx = -EINVAL;
+	s->cookie_tx = 0;
 	s->desc_tx = NULL;
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
@@ -1240,6 +1240,7 @@ static void sci_dma_tx_complete(void *arg)
 	} else if (port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
 		u16 ctrl = sci_in(port, SCSCR);
 		sci_out(port, SCSCR, ctrl & ~SCSCR_TIE);
+		s->cookie_tx = -EINVAL;
 	}
 
 	spin_unlock_irqrestore(&port->lock, flags);
@@ -1501,8 +1502,10 @@ static void sci_start_tx(struct uart_port *port)
 	}
 
 	if (s->chan_tx && !uart_circ_empty(&s->port.state->xmit) &&
-	    s->cookie_tx < 0)
+	    s->cookie_tx < 0) {
+		s->cookie_tx = 0;
 		schedule_work(&s->work_tx);
+	}
 #endif
 
 	if (!s->chan_tx || port->type = PORT_SCIFA || port->type = PORT_SCIFB) {
-- 1.7.3.4

