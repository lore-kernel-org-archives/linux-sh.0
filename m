From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 30 Sep 2015 06:16:25 +0000
Subject: [PATCH 3/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <1443593787-21224-4-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[horms: minor updates]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v0 [Kazuya Mizuguchi]

v1 [Simon Horman]
* updated filename to salvator-x
* updated patch subject

v2 [Simon Horman]
* Removed spurious update to r8a7795.dtsi introduced in v1
* Removed unused renesas,phy property

v3 [Simon Horman]
* No change but provided PFC driver update in separate patch(set)

v4 [Simon Horman]
* As suggested by Sergei Shtylyov
  - Removed unused phy-reset-gpio property
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 31 ++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 5bae2cc0c61e..d73b46e9673e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -41,6 +41,11 @@
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
 	};
+
+	avb_pins: avb {
+		renesas,groups = "avb_mdc";
+		renesas,function = "avb";
+	};
 };
 
 &scif1 {
@@ -56,3 +61,29 @@
 
 	status = "okay";
 };
+
+&avb {
+	pinctrl-0 = <&avb_pins>;
+	pinctrl-names = "default";
+	renesas,no-ether-link;
+	phy-handle = <&phy0>;
+	status = "okay";
+
+	phy0: ethernet-phy@0 {
+		rxc-skew-ps = <900>;
+		rxdv-skew-ps = <0>;
+		rxd0-skew-ps = <0>;
+		rxd1-skew-ps = <0>;
+		rxd2-skew-ps = <0>;
+		rxd3-skew-ps = <0>;
+		txc-skew-ps = <900>;
+		txen-skew-ps = <0>;
+		txd0-skew-ps = <0>;
+		txd1-skew-ps = <0>;
+		txd2-skew-ps = <0>;
+		txd3-skew-ps = <0>;
+		reg = <0>;
+		interrupt-parent = <&gpio2>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+	};
+};
-- 
2.1.4

