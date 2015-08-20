From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 20 Aug 2015 06:29:10 +0000
Subject: [PATCH 3/7][RFC] arm64: dts: r8a7795: add usb-phy device nodes
Message-Id: <1440052154-3768-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 6930048..cd6629c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -129,5 +129,36 @@
 			clocks = <&mstp3_clks R8A7795_CLK_SCIF2>;
 			clock-names = "sci_ick";
 		};
+
+		usb2_phy0: usb-phy@ee080200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee080200 0 0x6ff>, <0 0xe6590100 0 0x100>;
+			reg-names = "usb2", "hsusb";
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI0>,
+				 <&mstp7_clks R8A7795_CLK_HSUSB>;
+			clock-names = "usb2", "hsusb";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy@ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee0a0200 0 0x6ff>;
+			reg-names = "usb2";
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI1>;
+			clock-names = "usb2";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy2: usb-phy@ee0c0200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee0c0200 0 0x6ff>;
+			reg-names = "usb2";
+			clocks = <&mstp7_clks R8A7795_CLK_EHCI2>;
+			clock-names = "usb2";
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1

