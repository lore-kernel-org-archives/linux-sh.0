From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 30 Jul 2012 19:28:47 +0000
Subject: [PATCH 2/2] serial: sh-sci: fix compilation breakage, when DMA is enabled
Message-Id: <Pine.LNX.4.64.1207302125390.28003@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1207302114440.28003@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1207302114440.28003@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-kernel@vger.kernel.org

A recent commit:

commit d6fa5a4e7ab605370fd6c982782f84ef2e6660e7
Author: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
    serial: sh-sci: prepare for conversion to the shdma base library

is not sufficient to update the sh-sci driver to the new shdma driver
layout. This caused compilation breakage, when CONFIG_SERIAL_SH_SCI_DMA
is enabled. This patch trivially fixes the problem by updating the DMA
descriptor manipulation code.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/tty/serial/sh-sci.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d4d8c94..9be296c 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -25,6 +25,7 @@
 
 #include <linux/module.h>
 #include <linux/errno.h>
+#include <linux/sh_dma.h>
 #include <linux/timer.h>
 #include <linux/interrupt.h>
 #include <linux/tty.h>
@@ -1410,8 +1411,8 @@ static void work_fn_rx(struct work_struct *work)
 		/* Handle incomplete DMA receive */
 		struct tty_struct *tty = port->state->port.tty;
 		struct dma_chan *chan = s->chan_rx;
-		struct sh_desc *sh_desc = container_of(desc, struct sh_desc,
-						       async_tx);
+		struct shdma_desc *sh_desc = container_of(desc,
+					struct shdma_desc, async_tx);
 		unsigned long flags;
 		int count;
 
-- 
1.7.2.5

