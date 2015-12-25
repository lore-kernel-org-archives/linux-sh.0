From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 25 Dec 2015 11:52:36 +0000
Subject: [PATCH v2 1/6] arm64: renesas: r8a7795: add usb2_phy device nodes
Message-Id: <1451044361-5896-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451044361-5896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1451044361-5896-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index bb353cd..89393ea 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -775,5 +775,39 @@
 			clocks = <&cpg CPG_MOD 815>;
 			status = "disabled";
 		};
+
+		usb2_phy0: usb-phy@ee080200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee080200 0 0x700>, <0 0xe6590100 0 0x100>;
+			reg-names = "usb2_host", "hsusb";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			clock-names = "usb2", "hsusb";
+			power-domains = <&cpg>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy1: usb-phy@ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee0a0200 0 0x700>;
+			reg-names = "usb2_host";
+			clocks = <&cpg CPG_MOD 702>;
+			clock-names = "usb2";
+			power-domains = <&cpg>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		usb2_phy2: usb-phy@ee0c0200 {
+			compatible = "renesas,usb2-phy-r8a7795";
+			reg = <0 0xee0c0200 0 0x700>;
+			reg-names = "usb2_host";
+			clocks = <&cpg CPG_MOD 701>;
+			clock-names = "usb2";
+			power-domains = <&cpg>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
 	};
 };
-- 
1.9.1

