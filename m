From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 21 Apr 2011 13:08:46 +0000
Subject: [PATCH] serial: sh-sci: suspend/resume wakeup support V2
Message-Id: <20110421130846.3032.33724.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20110419104344.23764.93511.sendpatchset@t400s>
In-Reply-To: <20110419104344.23764.93511.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds wakeup support to the sh-sci driver. The serial
core deals with all details but defaults to wakeup disabled. So
to make use of this feature enable wakeup in sysfs:

echo enabled > /sys/class/tty/ttySC0/power/wakeup

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Changes since V1:
 - drop device_init_wakeup() and enable/disable_irq_wake() bits
 - let port->irq point out receive IRQ 

 drivers/tty/serial/sh-sci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2011-04-21 17:53:17.000000000 +0900
@@ -1777,7 +1777,7 @@ static int __devinit sci_init_single(str
 	 *
 	 * For the muxed case there's nothing more to do.
 	 */
-	port->irq		= p->irqs[SCIx_TXI_IRQ];
+	port->irq		= p->irqs[SCIx_RXI_IRQ];
 
 	if (p->dma_dev)
 		dev_dbg(port->dev, "DMA device %p, tx %d, rx %d\n",
