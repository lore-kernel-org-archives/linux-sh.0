From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 31 Jul 2014 00:34:07 +0000
Subject: [PATCH 4/6] dmaengine: rcar-dmac: Add device tree bindings documentation
Message-Id: <3dc5d31428846326bf122a2a9b402a2a80e97681.1406766014.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1406766014.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1406766014.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Vinod Koul <vinod.koul@intel.com>
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, devicetree@vger.kernel.org, Simon Horman <horms+renesas@verge.net.au>

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Document the device tree bindings for the R-Car Generation 2 DMA
Controller (DMAC).

Cc: devicetree@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/dma/renesas,rcar-dmac.txt  | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
new file mode 100644
index 0000000..df0f48b
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -0,0 +1,98 @@
+* Renesas R-Car DMA Controller Device Tree bindings
+
+Renesas R-Car Generation 2 SoCs have have multiple multi-channel DMA
+controller instances named DMAC capable of serving multiple clients. Channels
+can be dedicated to specific clients or shared between a large number of
+clients.
+
+DMA clients are connected to the DMAC ports referenced by an 8-bit identifier
+called MID/RID.
+
+Each DMA client is connected to one dedicated port of the DMAC, identified by
+an 8-bit port number called the MID/RID. A DMA controller can thus serve up to
+256 clients in total. When the number of hardware channels is lower than the
+number of clients to be served, channels must be shared between multiple DMA
+clients. The association of DMA clients to DMAC channels is fully dynamic and
+not described in these device tree bindings.
+
+Required Properties:
+
+- compatible: must contain "renesas,rcar-dmac"
+
+- reg: base address and length of the registers block for the DMAC
+
+- interrupts: interrupt specifiers for the DMAC, one for each entry in
+  interrupt-names.
+- interrupt-names: one entry per channel, named "ch%u", where %u is the
+  channel number ranging from zero to the number of channels minus one.
+
+- clock-names: "fck" for the functional clock
+- clocks: a list of phandle + clock-specifier pairs, one for each entry
+  in clock-names.
+- clock-names: must contain "fck" for the functional clock.
+
+- #dma-cells: must be <1>, the cell specifies the MID/RID of the DMAC port
+  connected to the DMA client
+- dma-channels: number of DMA channels
+
+Example: R8A7790 (R-Car H2) SYS-DMACs
+
+	dmac0: dma-controller@e6700000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xe6700000 0 0x20000>;
+		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
+			      0 200 IRQ_TYPE_LEVEL_HIGH
+			      0 201 IRQ_TYPE_LEVEL_HIGH
+			      0 202 IRQ_TYPE_LEVEL_HIGH
+			      0 203 IRQ_TYPE_LEVEL_HIGH
+			      0 204 IRQ_TYPE_LEVEL_HIGH
+			      0 205 IRQ_TYPE_LEVEL_HIGH
+			      0 206 IRQ_TYPE_LEVEL_HIGH
+			      0 207 IRQ_TYPE_LEVEL_HIGH
+			      0 208 IRQ_TYPE_LEVEL_HIGH
+			      0 209 IRQ_TYPE_LEVEL_HIGH
+			      0 210 IRQ_TYPE_LEVEL_HIGH
+			      0 211 IRQ_TYPE_LEVEL_HIGH
+			      0 212 IRQ_TYPE_LEVEL_HIGH
+			      0 213 IRQ_TYPE_LEVEL_HIGH
+			      0 214 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14";
+		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
+
+	dmac1: dma-controller@e6720000 {
+		compatible = "renesas,rcar-dmac";
+		reg = <0 0xe6720000 0 0x20000>;
+		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
+			      0 216 IRQ_TYPE_LEVEL_HIGH
+			      0 217 IRQ_TYPE_LEVEL_HIGH
+			      0 218 IRQ_TYPE_LEVEL_HIGH
+			      0 219 IRQ_TYPE_LEVEL_HIGH
+			      0 308 IRQ_TYPE_LEVEL_HIGH
+			      0 309 IRQ_TYPE_LEVEL_HIGH
+			      0 310 IRQ_TYPE_LEVEL_HIGH
+			      0 311 IRQ_TYPE_LEVEL_HIGH
+			      0 312 IRQ_TYPE_LEVEL_HIGH
+			      0 313 IRQ_TYPE_LEVEL_HIGH
+			      0 314 IRQ_TYPE_LEVEL_HIGH
+			      0 315 IRQ_TYPE_LEVEL_HIGH
+			      0 316 IRQ_TYPE_LEVEL_HIGH
+			      0 317 IRQ_TYPE_LEVEL_HIGH
+			      0 318 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "error",
+				"ch0", "ch1", "ch2", "ch3",
+				"ch4", "ch5", "ch6", "ch7",
+				"ch8", "ch9", "ch10", "ch11",
+				"ch12", "ch13", "ch14";
+		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
+		clock-names = "fck";
+		#dma-cells = <1>;
+		dma-channels = <15>;
+	};
-- 
2.0.1

