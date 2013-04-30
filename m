From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 30 Apr 2013 07:11:21 +0000
Subject: [PATCH 2/4] dmaengine: add support for DMA multiplexer DT nodes
Message-Id: <1367305883-2997-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1367305883-2997-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1367305883-2997-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

If a slave can use any of several DMA controllers on the system, multiple
DMA descriptors can be listed in its "dmas" DT property with the same
channel name and different DMA controller phandles. However, if multiple
such slaves can use any of a set of DMA controllers on the system, listing
them all in each slave's "dmas" property becomes counterproductive. This
patch adds support for a "dma-mux" DT node, whose sole purpose is to group
such DMA controller DT nodes. Slaves can then specify the group's phandle
in their "dmas" property. DMA controllers, belonging to the same group
must have the same #dma-cells number and use the same slave IDs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 Documentation/devicetree/bindings/dma/dma.txt |   44 +++++++++++++++++++++++++
 drivers/dma/of-dma.c                          |   39 ++++++++++++++++------
 2 files changed, 73 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt
index 8f504e6..a861298 100644
--- a/Documentation/devicetree/bindings/dma/dma.txt
+++ b/Documentation/devicetree/bindings/dma/dma.txt
@@ -31,6 +31,50 @@ Example:
 		dma-requests = <127>;
 	};
 
+* DMA multiplexer
+
+Several DMA controllers with the same #dma-cells number and the same request
+line IDs can be grouped under a DMA multiplexer super-node, if slaves can use
+DMA channels on any of them.
+
+Required property:
+- compatible:		Must include "dma-mux".
+
+Some standard optional properties can be helpful:
+
+Optional properties:
+- compatible:		You will probably also want to include compatibility
+			with "simple-bus" to automatically create platform
+			devices from subnodes.
+- ranges:		Map DMA controller memory areas in the parent address
+			space.
+- #address-cells:	Number of address cells in case automatic propagation
+			with the help of "ranges" doesn't work.
+- #size-cells:		Number of size cells.
+
+Example:
+
+	dmac: dma-mux {
+		compatible = "simple-bus", "dma-mux";
+		ranges;
+
+		dma0: dma@10000000 {
+			#dma-cells = <1>;
+			...
+		};
+
+		dma1: dma@20000000 {
+			#dma-cells = <1>;
+			...
+		};
+	};
+
+	mmc0: mmc@30000000 {
+			dmas = <&dmac 1
+				&dmac 2>;
+			dma-names = "tx", "rx";
+			...
+	};
 
 * DMA client
 
diff --git a/drivers/dma/of-dma.c b/drivers/dma/of-dma.c
index 69d04d2..bd7652b 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -183,8 +183,8 @@ static int of_dma_match_channel(struct device_node *np, char *name, int index,
 	if (strcmp(name, s))
 		return -ENODEV;
 
-	if (of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
-				       dma_spec))
+	if (of_parse_phandle_with_child_args(np, "dmas", "#dma-cells", index,
+					     dma_spec, "dma-mux"))
 		return -ENODEV;
 
 	return 0;
@@ -217,22 +217,41 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 	}
 
 	for (i = 0; i < count; i++) {
+		struct device_node *dma = NULL, *parent;
+		bool is_mux;
+
 		if (of_dma_match_channel(np, name, i, &dma_spec))
 			continue;
 
-		ofdma = of_dma_get_controller(&dma_spec);
+		parent = of_node_get(dma_spec.np->parent);
+		is_mux = of_device_is_compatible(parent, "dma-mux");
 
-		if (!ofdma)
-			continue;
+		do {
+			if (is_mux) {
+				dma = of_get_next_available_child(parent, dma);
+				if (!dma)
+					break;
+				dma_spec.np = dma;
+			}
+
+			ofdma = of_dma_get_controller(&dma_spec);
 
-		chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
+			if (!ofdma)
+				continue;
 
-		of_dma_put_controller(ofdma);
+			chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
 
-		of_node_put(dma_spec.np);
+			of_dma_put_controller(ofdma);
+
+			of_node_put(dma_spec.np);
+
+			if (chan) {
+				of_node_put(parent);
+				return chan;
+			}
+		} while (dma);
 
-		if (chan)
-			return chan;
+		of_node_put(parent);
 	}
 
 	return NULL;
-- 
1.7.2.5

