From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 14 Sep 2015 12:14:23 +0000
Subject: [PATCH 01/14] serial: sh-sci: Drop the interface clock
Message-Id: <1442232876-27629-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, devicetree@vger.kernel.org

As no platform defines an interface clock the SCI driver always fall
back to a clock named "peripheral_clk". On SH platform that clock is the
base clock for the SCI functional clock and has the same frequency. On
ARM platforms that clock doesn't exist, and clk_get() will return the
default clock for the device. We can thus make the functional clock
mandatory and drop the interface clock.

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/serial/renesas,sci-serial.txt         |  4 +-
 drivers/tty/serial/sh-sci.c                        | 60 +++++++++++++---------
 2 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
index e84b13a8eda3..c390860bc23f 100644
--- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
+++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
@@ -40,7 +40,7 @@ Required properties:
 
   - clocks: Must contain a phandle and clock-specifier pair for each entry
     in clock-names.
-  - clock-names: Must contain "sci_ick" for the SCIx UART interface clock.
+  - clock-names: Must contain "fck" for the SCIx UART functional clock.
 
 Note: Each enabled SCIx UART should have an alias correctly numbered in the
 "aliases" node.
@@ -61,7 +61,7 @@ Example:
 		interrupt-parent = <&gic>;
 		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
-		clock-names = "sci_ick";
+		clock-names = "fck";
 		dmas = <&dmac0 0x21>, <&dmac0 0x22>;
 		dma-names = "tx", "rx";
 	};
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 1b2f894bdc9e..56e4b2639d99 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -91,8 +91,6 @@ struct sci_port {
 	struct timer_list	break_timer;
 	int			break_flag;
 
-	/* Interface clock */
-	struct clk		*iclk;
 	/* Function clock */
 	struct clk		*fclk;
 
@@ -465,9 +463,8 @@ static void sci_port_enable(struct sci_port *sci_port)
 
 	pm_runtime_get_sync(sci_port->port.dev);
 
-	clk_prepare_enable(sci_port->iclk);
-	sci_port->port.uartclk = clk_get_rate(sci_port->iclk);
 	clk_prepare_enable(sci_port->fclk);
+	sci_port->port.uartclk = clk_get_rate(sci_port->fclk);
 }
 
 static void sci_port_disable(struct sci_port *sci_port)
@@ -484,7 +481,6 @@ static void sci_port_disable(struct sci_port *sci_port)
 	sci_port->break_flag = 0;
 
 	clk_disable_unprepare(sci_port->fclk);
-	clk_disable_unprepare(sci_port->iclk);
 
 	pm_runtime_put_sync(sci_port->port.dev);
 }
@@ -1085,7 +1081,7 @@ static int sci_notifier(struct notifier_block *self,
 		struct uart_port *port = &sci_port->port;
 
 		spin_lock_irqsave(&port->lock, flags);
-		port->uartclk = clk_get_rate(sci_port->iclk);
+		port->uartclk = clk_get_rate(sci_port->fclk);
 		spin_unlock_irqrestore(&port->lock, flags);
 	}
 
@@ -2181,6 +2177,38 @@ static struct uart_ops sci_uart_ops = {
 #endif
 };
 
+static int sci_init_clocks(struct sci_port *sci_port, struct device *dev)
+{
+	/* Get the SCI functional clock. It's called "fck" on ARM. */
+	sci_port->fclk = clk_get(dev, "fck");
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	/*
+	 * But it used to be called "sci_ick", and we need to maintain DT
+	 * backward compatibility.
+	 */
+	sci_port->fclk = clk_get(dev, "sci_ick");
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	/* SH has historically named the clock "sci_fck". */
+	sci_port->fclk = clk_get(dev, "sci_fck");
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	/*
+	 * Not all SH platforms declare a clock lookup entry for SCI devices, in
+	 * which case we need to get the global "peripheral_clk" clock.
+	 */
+	sci_port->fclk = clk_get(dev, "peripheral_clk");
+	if (!IS_ERR(sci_port->fclk))
+		return 0;
+
+	dev_err(dev, "failed to get functional clock\n");
+	return PTR_ERR(sci_port->fclk);
+}
+
 static int sci_init_single(struct platform_device *dev,
 			   struct sci_port *sci_port, unsigned int index,
 			   struct plat_sci_port *p, bool early)
@@ -2274,22 +2302,9 @@ static int sci_init_single(struct platform_device *dev,
 				: sampling_rate;
 
 	if (!early) {
-		sci_port->iclk = clk_get(&dev->dev, "sci_ick");
-		if (IS_ERR(sci_port->iclk)) {
-			sci_port->iclk = clk_get(&dev->dev, "peripheral_clk");
-			if (IS_ERR(sci_port->iclk)) {
-				dev_err(&dev->dev, "can't get iclk\n");
-				return PTR_ERR(sci_port->iclk);
-			}
-		}
-
-		/*
-		 * The function clock is optional, ignore it if we can't
-		 * find it.
-		 */
-		sci_port->fclk = clk_get(&dev->dev, "sci_fck");
-		if (IS_ERR(sci_port->fclk))
-			sci_port->fclk = NULL;
+		ret = sci_init_clocks(sci_port, &dev->dev);
+		if (ret < 0)
+			return ret;
 
 		port->dev = &dev->dev;
 
@@ -2339,7 +2354,6 @@ static int sci_init_single(struct platform_device *dev,
 
 static void sci_cleanup_single(struct sci_port *port)
 {
-	clk_put(port->iclk);
 	clk_put(port->fclk);
 
 	pm_runtime_disable(port->port.dev);
-- 
2.4.6

