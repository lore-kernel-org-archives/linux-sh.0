From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Aug 2015 02:29:51 +0000
Subject: [PATCH 14/25 v7][RFC] arm64: renesas: r8a7795: add device nodes of EHCI and OHCI
Message-Id: <878u91777n.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v7

 - based on Gen3 v7 patch-set

 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 60 ++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 7503948..5ee10c3 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -160,5 +160,65 @@
 			#phy-cells = <0>;
 			status = "disabled";
 		};
+
+		ehci0: usb@ee080100 {
+			compatible = "renesas,ehci-r8a7795", "generic-ehci";
+			reg = <0 0xee080100 0 0xff>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI0>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci1: usb@ee0a0100 {
+			compatible = "renesas,ehci-r8a7795", "generic-ehci";
+			reg = <0 0xee0a0100 0 0xff>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI1>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ehci2: usb@ee0c0100 {
+			compatible = "renesas,ehci-r8a7795", "generic-ehci";
+			reg = <0 0xee0c0100 0 0xff>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI2>;
+			phys = <&usb2_phy2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci0: usb@ee080000 {
+			compatible = "renesas,ohci-r8a7795", "generic-ohci";
+			reg = <0 0xee080000 0 0xff>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI0>;
+			phys = <&usb2_phy0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci1: usb@ee0a0000 {
+			compatible = "renesas,ohci-r8a7795", "generic-ohci";
+			reg = <0 0xee0a0000 0 0xff>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI1>;
+			phys = <&usb2_phy1>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
+		ohci2: usb@ee0c0000 {
+			compatible = "renesas,ohci-r8a7795", "generic-ohci";
+			reg = <0 0xee0c0000 0 0xff>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI2>;
+			phys = <&usb2_phy2>;
+			phy-names = "usb";
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1

