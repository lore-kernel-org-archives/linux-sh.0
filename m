From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 21 Jan 2009 15:13:50 +0000
Subject: [PATCH 002/013] sh-sci: allow single port platform devices
Message-Id: <20090121151350.29269.50560.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Allow registration of single port sh-sci platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/serial/sh-sci.c |  125 +++++++++++++++++++++++++++--------------------
 1 file changed, 72 insertions(+), 53 deletions(-)

--- 0002/drivers/serial/sh-sci.c
+++ work/drivers/serial/sh-sci.c	2009-01-19 20:09:21.000000000 +0900
@@ -1234,6 +1234,70 @@ static int __devexit sci_remove(struct p
 	return 0;
 }
 
+static int __devinit sci_probe_single(struct platform_device *dev,
+				      unsigned int index,
+				      struct plat_sci_port *p,
+				      struct sci_port *sciport)
+{
+	struct sh_sci_priv *priv = platform_get_drvdata(dev);
+	unsigned long flags;
+	int ret;
+
+	/* Sanity check */
+	if (unlikely(index >= SCI_NPORTS)) {
+		dev_notice(&dev->dev, "Attempting to register port "
+			   "%d when only %d are available.\n",
+			   index+1, SCI_NPORTS);
+		dev_notice(&dev->dev, "Consider bumping "
+			   "CONFIG_SERIAL_SH_SCI_NR_UARTS!\n");
+		return 0;
+	}
+
+	sciport->port.mapbase	= p->mapbase;
+
+	if (p->mapbase && !p->membase) {
+		if (p->flags & UPF_IOREMAP) {
+			p->membase = ioremap_nocache(p->mapbase, 0x40);
+			if (IS_ERR(p->membase))
+				return PTR_ERR(p->membase);
+		} else {
+			/*
+			 * For the simple (and majority of) cases
+			 * where we don't need to do any remapping,
+			 * just cast the cookie directly.
+			 */
+			p->membase = (void __iomem *)p->mapbase;
+		}
+	}
+
+	sciport->port.membase	= p->membase;
+
+	sciport->port.irq	= p->irqs[SCIx_TXI_IRQ];
+	sciport->port.flags	= p->flags;
+	sciport->port.dev	= &dev->dev;
+
+	sciport->type		= sciport->port.type = p->type;
+
+	memcpy(&sciport->irqs, &p->irqs, sizeof(p->irqs));
+
+	ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
+
+	if (ret) {
+		if (p->flags & UPF_IOREMAP)
+			iounmap(p->membase);
+
+		return ret;
+	}
+
+	INIT_LIST_HEAD(&sciport->node);
+
+	spin_lock_irqsave(&priv->lock, flags);
+	list_add(&sciport->node, &priv->ports);
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 /*
  * Register a set of serial devices attached to a platform device.  The
  * list is terminated with a zero flags entry, which means we expect
@@ -1245,7 +1309,6 @@ static int __devinit sci_probe(struct pl
 	struct plat_sci_port *p = dev->dev.platform_data;
 	struct sh_sci_priv *priv;
 	int i, ret = -EINVAL;
-	unsigned long flags;
 
 	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -1260,60 +1323,16 @@ static int __devinit sci_probe(struct pl
 	cpufreq_register_notifier(&priv->clk_nb, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
 
-	for (i = 0; p && p->flags != 0; p++, i++) {
-		struct sci_port *sciport = &sci_ports[i];
-
-		/* Sanity check */
-		if (unlikely(i = SCI_NPORTS)) {
-			dev_notice(&dev->dev, "Attempting to register port "
-				   "%d when only %d are available.\n",
-				   i+1, SCI_NPORTS);
-			dev_notice(&dev->dev, "Consider bumping "
-				   "CONFIG_SERIAL_SH_SCI_NR_UARTS!\n");
-			break;
-		}
-
-		sciport->port.mapbase	= p->mapbase;
-
-		if (p->mapbase && !p->membase) {
-			if (p->flags & UPF_IOREMAP) {
-				p->membase = ioremap_nocache(p->mapbase, 0x40);
-				if (IS_ERR(p->membase)) {
-					ret = PTR_ERR(p->membase);
-					goto err_unreg;
-				}
-			} else {
-				/*
-				 * For the simple (and majority of) cases
-				 * where we don't need to do any remapping,
-				 * just cast the cookie directly.
-				 */
-				p->membase = (void __iomem *)p->mapbase;
-			}
-		}
-
-		sciport->port.membase	= p->membase;
-
-		sciport->port.irq	= p->irqs[SCIx_TXI_IRQ];
-		sciport->port.flags	= p->flags;
-		sciport->port.dev	= &dev->dev;
-
-		sciport->type		= sciport->port.type = p->type;
-
-		memcpy(&sciport->irqs, &p->irqs, sizeof(p->irqs));
-
-		ret = uart_add_one_port(&sci_uart_driver, &sciport->port);
-
-		if (ret && (p->flags & UPF_IOREMAP)) {
-			iounmap(p->membase);
+	if (dev->id != -1) {
+		ret = sci_probe_single(dev, dev->id, p, &sci_ports[dev->id]);
+		if (ret)
 			goto err_unreg;
+	} else {
+		for (i = 0; p && p->flags != 0; p++, i++) {
+			ret = sci_probe_single(dev, i, p, &sci_ports[i]);
+			if (ret)
+				goto err_unreg;
 		}
-
-		INIT_LIST_HEAD(&sciport->node);
-
-		spin_lock_irqsave(&priv->lock, flags);
-		list_add(&sciport->node, &priv->ports);
-		spin_unlock_irqrestore(&priv->lock, flags);
 	}
 
 #ifdef CONFIG_SH_STANDARD_BIOS
