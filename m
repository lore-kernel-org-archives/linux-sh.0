From: Bastian Hecht <hechtb@gmail.com>
Date: Tue, 19 Feb 2013 17:29:54 +0000
Subject: [PATCH 1/3] serial: sh-sci: Add Device Tree probing
Message-Id: <1361298586-30357-2-git-send-email-hechtb+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We add the capabilty to probe SH SCI devices using Device Tree setup. We
split SoC dependent config data from board dependent data and store it
inside the driver. Support for the SoCs sh7372, sh73a0, r8a7740 and
r8a7779 has been added. The required fields for booting via DT are
documented in renesas,sh-sci-serial.txt.

This is an early draft and needs still discussion about SoC/board
related properties.

Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
---
 .../bindings/tty/serial/renesas,sh-sci-serial.txt  |   27 +++++
 drivers/tty/serial/sh-sci.c                        |  120 +++++++++++++++++++-
 2 files changed, 143 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt

diff --git a/Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt b/Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt
new file mode 100644
index 0000000..69df44d
--- /dev/null
+++ b/Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt
@@ -0,0 +1,27 @@
+* Renesas SH-Mobile Serial Communication Interface
+
+Required properties:
+- compatible : Should be "renesas,shmobile-sci-hwb-<x>", where <x> denotes a
+  hardware block version number of the following list - choose it according
+  to your SoC in use.
+  1: sh7372, sh73a0, r8a7740
+  2: r8a7779
+- reg : Address and length of the register set for the device
+- interrupts : Should contain the following IRQs: ERI, RXI, TXI and BRI.
+- renesas,serial-type : Specifies the type of the serial port.
+	0: SCI
+	1: SCIF
+	2: IRDA
+	3: SCIFA
+	4: SCIFB
+- cell-index : The device id.
+
+Example:
+        sci@0xe6c50000 {
+                compatible = "renesas,shmobile-sci-hwb-1";
+                interrupt-parent = <&intca>;
+                reg = <0xe6c50000 0x100>;
+                interrupts = <0x0c20>, <0x0c20>, <0x0c20>, <0x0c20>;
+                cell-index = <1>;
+                renesas,serial-type = <3>;
+        };
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 6147756..4f3613d 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -2353,6 +2353,106 @@ static int sci_remove(struct platform_device *dev)
 	return 0;
 }
 
+#ifdef CONFIG_OF
+/*
+ * We provide setup data for different hardware block versionis. See
+ * Documentation/devicetree/bindings/tty/serial/renesas,sh-sci-serial.txt
+ * for further information.
+ */
+static struct plat_sci_port sci_drv_data_hwb_1 = {
+	.flags		= UPF_BOOT_AUTOCONF,
+	.scscr		= SCSCR_RE | SCSCR_TE,
+	.scbrr_algo_id	= SCBRR_ALGO_4,
+};
+
+static struct plat_sci_port sci_drv_data_hwb_2 = {
+	.flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP,
+	.scscr		= SCSCR_RE | SCSCR_TE | SCSCR_CKE1,
+	.scbrr_algo_id	= SCBRR_ALGO_2,
+};
+
+static const struct of_device_id of_sci_match[] = {
+	{ .compatible = "renesas,shmobile-sci-hwb-1",
+		.data = &sci_drv_data_hwb_1 },
+	{ .compatible = "renesas,shmobile-sci-hwb-2",
+		.data = &sci_drv_data_hwb_2 },
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_sci_match);
+
+/* This array corresponds to the DT binding definition of the SCI driver */
+static const char sci_serial_modes[] = {
+	PORT_SCI, PORT_SCIF, PORT_IRDA, PORT_SCIFA, PORT_SCIFB
+};
+
+static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
+								int *dev_id)
+{
+	struct plat_sci_port *p;
+	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *match;
+	struct resource *res;
+	const __be32 *prop;
+	int i, irq;
+
+	match = of_match_node(of_sci_match, pdev->dev.of_node);
+	if (!match || !match->data) {
+		dev_err(&pdev->dev, "OF match error\n");
+		return NULL;
+	}
+
+	/*
+	 * Switch to devm_kmalloc if it will be added to the kernel, as we
+	 * will copy match->data that is correctly zeroed for unused fields
+	 */
+	p = devm_kzalloc(&pdev->dev, sizeof(struct plat_sci_port), GFP_KERNEL);
+	if (!p) {
+		dev_err(&pdev->dev, "failed to allocate DT config data\n");
+		return NULL;
+	}
+
+	memcpy(p, match->data, sizeof(struct plat_sci_port));
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		dev_err(&pdev->dev, "failed to get I/O memory\n");
+		return NULL;
+	}
+	p->mapbase = res->start;
+
+	for (i = 0; i < SCIx_NR_IRQS; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0) {
+			dev_err(&pdev->dev, "failed to get irq data %d\n", i);
+			return NULL;
+		}
+		p->irqs[i] = irq;
+	}
+
+	prop = of_get_property(np, "cell-index", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev, "device id missing\n");
+		return NULL;
+	}
+	*dev_id = be32_to_cpup(prop);
+
+	prop = of_get_property(np, "renesas,serial-type", NULL);
+	if (!prop) {
+		dev_err(&pdev->dev, "serial type missing\n");
+		return NULL;
+	}
+	p->type = sci_serial_modes[be32_to_cpup(prop)];
+
+	return p;
+}
+#else
+static struct plat_sci_port *sci_parse_dt(struct platform_device *pdev,
+								int *dev_id)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF */
+
 static int sci_probe_single(struct platform_device *dev,
 				      unsigned int index,
 				      struct plat_sci_port *p,
@@ -2385,9 +2485,9 @@ static int sci_probe_single(struct platform_device *dev,
 
 static int sci_probe(struct platform_device *dev)
 {
-	struct plat_sci_port *p = dev->dev.platform_data;
-	struct sci_port *sp = &sci_ports[dev->id];
-	int ret;
+	struct plat_sci_port *p;
+	struct sci_port *sp;
+	int ret, dev_id = dev->id;
 
 	/*
 	 * If we've come here via earlyprintk initialization, head off to
@@ -2397,9 +2497,20 @@ static int sci_probe(struct platform_device *dev)
 	if (is_early_platform_device(dev))
 		return sci_probe_earlyprintk(dev);
 
+	if (dev->dev.of_node)
+		p = sci_parse_dt(dev, &dev_id);
+	else
+		p = dev->dev.platform_data;
+
+	if (!p) {
+		dev_err(&dev->dev, "no setup data supplied\n");
+		return -EINVAL;
+	}
+
+	sp = &sci_ports[dev_id];
 	platform_set_drvdata(dev, sp);
 
-	ret = sci_probe_single(dev, dev->id, p, sp);
+	ret = sci_probe_single(dev, dev_id, p, sp);
 	if (ret)
 		return ret;
 
@@ -2451,6 +2562,7 @@ static struct platform_driver sci_driver = {
 		.name	= "sh-sci",
 		.owner	= THIS_MODULE,
 		.pm	= &sci_dev_pm_ops,
+		.of_match_table = of_match_ptr(of_sci_match),
 	},
 };
 
-- 
1.7.9.5

