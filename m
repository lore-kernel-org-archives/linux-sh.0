From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 Jun 2013 15:47:24 +0000
Subject: [PATCH 2/3] dmaengine: add support for DMA multiplexer DT nodes
Message-Id: <1370533645-23690-3-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1370533645-23690-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1370533645-23690-1-git-send-email-g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>

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
 drivers/dma/of-dma.c                          |   31 +++++++++++++----
 2 files changed, 67 insertions(+), 8 deletions(-)

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
index 7aa0864..ec58022 100644
--- a/drivers/dma/of-dma.c
+++ b/drivers/dma/of-dma.c
@@ -146,8 +146,8 @@ static int of_dma_match_channel(struct device_node *np, const char *name,
 	if (strcmp(name, s))
 		return -ENODEV;
 
-	if (of_parse_phandle_with_args(np, "dmas", "#dma-cells", index,
-				       dma_spec))
+	if (of_parse_phandle_with_child_args(np, "dmas", "#dma-cells", index,
+					     dma_spec, "dma-mux"))
 		return -ENODEV;
 
 	return 0;
@@ -165,7 +165,7 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 {
 	struct of_phandle_args	dma_spec;
 	struct of_dma		*ofdma;
-	struct dma_chan		*chan;
+	struct dma_chan		*chan = NULL;
 	int			count, i;
 
 	if (!np || !name) {
@@ -180,20 +180,35 @@ struct dma_chan *of_dma_request_slave_channel(struct device_node *np,
 	}
 
 	for (i = 0; i < count; i++) {
+		struct device_node *dma = NULL, *parent;
+		bool is_mux;
+
 		if (of_dma_match_channel(np, name, i, &dma_spec))
 			continue;
 
 		mutex_lock(&of_dma_lock);
-		ofdma = of_dma_find_controller(&dma_spec);
+		parent = of_node_get(dma_spec.np->parent);
+		is_mux = of_device_is_compatible(parent, "dma-mux");
+
+		do {
+			/* If we're in a mux, try all nodes */
+			if (is_mux) {
+				dma = of_get_next_available_child(parent, dma);
+				if (!dma)
+					break;
+				dma_spec.np = dma;
+			}
+
+			ofdma = of_dma_find_controller(&dma_spec);
 
-		if (ofdma)
-			chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
-		else
-			chan = NULL;
+			if (ofdma)
+				chan = ofdma->of_dma_xlate(&dma_spec, ofdma);
+		} while (dma && !chan);
 
 		mutex_unlock(&of_dma_lock);
 
 		of_node_put(dma_spec.np);
+		of_node_put(parent);
 
 		if (chan)
 			return chan;
-- 
1.7.2.5

