From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 23 Jun 2014 02:28:35 +0000
Subject: [PATCH 26/29] ARM: shmobile: r8a7791: Add PCIe Controller device node
Message-Id: <811cdfae502137a21b91326ed6912a94d3dc7723.1403487225.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403487225.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403487225.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Phil Edworthy <phil.edworthy@renesas.com>

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 7f7eda7..43d2130 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -960,4 +960,29 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	pciec: pcie@fe000000 {
+		compatible = "renesas,pcie-r8a7791";
+		reg = <0 0xfe000000 0 0x80000>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x00 0xff>;
+		device_type = "pci";
+		ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
+			  0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
+			  0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
+			  0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
+		/* Map all possible DDR as inbound ranges */
+		dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x80000000
+			      0x43000000 2 0x00000000 2 0x00000000 1 0x00000000>;
+		interrupts = <0 116 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 117 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 118 IRQ_TYPE_LEVEL_HIGH>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic 0 116 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7791_CLK_PCIEC>, <&pcie_bus_clk>;
+		clock-names = "pcie", "pcie_bus";
+		status = "disabled";
+	};
 };
-- 
2.0.0.rc2

