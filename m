From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 19 Apr 2011 10:43:44 +0000
Subject: [PATCH] serial: sh-sci: suspend/resume wakeup support
Message-Id: <20110419104344.23764.93511.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds wakeup support to the sh-sci driver. As usual,
device_init_wakeup() and enable_irq_wake()/disable_irq_wake()
are used to determine if the port should be suspended/resumed
as usual or if it should be enabled to act as a wakeup source.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/tty/serial/sh-sci.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

--- 0001/drivers/tty/serial/sh-sci.c
+++ work/drivers/tty/serial/sh-sci.c	2011-04-19 18:32:51.000000000 +0900
@@ -1962,7 +1962,11 @@ static int __devinit sci_probe_single(st
 	if (ret)
 		return ret;
 
-	return uart_add_one_port(&sci_uart_driver, &sciport->port);
+	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
+	if (!ret)
+		device_init_wakeup(&dev->dev, 1);
+
+	return ret;
 }
 
 static int __devinit sci_probe(struct platform_device *dev)
@@ -2007,8 +2011,12 @@ static int sci_suspend(struct device *de
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
-		uart_suspend_port(&sci_uart_driver, &sport->port);
+	if (sport) {
+		if (device_may_wakeup(dev))
+			enable_irq_wake(sport->cfg->irqs[SCIx_RXI_IRQ]);
+		else
+			uart_suspend_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
@@ -2017,8 +2025,12 @@ static int sci_resume(struct device *dev
 {
 	struct sci_port *sport = dev_get_drvdata(dev);
 
-	if (sport)
-		uart_resume_port(&sci_uart_driver, &sport->port);
+	if (sport) {
+		if (device_may_wakeup(dev))
+			disable_irq_wake(sport->cfg->irqs[SCIx_RXI_IRQ]);
+		else
+			uart_resume_port(&sci_uart_driver, &sport->port);
+	}
 
 	return 0;
 }
