From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 19 Jun 2013 05:53:09 +0000
Subject: [PATCH v2] ARM: shmobile: irqpin: add a DT property to enable masking on parent
Message-Id: <Pine.LNX.4.64.1306190751090.6945@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, devicetree-discuss@lists.ozlabs.org

To disable spurious interrupts, that get triggered on certain hardware, the
irqpin driver masks them on the parent interrupt controller. To specify
such broken devices a .control_parent parameter can be provided in the
platform data. In the DT case we need a property, to do the same.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Magnus Damm <damm@opensource.se>
---

v2: rebased on top of the current tree, also added Acked-by from Magnus

 .../interrupt-controller/renesas,intc-irqpin.txt   |    2 ++
 drivers/irqchip/irq-renesas-intc-irqpin.c          |    7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
index 66fcaf5..1f8b0c5 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,intc-irqpin.txt
@@ -12,3 +12,5 @@ Optional properties:
   properties
 - sense-bitfield-width: width of a single sense bitfield in the SENSE register,
   if different from the default 4 bits
+- control-parent: disable and enable interrupts on the parent interrupt
+  controller, needed for some broken implementations
diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 4aca1b2..82cec63 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -348,11 +348,14 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* deal with driver instance configuration */
-	if (pdata)
+	if (pdata) {
 		memcpy(&p->config, pdata, sizeof(*pdata));
-	else
+	} else {
 		of_property_read_u32(pdev->dev.of_node, "sense-bitfield-width",
 				     &p->config.sense_bitfield_width);
+		p->config.control_parent = of_property_read_bool(pdev->dev.of_node,
+								 "control-parent");
+	}
 	if (!p->config.sense_bitfield_width)
 		p->config.sense_bitfield_width = 4; /* default to 4 bits */
 
-- 
1.7.2.5

