From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 12 Sep 2015 22:30:05 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: add internal PCI bridge nodes
Message-Id: <3051459.2yiprFO374@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
In-Reply-To: <3151312.grtDDBsSl8@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add device nodes for the R8A7794 internal PCI bridge devices.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7794.dtsi |   42 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7794.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7794.dtsi
+++ renesas/arch/arm/boot/dts/r8a7794.dtsi
@@ -648,6 +648,48 @@
 		status = "disabled";
 	};
 
+	pci0: pci@ee090000 {
+		compatible = "renesas,pci-r8a7794";
+		device_type = "pci";
+		reg = <0 0xee090000 0 0xc00>,
+		      <0 0xee080000 0 0x1100>;
+		interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+
+		bus-range = <0 0>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		ranges = <0x02000000 0 0xee080000 0 0xee080000 0 0x00010000>;
+		interrupt-map-mask = <0xff00 0 0 0x7>;
+		interrupt-map = <0x0000 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+				 0x0800 0 0 1 &gic 0 108 IRQ_TYPE_LEVEL_HIGH
+				 0x1000 0 0 2 &gic 0 108 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pci1: pci@ee0d0000 {
+		compatible = "renesas,pci-r8a7794";
+		device_type = "pci";
+		reg = <0 0xee0d0000 0 0xc00>,
+		      <0 0xee0c0000 0 0x1100>;
+		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_EHCI>;
+		power-domains = <&cpg_clocks>;
+		status = "disabled";
+
+		bus-range = <1 1>;
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		ranges = <0x02000000 0 0xee0c0000 0 0xee0c0000 0 0x00010000>;
+		interrupt-map-mask = <0xff00 0 0 0x7>;
+		interrupt-map = <0x0000 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
+				 0x0800 0 0 1 &gic 0 113 IRQ_TYPE_LEVEL_HIGH
+				 0x1000 0 0 2 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;

