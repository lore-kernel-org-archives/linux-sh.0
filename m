From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 09 May 2012 15:09:17 +0000
Subject: [PATCH 5/9 v3] serial: sh-sci: prepare for conversion to the shdma base library
Message-Id: <1336576161-27082-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1336576161-27082-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Alan Cox <alan@linux.intel.com>

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Alan Cox <alan@linux.intel.com>
---
 drivers/tty/serial/sh-sci.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bf461cf..49e3b2a 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1579,9 +1579,9 @@ static bool filter(struct dma_chan *chan, void *slave)
 	struct sh_dmae_slave *param = slave;
 
 	dev_dbg(chan->device->dev, "%s: slave ID %d\n", __func__,
-		param->slave_id);
+		param->shdma_slave.slave_id);
 
-	chan->private = param;
+	chan->private = &param->shdma_slave;
 	return true;
 }
 
@@ -1620,7 +1620,7 @@ static void sci_request_dma(struct uart_port *port)
 	param = &s->param_tx;
 
 	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_TX */
-	param->slave_id = s->cfg->dma_slave_tx;
+	param->shdma_slave.slave_id = s->cfg->dma_slave_tx;
 
 	s->cookie_tx = -EINVAL;
 	chan = dma_request_channel(mask, filter, param);
@@ -1648,7 +1648,7 @@ static void sci_request_dma(struct uart_port *port)
 	param = &s->param_rx;
 
 	/* Slave ID, e.g., SHDMA_SLAVE_SCIF0_RX */
-	param->slave_id = s->cfg->dma_slave_rx;
+	param->shdma_slave.slave_id = s->cfg->dma_slave_rx;
 
 	chan = dma_request_channel(mask, filter, param);
 	dev_dbg(port->dev, "%s: RX: got channel %p\n", __func__, chan);
-- 
1.7.2.5

