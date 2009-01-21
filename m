From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:13:42 +0000
Subject: [PATCH 001/013] sh-sci: add platform device private data
Message-Id: <20090121151342.29269.60430.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds per-platform private data to the sh-sci driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c |  131 +++++++++++++++++++++++++++++++----------------
 1 file changed, 87 insertions(+), 44 deletions(-)

--- 0001/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-20 16:33:04.000000000 +0900
@@ -47,6 +47,7 @@
 #include <linux/clk.h>
 #include <linux/ctype.h>
 #include <linux/err.h>
+#include <linux/list.h>
 
 #ifdef CONFIG_SUPERH
 #include <asm/clock.h>
@@ -78,6 +79,16 @@ struct sci_port {
 	/* Port clock */
 	struct clk		*clk;
 #endif
+	struct list_head	node;
+};
+
+struct sh_sci_priv {
+	spinlock_t lock;
+	struct list_head ports;
+
+#ifdef CONFIG_HAVE_CLK
+	struct notifier_block clk_nb;
+#endif
 };
 
 #ifdef CONFIG_SERIAL_SH_SCI_CONSOLE
@@ -724,19 +735,22 @@ static irqreturn_t sci_mpxed_interrupt(i
 static int sci_notifier(struct notifier_block *self,
 			unsigned long phase, void *p)
 {
-	int i;
+	struct sh_sci_priv *priv = container_of(self,
+						struct sh_sci_priv, clk_nb);
+	struct sci_port *sci_port;
+	unsigned long flags;
 
 	if ((phase = CPUFREQ_POSTCHANGE) ||
-	    (phase = CPUFREQ_RESUMECHANGE))
-		for (i = 0; i < SCI_NPORTS; i++) {
-			struct sci_port *s = &sci_ports[i];
-			s->port.uartclk = clk_get_rate(s->clk);
-		}
+	    (phase = CPUFREQ_RESUMECHANGE)) {
+		spin_lock_irqsave(&priv->lock, flags);
+		list_for_each_entry(sci_port, &priv->ports, node)
+			sci_port->port.uartclk = clk_get_rate(sci_port->clk);
+
+		spin_unlock_irqrestore(&priv->lock, flags);
+	}
 
 	return NOTIFY_OK;
 }
-
-static struct notifier_block sci_nb = { &sci_notifier, NULL, 0 };
 #endif
 
 static int sci_request_irq(struct sci_port *port)
@@ -1199,6 +1213,27 @@ static struct uart_driver sci_uart_drive
 	.cons		= SCI_CONSOLE,
 };
 
+
+static int __devexit sci_remove(struct platform_device *dev)
+{
+	struct sh_sci_priv *priv = platform_get_drvdata(dev);
+	struct sci_port *p;
+	unsigned long flags;
+
+#ifdef CONFIG_HAVE_CLK
+	cpufreq_unregister_notifier(&priv->clk_nb, CPUFREQ_TRANSITION_NOTIFIER);
+#endif
+
+	spin_lock_irqsave(&priv->lock, flags);
+	list_for_each_entry(p, &priv->ports, node)
+		uart_remove_one_port(&sci_uart_driver, &p->port);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	kfree(priv);
+	return 0;
+}
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -1208,7 +1243,22 @@ static struct uart_driver sci_uart_drive
 static int __devinit sci_probe(struct platform_device *dev)
 {
 	struct plat_sci_port *p = dev->dev.platform_data;
+	struct sh_sci_priv *priv;
 	int i, ret = -EINVAL;
+	unsigned long flags;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&priv->ports);
+	spin_lock_init(&priv->lock);
+	platform_set_drvdata(dev, priv);
+
+#ifdef CONFIG_HAVE_CLK
+	priv->clk_nb.notifier_call = sci_notifier;
+	cpufreq_register_notifier(&priv->clk_nb, CPUFREQ_TRANSITION_NOTIFIER);
+#endif
 
 	for (i = 0; p && p->flags != 0; p++, i++) {
 		struct sci_port *sciport = &sci_ports[i];
@@ -1252,12 +1302,19 @@ static int __devinit sci_probe(struct pl
 
 		memcpy(&sciport->irqs, &p->irqs, sizeof(p->irqs));
 
-		uart_add_one_port(&sci_uart_driver, &sciport->port);
-	}
+		ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
 
-#ifdef CONFIG_HAVE_CLK
-	cpufreq_register_notifier(&sci_nb, CPUFREQ_TRANSITION_NOTIFIER);
-#endif
+		if (ret && (p->flags & UPF_IOREMAP)) {
+			iounmap(p->membase);
+			goto err_unreg;
+		}
+
+		INIT_LIST_HEAD(&sciport->node);
+
+		spin_lock_irqsave(&priv->lock, flags);
+		list_add(&sciport->node, &priv->ports);
+		spin_unlock_irqrestore(&priv->lock, flags);
+	}
 
 #ifdef CONFIG_SH_STANDARD_BIOS
 	sh_bios_gdb_detach();
@@ -1266,50 +1323,36 @@ static int __devinit sci_probe(struct pl
 	return 0;
 
 err_unreg:
-	for (i = i - 1; i >= 0; i--)
-		uart_remove_one_port(&sci_uart_driver, &sci_ports[i].port);
-
+	sci_remove(dev);
 	return ret;
 }
 
-static int __devexit sci_remove(struct platform_device *dev)
-{
-	int i;
-
-#ifdef CONFIG_HAVE_CLK
-	cpufreq_unregister_notifier(&sci_nb, CPUFREQ_TRANSITION_NOTIFIER);
-#endif
-
-	for (i = 0; i < SCI_NPORTS; i++)
-		uart_remove_one_port(&sci_uart_driver, &sci_ports[i].port);
-
-	return 0;
-}
-
 static int sci_suspend(struct platform_device *dev, pm_message_t state)
 {
-	int i;
+	struct sh_sci_priv *priv = platform_get_drvdata(dev);
+	struct sci_port *p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	list_for_each_entry(p, &priv->ports, node)
+		uart_suspend_port(&sci_uart_driver, &p->port);
 
-	for (i = 0; i < SCI_NPORTS; i++) {
-		struct sci_port *p = &sci_ports[i];
-
-		if (p->type != PORT_UNKNOWN && p->port.dev = &dev->dev)
-			uart_suspend_port(&sci_uart_driver, &p->port);
-	}
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
 
 static int sci_resume(struct platform_device *dev)
 {
-	int i;
+	struct sh_sci_priv *priv = platform_get_drvdata(dev);
+	struct sci_port *p;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	list_for_each_entry(p, &priv->ports, node)
+		uart_resume_port(&sci_uart_driver, &p->port);
 
-	for (i = 0; i < SCI_NPORTS; i++) {
-		struct sci_port *p = &sci_ports[i];
-
-		if (p->type != PORT_UNKNOWN && p->port.dev = &dev->dev)
-			uart_resume_port(&sci_uart_driver, &p->port);
-	}
+	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
 }
