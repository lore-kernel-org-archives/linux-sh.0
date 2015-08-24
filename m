From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:12:14 +0000
Subject: [PATCH 2/3] arm64: renesas: r8a7795 dtsi: Add CPG/MSTP Clock Domain
Message-Id: <1440432735-9906-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1440432577-9767-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440432577-9767-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add an appropriate "#power-domain-cells" property to the cpg_clocks
device node, to create the CPG/MSTP Clock Domain.

Add "power-domains" properties to all device nodes for devices that are
part of the CPG/MSTP Clock Domain and can be power-managed through an
MSTP clock.  This applies to most on-SoC devices, which have a
one-to-one mapping from SoC device to DT device node.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Add "power-domains" properties to recently-added EHCI and OHCI
    device nodes.
  - Note that usb2_phy*-nodes are skipped!
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 46e68c040cc925dd..1c71c8c8a42a9a24 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -91,6 +91,7 @@
 				clocks = <&extal_clk>;
 				clock-output-names = "main", "pll0", "pll1","pll2",
 						     "pll3", "pll4";
+				#power-domain-cells = <0>;
 
 				mstp3_clks: mstp3_clks@e615013c {
 					compatible = "renesas,r8a7795-mstp-clocks",
@@ -129,6 +130,7 @@
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp3_clks R8A7795_CLK_SCIF2>;
 			clock-names = "sci_ick";
+			power-domains = <&cpg_clocks>;
 		};
 
 		usb2_phy0: usb-phy@ee080200 {
@@ -167,6 +169,7 @@
 			reg = <0 0xee080100 0 0xff>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp7_clks R8A7795_CLK_EHCI0>;
+			power-domains = <&cpg_clocks>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			status = "disabled";
@@ -177,6 +180,7 @@
 			reg = <0 0xee0a0100 0 0xff>;
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp7_clks R8A7795_CLK_EHCI1>;
+			power-domains = <&cpg_clocks>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -187,6 +191,7 @@
 			reg = <0 0xee0c0100 0 0xff>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp7_clks R8A7795_CLK_EHCI2>;
+			power-domains = <&cpg_clocks>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
 			status = "disabled";
@@ -197,6 +202,7 @@
 			reg = <0 0xee080000 0 0xff>;
 			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp7_clks R8A7795_CLK_EHCI0>;
+			power-domains = <&cpg_clocks>;
 			phys = <&usb2_phy0>;
 			phy-names = "usb";
 			status = "disabled";
@@ -207,6 +213,7 @@
 			reg = <0 0xee0a0000 0 0xff>;
 			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp7_clks R8A7795_CLK_EHCI1>;
+			power-domains = <&cpg_clocks>;
 			phys = <&usb2_phy1>;
 			phy-names = "usb";
 			status = "disabled";
@@ -217,6 +224,7 @@
 			reg = <0 0xee0c0000 0 0xff>;
 			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp7_clks R8A7795_CLK_EHCI2>;
+			power-domains = <&cpg_clocks>;
 			phys = <&usb2_phy2>;
 			phy-names = "usb";
 			status = "disabled";
-- 
1.9.1

