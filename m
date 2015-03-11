From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 11 Mar 2015 05:39:53 +0000
Subject: [PATCH v2 1/2] dmaengine: renesas,usb-dmac: Add device tree bindings documentation
Message-Id: <1426052394-5556-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1426052394-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1426052394-5556-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, dan.j.williams@intel.com, laurent.pinchart@ideasonboard.com, horms@verge.net.au, kuninori.morimoto.gx@renesas.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Document the device tree bindings for the Renesas USB DMA
Controller (USB-DMAC).

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 .../devicetree/bindings/dma/renesas,usb-dmac.txt   | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt

diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
new file mode 100644
index 0000000..040f365
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
@@ -0,0 +1,37 @@
+* Renesas USB DMA Controller Device Tree bindings
+
+Required Properties:
+- compatible: must contain "renesas,usb-dmac"
+- reg: base address and length of the registers block for the DMAC
+- interrupts: interrupt specifiers for the DMAC, one for each entry in
+  interrupt-names.
+- interrupt-names: one entry per channel, named "ch%u", where %u is the
+  channel number ranging from zero to the number of channels minus one.
+- clocks: a list of phandle + clock-specifier pairs.
+- #dma-cells: must be <1>, the cell specifies the channel number of the DMAC
+  port connected to the DMA client.
+- dma-channels: number of DMA channels
+
+Example: R8A7790 (R-Car H2) USB-DMACs
+
+	usb_dmac0: dma-controller@e65a0000 {
+		compatible = "renesas,usb-dmac";
+		reg = <0 0xe65a0000 0 0x100>;
+		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
+			      0 109 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "ch0", "ch1";
+		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC0>;
+		#dma-cells = <1>;
+		dma-channels = <2>;
+	};
+
+	usb_dmac1: dma-controller@e65b0000 {
+		compatible = "renesas,usb-dmac";
+		reg = <0 0xe65b0000 0 0x100>;
+		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
+			      0 110 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "ch0", "ch1";
+		clocks = <&mstp3_clks R8A7790_CLK_USBDMAC1>;
+		#dma-cells = <1>;
+		dma-channels = <2>;
+	};
-- 
1.9.1

